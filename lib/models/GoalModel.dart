import '../database/app_database.dart';

class GoalModel {
  final GoalData goal;
  final CategoryData? category;
  final List<GoalAchievementData> achievements;

  GoalModel(this.goal, this.category, this.achievements);

  DateTime? get achievementDate {
    if (achievements.isEmpty) return null;

    return achievements
        .map((a) => DateTime.parse(a.achievementDate))
        .reduce((a, b) => a.isBefore(b) ? a : b);
  }

  bool get isAchieved => achievements.isNotEmpty;
}
