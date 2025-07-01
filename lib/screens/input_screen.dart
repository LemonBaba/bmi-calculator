import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'achievement_failure_screen.dart';
import 'categories_screen.dart';
import '../utils/utils.dart';
import '../database/app_database.dart';
import '../services/db_service.dart';
import '../l10n/app_localizations.dart';

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

  void _calculateAndSave(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    final weight = double.tryParse(_weightController.text);
    final height = double.tryParse(_heightController.text);
    if (weight == null || height == null) return;

    if (weight < 20 || weight > 300) {
      showError(l10n.weightError, context);
      return;
    }

    if (height < 100 || height > 250) {
      showError(l10n.heightError, context);
      return;
    }

    final bmi = weight / ((height / 100) * (height / 100));
    CategoryData category;
    try {
      category = await widget.dbService.getCategory(bmi: bmi);
    } catch(e) {
      debugPrint('Error: ${e}');
      showError(l10n.error(e), context);
      return;
    }

    final insertedEntry = await widget.dbService.insertBmiEntry(
      userId: widget.userId,
      categoryId: category.id,
      weight: weight,
      height: height,
      date: DateTime.now(),
      value: bmi,
    );

    final isAchievementScreenShown = await _triggerAchievementsCreation(insertedEntry);
    if((!isAchievementScreenShown) && mounted) {
      Navigator.pop(context);
    }
  }

  Future<bool> _triggerAchievementsCreation(BmiEntryData entry) async {
    final triggeredGoals = await widget.dbService.createAchievements(entry, widget.userId);
    if (triggeredGoals.isNotEmpty && mounted) {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => AchievementScreen(goals: triggeredGoals),
        ),
      );

      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.newMeasurement),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CategoriesScreen(
                    dbService: widget.dbService,
                    userId: widget.userId,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _weightController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d{0,3}(\.\d?)?$'))
              ],
              decoration: InputDecoration(labelText: l10n.weightInput),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _heightController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d{0,3}(\.\d?)?$'))
              ],
              decoration: InputDecoration(labelText: l10n.heightInput),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _calculateAndSave(context),
              child: Text(l10n.calculateAndSave),
            ),
          ],
        ),
      ),
    );
  }
}
