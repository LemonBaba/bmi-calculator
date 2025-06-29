import 'package:flutter/material.dart';
import '../models/bmi_entry.dart';
import '../services/local_storage_service.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

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

    final entry = BmiEntry(weight: weight, height: height, date: DateTime.now());
    await LocalStorageService.saveEntry(entry);
    setState(() => _result = "BMI: ${entry.bmi.toStringAsFixed(1)}\nKategorie: ${entry.category}");
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