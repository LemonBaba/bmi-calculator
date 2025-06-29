import 'package:flutter/material.dart';
import '../services/db_service.dart';
import '../database/app_database.dart';

class GoalFormScreen extends StatefulWidget {
  final DbService dbService;
  final int userId;

  const GoalFormScreen({super.key, required this.dbService, required this.userId});

  @override
  State<GoalFormScreen> createState() => _GoalFormScreenState();
}

class _GoalFormScreenState extends State<GoalFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _bmiController = TextEditingController();
  final _noteController = TextEditingController();

  int? _selectedCategoryId;

  @override
  void dispose() {
    _bmiController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Neues Ziel")),
      body: FutureBuilder<List<CategoryData>>(
        future: widget.dbService.getAllCategories(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final categories = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // Kategorie-Auswahl
                  DropdownButtonFormField<int>(
                    value: _selectedCategoryId,
                    decoration: const InputDecoration(labelText: "Kategorie"),
                    items: categories.map((cat) {
                      return DropdownMenuItem(
                        value: cat.id,
                        child: Text("${cat.name} (${cat.from} – ${cat.to})"),
                      );
                    }).toList(),
                    onChanged: (_bmiController.text.isNotEmpty)
                        ? null
                        : (value) => setState(() => _selectedCategoryId = value),
                  ),

                  // Ziel-BMI Eingabe
                  TextFormField(
                    controller: _bmiController,
                    keyboardType: TextInputType.number,
                    enabled: _selectedCategoryId == null,
                    decoration: const InputDecoration(labelText: "Ziel-BMI"),
                    onChanged: (val) {
                      setState(() {
                        if (val.trim().isNotEmpty) {
                          _selectedCategoryId = null;
                        }
                      });
                    },
                  ),

                  // Notizfeld
                  TextFormField(
                    controller: _noteController,
                    decoration: const InputDecoration(labelText: "Notiz (optional)"),
                  ),

                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: _saveGoal,
                    child: const Text("Ziel speichern"),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _saveGoal() async {
    final bmi = double.tryParse(_bmiController.text.trim());
    final note = _noteController.text.trim().isEmpty ? null : _noteController.text.trim();

    if (_selectedCategoryId == null && bmi == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Bitte entweder Kategorie oder Ziel-BMI angeben.")),
      );
      return;
    }

    await widget.dbService.insertGoal(
      userId: widget.userId,
      targetBmi: bmi,
      targetCategoryId: _selectedCategoryId,
      note: note,
    );

    if (mounted) Navigator.pop(context);
  }
}
