import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  int? _selectedCategoryId;
  BmiEntryData? _lastEntry;

  @override
  void initState() {
    super.initState();
    _loadLastEntry();
  }

  void _loadLastEntry() async {
    final entry = await widget.dbService.getLatestEntry(widget.userId);
    setState(() => _lastEntry = entry);
  }

  @override
  void dispose() {
    _bmiController.dispose();
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
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _bmiController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,1}')),
                    ],
                    enabled: _selectedCategoryId == null,
                    decoration: const InputDecoration(labelText: "Ziel-BMI"),
                    onChanged: (val) {
                      if (val.trim().isNotEmpty) {
                        setState(() => _selectedCategoryId = null);
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _saveGoal,
                    child: const Text("Ziel speichern"),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _saveGoal() async {
    final bmi = double.tryParse(_bmiController.text.trim());

    if (_selectedCategoryId == null && bmi == null) {
      _showError("Bitte entweder Kategorie oder Ziel-BMI angeben.");
      return;
    }

    if (_lastEntry != null) {
      if (_selectedCategoryId != null && _selectedCategoryId == _lastEntry!.categoryId) {
        _showError("Du befindest dich bereits in dieser Kategorie.");
        return;
      }

      if (bmi != null && bmi.toStringAsFixed(1) == _lastEntry!.value.toStringAsFixed(1)) {
        _showError("Dein aktueller BMI entspricht bereits dem Ziel.");
        return;
      }
    }

    final existingGoals = await widget.dbService.getGoalsForUser(widget.userId);
    final duplicateExists = existingGoals.any((goal) {
      if (goal.achievements.isNotEmpty) return false;

      final sameBmi = bmi != null &&
          goal.goal.targetBmi != null &&
          bmi.toStringAsFixed(1) == goal.goal.targetBmi!.toStringAsFixed(1) &&
          goal.achievements.isEmpty;

      final sameCat = _selectedCategoryId != null &&
          goal.goal.targetCategory != null &&
          _selectedCategoryId == goal.goal.targetCategory &&
          goal.achievements.isEmpty;

      return sameBmi || sameCat;
    });

    if (duplicateExists) {
      _showError("Ein gleiches unerreichtes Ziel existiert bereits.");
      return;
    }

    await widget.dbService.insertGoal(
      userId: widget.userId,
      targetBmi: bmi,
      targetCategoryId: _selectedCategoryId,
    );

    if (mounted) Navigator.pop(context);
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
