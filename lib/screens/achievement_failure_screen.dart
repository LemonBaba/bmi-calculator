import 'package:bmi_manager/l10n/app_localization_extension.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../models/GoalModel.dart';
import '../l10n/app_localizations.dart';

class AchievementScreen extends StatelessWidget {
  final List<GoalModel> goals;

  const AchievementScreen({super.key, required this.goals});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Lottie.asset(
              'assets/animations/fireworks.json',
              fit: BoxFit.cover,
              repeat: true,
            ),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.all(24),
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.congratulations,
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      ...goals.map((goal) {
                        final goalText = goal.category != null
                            ? AppLocalizations.of(context)!.localizeCategory(goal.category!.name)
                            : goal.goal.targetBmi?.toStringAsFixed(1);
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            AppLocalizations.of(context)!.goal_bmi_achieved(goalText ?? ""),
                            style: Theme.of(context).textTheme.titleMedium,
                            textAlign: TextAlign.center,
                          ),
                        );
                      }).toList(),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(AppLocalizations.of(context)!.back,),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
