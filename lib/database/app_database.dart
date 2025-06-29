import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'app_database.g.dart';

class User extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get email => text().withLength(min: 1, max: 255).customConstraint('NOT NULL UNIQUE')();
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
  TextColumn get note => text().nullable()();
  BoolColumn get achieved => boolean().withDefault(const Constant(false))();
}

@DriftDatabase(tables: [User, BmiEntry, Goal, Category])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();

      await batch((batch) {
        batch.insertAll(category, [
          CategoryCompanion.insert(name: 'Untergewicht', from: 0, to: 18.5),
          CategoryCompanion.insert(name: 'Normalgewicht', from: 18.5, to: 24.9),
          CategoryCompanion.insert(name: 'Übergewicht', from: 25, to: 29.9),
          CategoryCompanion.insert(name: 'Adipositas I', from: 30, to: 34.9),
          CategoryCompanion.insert(name: 'Adipositas II', from: 35, to: 39.9),
          CategoryCompanion.insert(name: 'Adipositas III', from: 40, to: 100),
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