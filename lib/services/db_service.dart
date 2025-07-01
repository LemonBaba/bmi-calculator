import 'package:drift/drift.dart';
import '../models/BmiEntryModel.dart';
import '../models/GoalModel.dart';
import '../database/app_database.dart';
import 'package:flutter/foundation.dart';

class DbService {
  final AppDatabase db;

  DbService(this.db);

  // USER
  Future<bool> userExists(String username) async {
    final query = db.select(db.user)..where((u) => u.username.equals(username));
    final user = await query.getSingleOrNull();
    return user != null;
  }

  Future<void> registerUser(String username, String password) async {
    await db.into(db.user).insert(
      UserCompanion(
        username: Value(username),
        password: Value(password),
      ),
    );
  }

  Future<UserData?> loginUser(String username, String password) async {
    final query = db.select(db.user)
      ..where((u) => u.username.equals(username) & u.password.equals(password));
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
    await deleteDuplicateUnachievedGoals(userId);

    final lastEntry = await getLatestEntry(userId);
    if (lastEntry == null) return;

    createAchievements(lastEntry, userId);
  }

  Future<List<BmiEntryModel>> getBmiEntries(int userId) async {
    final entryQuery = db.select(db.bmiEntry).join([
      innerJoin(db.category, db.category.id.equalsExp(db.bmiEntry.categoryId))
    ])
      ..where(db.bmiEntry.userId.equals(userId));

    final entryRows = await entryQuery.get();
    final entryIds = entryRows.map((row) => row.readTable(db.bmiEntry).id).toList();

    final achievementQuery = db.select(db.goalAchievement).join([
      innerJoin(db.goal, db.goal.id.equalsExp(db.goalAchievement.goalId)),
      leftOuterJoin(db.category, db.category.id.equalsExp(db.goal.targetCategory)),
    ])
      ..where(db.goalAchievement.entryId.isIn(entryIds));

    final achievementRows = await achievementQuery.get();

    final Map<int, List<String?>> entryIdToGoalDescriptions = {};

    for (final row in achievementRows) {
      final achievement = row.readTable(db.goalAchievement);
      final goal = row.readTable(db.goal);
      final category = row.readTableOrNull(db.category);

      String? description;
      if (goal.targetCategory != null && category != null) {
        description = category.name;
      } else if (goal.targetBmi != null) {
        description = goal.targetBmi!.toStringAsFixed(1);
      }

      entryIdToGoalDescriptions
          .putIfAbsent(achievement.entryId, () => [])
          .add(description);
    }

    return entryRows.map((row) {
      final entry = row.readTable(db.bmiEntry);
      final category = row.readTable(db.category);
      final goalDescriptions = entryIdToGoalDescriptions[entry.id] ?? [];
      return BmiEntryModel(entry, category, goalName: goalDescriptions.whereType<String>().toList());
    }).toList();
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

  Future<void> deleteDuplicateUnachievedGoals(int userId) async {
    final goals = await getGoalsForUser(userId);
    final unachievedGoals = goals.where((g) => g.achievements.isEmpty).toList();

    // Group unachieved goals by criteria (same targetBmi or targetCategory)
    final Map<String, List<GoalModel>> goalGroups = {};

    for (final g in unachievedGoals) {
      final key = g.goal.targetCategory != null
          ? 'category:${g.goal.targetCategory}'
          : g.goal.targetBmi != null
          ? 'bmi:${g.goal.targetBmi!.toStringAsFixed(1)}'
          : 'none';

      goalGroups.putIfAbsent(key, () => []).add(g);
    }

    for (final group in goalGroups.entries) {
      final goals = group.value;

      if (goals.length <= 1) continue;

      // Delete the rest
      for (final g in goals.skip(1)) {
        await deleteGoal(g.goal.id);
      }
    }
  }

  Future<void> markGoalAsAchieved(int goalId, int entryId) async {
    // Ensure the goal isn't already achieved
    final existing = await (db.select(db.goalAchievement)
      ..where((g) => g.goalId.equals(goalId)))
        .getSingleOrNull();

    if (existing != null) {
      throw StateError("Goal $goalId already has an achievement.");
    }

    await db.into(db.goalAchievement).insert(
      GoalAchievementCompanion(
        goalId: Value(goalId),
        entryId: Value(entryId),
        achievementDate: Value(DateTime.now().toIso8601String()),
      ),
    );
  }

  Future<List<GoalModel>> createAchievements(BmiEntryData entry, int userId) async {
    final allGoals = await getGoalsForUser(userId);

    final matchedGoals = allGoals.where((goal) {
      final bmiMatch = goal.goal.targetBmi != null &&
          entry.value.toStringAsFixed(1) == goal.goal.targetBmi!.toStringAsFixed(1);

      final catMatch = goal.goal.targetCategory != null &&
          entry.categoryId == goal.goal.targetCategory;

      final notAchieved = goal.achievements.isEmpty;

      return (bmiMatch || catMatch) && notAchieved;
    }).toList();

    final List<GoalModel> actuallyAchieved = [];

    for (final goal in matchedGoals) {
      // Check if this entry already fulfilled another goal with same targetBmi or targetCategory
      final conflictingAchievement = await (db.select(db.goalAchievement).join([
        innerJoin(db.goal, db.goal.id.equalsExp(db.goalAchievement.goalId))
      ])
        ..where(db.goalAchievement.entryId.equals(entry.id))
        ..where((goal.goal.targetCategory != null)
            ? db.goal.targetCategory.equals(goal.goal.targetCategory!)
            : db.goal.targetBmi.equals(goal.goal.targetBmi!)))
          .getSingleOrNull();

      if (conflictingAchievement != null) {
        // Entry already used to fulfill a goal with same target delete this one
        await deleteGoal(goal.goal.id);
        continue;
      }

      // Check if (goalId, entryId) already exists (just for safety)
      final alreadyExists = await (db.select(db.goalAchievement)
        ..where((ga) =>
        ga.goalId.equals(goal.goal.id) & ga.entryId.equals(entry.id)))
          .getSingleOrNull();

      if (alreadyExists != null) {
        await deleteGoal(goal.goal.id);
        continue;
      }

      try {
        await markGoalAsAchieved(goal.goal.id, entry.id);
      } catch(e) {
        debugPrint('Error: ${e}');
        continue;
      }
      actuallyAchieved.add(goal);
    }

    return actuallyAchieved;
  }
}
