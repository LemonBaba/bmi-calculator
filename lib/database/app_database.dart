import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'app_database.g.dart';

class User extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get username => text().withLength(min: 1, max: 255).customConstraint('NOT NULL UNIQUE')();
  TextColumn get password => text().withLength(min: 1, max: 255).customConstraint('NOT NULL')();
}

class Category extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  RealColumn get from => real()();
  RealColumn get to => real()();
}

class BmiEntry extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId => integer().references(User, #id)();
  IntColumn get categoryId => integer().references(Category, #id)();
  RealColumn get weight => real()();
  RealColumn get height => real()();
  RealColumn get value => real()();
  TextColumn get date => text()();
}

class Goal extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId => integer().references(User, #id)();
  RealColumn get targetBmi => real().nullable()();
  IntColumn get targetCategory => integer().nullable().references(Category, #id)();
}

class GoalAchievement extends Table {
  IntColumn get goalId => integer().references(Goal, #id, onDelete: KeyAction.cascade)();
  IntColumn get entryId => integer().references(BmiEntry, #id, onDelete: KeyAction.cascade)();
  TextColumn get achievementDate => text()();

  @override
  Set<Column> get primaryKey => {goalId, entryId};
}



@DriftDatabase(tables: [User, BmiEntry, Goal, Category, GoalAchievement])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
      await customStatement('PRAGMA foreign_keys = ON');
      await batch((batch) {
        batch.insertAll(category, [
          CategoryCompanion.insert(name: 'underweight', from: 0, to: 18.5),
          CategoryCompanion.insert(name: 'normal', from: 18.5, to: 24.9),
          CategoryCompanion.insert(name: 'overweight', from: 25, to: 29.9),
          CategoryCompanion.insert(name: 'obesity1', from: 30, to: 34.9),
          CategoryCompanion.insert(name: 'obesity2', from: 35, to: 39.9),
          CategoryCompanion.insert(name: 'obesity3', from: 40, to: 100),
        ]);
      });
    },
  );
}


LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'bmi.sqlite'));
    return NativeDatabase(file);
  });
}

Future<void> resetDatabase() async {
  final dir = await getApplicationDocumentsDirectory();
  final file = File(p.join(dir.path, 'bmi.sqlite'));
  if (await file.exists()) {
    await file.delete();
    print("Database deleted.");
  }
}