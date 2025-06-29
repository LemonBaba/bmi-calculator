import 'package:drift/drift.dart';
import '../models/BmiEntryModel.dart';
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
  Future<void> insertBmiEntry({
    required int userId,
    required int categoryId,
    required double weight,
    required double height,
    required DateTime date,
    required double value,
  }) async {
    await db.into(db.bmiEntry).insert(BmiEntryCompanion(
      userId: Value(userId),
      categoryId: Value(categoryId),
      weight: Value(weight),
      height: Value(height),
      date: Value(date.toIso8601String()),
      value: Value(value),
    ));
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
    String? note,
  }) {
    return db.into(db.goal).insert(GoalCompanion(
      userId: Value(userId),
      targetBmi: Value(targetBmi),
      targetCategory: Value(targetCategoryId),
      note: Value(note),
    ));
  }

  Future<List<GoalData>> getUserGoals(int userId) {
    return (db.select(db.goal)..where((g) => g.userId.equals(userId))).get();
  }

}
