import 'package:flutter/material.dart';
import '../database/app_database.dart';
import '../services/db_service.dart';

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

  void _calculateAndSave() async {
    final weight = double.tryParse(_weightController.text);
    final height = double.tryParse(_heightController.text);
    if (weight == null || height == null) return;
    double bmi = weight / ((height / 100) * (height / 100));

    CategoryData category = await widget.dbService.getCategory(bmi: bmi);
    widget.dbService.insertBmiEntry(userId: widget.userId, categoryId: category.id, weight: weight, height: height, date: DateTime.now(), value: bmi);
    setState(() => _result = "BMI: ${bmi.toStringAsFixed(1)}\nKategorie: ${category.name}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Neue Messung")),
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