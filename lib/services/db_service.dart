import 'package:drift/drift.dart';
import '../models/BmiEntryModel.dart';
import '../models/GoalModel.dart';
import '../database/app_database.dart'; // your Drift database file

class DbService {
  final AppDatabase db;

  DbService(this.db);

  // USER
  Future<bool> userExists(String email) async {
    final query = db.select(db.user)..where((u) => u.email.equals(email));
    final user = await query.getSingleOrNull();
    return user != null;
  }

  Future<void> registerUser(String email, String password) async {
    await db.into(db.user).insert(
      UserCompanion(
        email: Value(email),
        password: Value(password),
      ),
    );
  }

  Future<UserData?> loginUser(String email, String password) async {
    final query = db.select(db.user)
      ..where((u) => u.email.equals(email) & u.password.equals(password));
    return query.getSingleOrNull();
  }

  // BMI Entry
  Future<BmiEntryData> insertBmiEntry({
    required int userId,
    required int categoryId,
    required double weight,
    required double height,
    required DateTime date,
    required double value,
  }) async {
    final id = await db.into(db.bmiEntry).insert(BmiEntryCompanion(
      userId: Value(userId),
      categoryId: Value(categoryId),
      weight: Value(weight),
      height: Value(height),
      date: Value(date.toIso8601String()),
      value: Value(value),
    ));
    return (await (db.select(db.bmiEntry)..where((e) => e.id.equals(id))).getSingle());
  }

  Future<void> deleteBmiEntry(int entryId, int userId) async {
    await (db.delete(db.bmiEntry)..where((e) => e.id.equals(entryId))).go();

    // Get the new latest entry after deletion
    final latest = await getLatestEntry(userId);
    if (latest == null) return;

    // Get all unachieved goals
    final goals = await getGoalsForUser(userId);

    for (final g in goals) {
      final isAchieved = g.achievements.isNotEmpty;
      if (isAchieved) continue;

      final matchesCategory = g.goal.targetCategory != null &&
          g.goal.targetCategory == latest.categoryId;

      final matchesBmi = g.goal.targetBmi != null &&
          g.goal.targetBmi!.toStringAsFixed(1) == latest.value.toStringAsFixed(1);

      // If now fulfilled already delete the unnecessary goal
      if (matchesCategory || matchesBmi) {
        await deleteGoal(g.goal.id);
      }
    }
  }


  Future<List<BmiEntryModel>> getBmiEntries(int userId) async {
    final query = db.select(db.bmiEntry).join([
      innerJoin(db.category, db.category.id.equalsExp(db.bmiEntry.categoryId))
    ])
      ..where(db.bmiEntry.userId.equals(userId));

    return query.map((row) {
      final entry = row.readTable(db.bmiEntry);
      final category = row.readTableOrNull(db.category);

      if (category == null) {
        throw StateError("BmiEntry with ID ${entry.id} has no category.");
      }

      return BmiEntryModel(entry, category);
    }).get();
  }

  Future<BmiEntryData?> getLatestEntry(int userId) async {
    return (db.select(db.bmiEntry)
      ..where((e) => e.userId.equals(userId))
      ..orderBy([(e) => OrderingTerm.desc(e.date)])
      ..limit(1))
        .getSingleOrNull();
  }

  // CATEGORIES
  Future<void> insertCategory(String name, double from, double to) {
    return db.into(db.category).insert(CategoryCompanion(
      name: Value(name),
      from: Value(from),
      to: Value(to),
    ));
  }

  Future<List<CategoryData>> getAllCategories() {
    return db.select(db.category).get();
  }

  Future<CategoryData?> getCategoryById(int id) {
    return (db.select(db.category)..where((c) => c.id.equals(id))).getSingleOrNull();
  }

  Future<CategoryData> getCategory({required double bmi}) async {
    final query = await db.select(db.category)
      ..where((tbl) => tbl.from.isSmallerOrEqualValue(bmi) & tbl.to.isBiggerOrEqualValue(bmi));

    final result = await query.getSingleOrNull();

    if (result == null) {
      throw StateError("Keine passende Kategorie für BMI $bmi gefunden.");
    }

    return result;
  }

  // GOALS
  Future<void> insertGoal({
    required int userId,
    double? targetBmi,
    int? targetCategoryId,
  }) {
    return db.into(db.goal).insert(GoalCompanion(
      userId: Value(userId),
      targetBmi: Value(targetBmi),
      targetCategory: Value(targetCategoryId),
    ));
  }

  Future<List<GoalModel>> getGoalsForUser(int userId) async {
    // Fetch all goals with categories
    final goalQuery = db.select(db.goal).join([
      leftOuterJoin(db.category, db.category.id.equalsExp(db.goal.targetCategory))
    ])
      ..where(db.goal.userId.equals(userId));

    final goalRows = await goalQuery.get();

    // Fetch all achievements for the user's goals
    final achievementQuery = db.select(db.goalAchievement).join([
      innerJoin(db.goal, db.goal.id.equalsExp(db.goalAchievement.goalId))
    ])
      ..where(db.goal.userId.equals(userId));

    final achievementRows = await achievementQuery.get();

    // Group achievements by goalId
    final Map<int, List<GoalAchievementData>> achievementsByGoalId = {};

    for (final row in achievementRows) {
      final achievement = row.readTable(db.goalAchievement);
      achievementsByGoalId.putIfAbsent(achievement.goalId, () => []).add(achievement);
    }

    // Build GoalModel list
    return goalRows.map((row) {
      final goal = row.readTable(db.goal);
      final category = row.readTableOrNull(db.category);
      final achievements = achievementsByGoalId[goal.id] ?? [];

      return GoalModel(goal, category, achievements);
    }).toList();
  }


  Future<List<GoalData>> getUserGoals(int userId) {
    return (db.select(db.goal)..where((g) => g.userId.equals(userId))).get();
  }

  Future<void> deleteGoal(int goalId) async {
    await (db.delete(db.goal)..where((g) => g.id.equals(goalId))).go();
  }

  Future<void> markGoalAsAchieved(int goalId, int entryId) async {
    await db.into(db.goalAchievement).insert(
      GoalAchievementCompanion(
        goalId: Value(goalId),
        entryId: Value(entryId),
        achievementDate: Value(DateTime.now().toIso8601String()),
      ),
    );
  }
}
