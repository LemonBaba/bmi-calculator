import 'package:flutter/material.dart';
import 'achievement_failure_screen.dart';
import '../database/app_database.dart';
import '../services/db_service.dart';
import 'categories_screen.dart';

class InputScreen extends StatefulWidget {
  final DbService dbService;
  final int userId;

  const InputScreen({super.key, required this.dbService, required this.userId});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  String? _result;

  @override
  void initState() {
    super.initState();
    _prefillHeight();
  }

  void _prefillHeight() async {
    final lastEntry = await widget.dbService.getLatestEntry(widget.userId);
    if (lastEntry != null) {
      setState(() {
        _heightController.text = lastEntry.height.toStringAsFixed(1);
      });
    }
  }

  void _calculateAndSave() async {
    final weight = double.tryParse(_weightController.text);
    final height = double.tryParse(_heightController.text);
    if (weight == null || height == null) return;
    double bmi = weight / ((height / 100) * (height / 100));

    CategoryData category = await widget.dbService.getCategory(bmi: bmi);
    BmiEntryData insertedEntry = await widget.dbService.insertBmiEntry(userId: widget.userId, categoryId: category.id, weight: weight, height: height, date: DateTime.now(), value: bmi);
    _triggerAchievements(insertedEntry);
    setState(() => _result = "BMI: ${bmi.toStringAsFixed(1)}\nKategorie: ${category.name}");
  }

  void _triggerAchievements(BmiEntryData entry) async {
    final allGoals = await widget.dbService.getGoalsForUser(widget.userId);

    // Collect all matching, unachieved goals
    final matchedGoals = allGoals.where((goal) {
      if (goal.goal.entryId != null) return false; // Already achieved

      final bmiMatch = goal.goal.targetBmi != null &&
          entry.value.toStringAsFixed(1) == goal.goal.targetBmi!.toStringAsFixed(1);

      final catMatch = goal.goal.targetCategory != null &&
          entry.categoryId == goal.goal.targetCategory;

      return bmiMatch || catMatch;
    }).toList();

    // Mark all matched goals as achieved
    for (final goal in matchedGoals) {
      await widget.dbService.markGoalAsAchieved(goal.goal.id, entry.id);
    }

    if (matchedGoals.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => AchievementScreen(goals: matchedGoals),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Neue Messung"),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CategoriesScreen(dbService: widget.dbService, userId: widget.userId)),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _weightController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Gewicht (kg)')),
            TextField(controller: _heightController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Größe (cm)')),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _calculateAndSave, child: const Text("Berechnen & Speichern")),
            if (_result != null) ...[
              const SizedBox(height: 20),
              Text(_result!, textAlign: TextAlign.center, style: const TextStyle(fontSize: 18))
            ]
          ],
        ),
      ),
    );
  }
}