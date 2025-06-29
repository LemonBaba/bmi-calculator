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
      appBar: AppBar(title: const Text("Ziel erreicht")),
      body: Column(
        children: [
          // 🎆 Fullscreen-ish Animation
          Expanded(
            child: Center(
              child: AspectRatio(
                aspectRatio: 1, // or 16/9, or let it fill
                child: Lottie.asset(
                  'assets/animations/fireworks.json',
                  fit: BoxFit.contain,
                  repeat: true,
                ),
              ),
            ),
          ),

          // 🎯 Text content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
            child: Column(
              children: [
                Text(
                  "Glückwunsch!",
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.green),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Zurück zur Übersicht"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
