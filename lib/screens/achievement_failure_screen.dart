import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../models/GoalModel.dart';

class AchievementScreen extends StatelessWidget {
  final GoalModel goal;

  const AchievementScreen({super.key, required this.goal});

  @override
  Widget build(BuildContext context) {
    final message = goal.category != null
        ? "Kategorie-Ziel ${goal.category!.name} erreicht"
        : "BMI-Ziel ${goal.goal.targetBmi!.toStringAsFixed(1)} erreicht";

    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
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
                        "Glückwunsch!",
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        message,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Zurück"),
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
