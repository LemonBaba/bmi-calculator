import '../database/app_database.dart';

class GoalModel {
  final GoalData goal;
  final CategoryData? category;

  GoalModel(this.goal, this.category);
}