import '../database/app_database.dart';

class BmiEntryModel {
  final BmiEntryData entry;
  final CategoryData category;
  final List<String> goalName; // Preloaded descriptions of achieved goals

  BmiEntryModel(
      this.entry,
      this.category, {
        this.goalName = const [],
      });
}


