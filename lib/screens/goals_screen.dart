import 'package:flutter/material.dart';
import '../services/db_service.dart';
import '../models/GoalModel.dart';
import 'categories_screen.dart';
import 'goal_form_screen.dart';
import 'package:intl/intl.dart';
import '../l10n/app_localizations.dart';

class GoalsScreen extends StatefulWidget {
  final DbService dbService;
  final int userId;

  const GoalsScreen({super.key, required this.dbService, required this.userId});

  @override
  State<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  late Future<List<GoalModel>> _goalFuture;

  @override
  void initState() {
    super.initState();
    _loadGoals();
  }

  void _loadGoals() {
    _goalFuture = widget.dbService.getGoalsForUser(widget.userId).then((goals) {
      goals.sort((a, b) {
        final aAchieved = a.achievements.isNotEmpty;
        final bAchieved = b.achievements.isNotEmpty;

        if (!aAchieved && bAchieved) return -1;
        if (aAchieved && !bAchieved) return 1;
        if (!aAchieved && !bAchieved) return 0;

        final aDate = DateTime.parse(
            a.achievements.map((ach) => ach.achievementDate).reduce((a, b) => a.compareTo(b) > 0 ? a : b));
        final bDate = DateTime.parse(
            b.achievements.map((ach) => ach.achievementDate).reduce((a, b) => a.compareTo(b) > 0 ? a : b));

        return bDate.compareTo(aDate);
      });

      return goals;
    });
  }

  Future<void> _navigateToAddGoal() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => GoalFormScreen(
          dbService: widget.dbService,
          userId: widget.userId,
        ),
      ),
    );
    _loadGoals();
    setState(() {});
  }

  Future<bool?> _confirmDelete(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;

    return await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.deleteGoalTitle),
        content: Text(l10n.deleteGoalConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(
              l10n.delete,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.goalsTitle),
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
      body: FutureBuilder<List<GoalModel>>(
        future: _goalFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final goals = snapshot.data!;
          if (goals.isEmpty) {
            return Center(child: Text(l10n.noGoalsAvailable));
          }

          return ListView.builder(
            itemCount: goals.length,
            itemBuilder: (context, index) {
              final g = goals[index];
              final hasCategory = g.category != null;
              final isAchieved = g.achievements.isNotEmpty;
              final dateText = g.achievementDate != null
                  ? l10n.achievedOn(DateFormat("dd.MM.yyyy").format(DateTime.parse(g.achievementDate!.toIso8601String())))
                  : null;

              return Dismissible(
                key: Key(g.goal.id.toString()),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  color: Colors.red,
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                confirmDismiss: (_) async {
                  final confirmed = await _confirmDelete(context);
                  if (confirmed == true) {
                    await widget.dbService.deleteGoal(g.goal.id);
                    _loadGoals();
                    setState(() {});
                    return true;
                  }
                  return false;
                },
                onDismissed: (_) async {
                  await widget.dbService.deleteGoal(g.goal.id);
                  goals.removeAt(index);
                  setState(() {});
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(l10n.goalDeleted)),
                  );
                },
                child: Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  elevation: 3,
                  child: ListTile(
                    leading: Icon(
                      Icons.flag,
                      color: isAchieved ? Colors.green : Colors.grey,
                    ),
                    title: hasCategory
                        ? Text(l10n.categoryLabel(g.category!.name))
                        : Text(l10n.bmiGoalLabel(g.goal.targetBmi!.toStringAsFixed(1))),
                    subtitle: dateText != null ? Text(dateText) : null,
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddGoal,
        child: const Icon(Icons.add),
      ),
    );
  }
}
