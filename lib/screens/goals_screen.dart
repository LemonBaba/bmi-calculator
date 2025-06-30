import 'package:flutter/material.dart';
import '../services/db_service.dart';
import '../models/GoalModel.dart';
import 'categories_screen.dart';
import 'goal_form_screen.dart';

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

  void _loadGoals() async {
    _goalFuture = widget.dbService.getGoalsForUser(widget.userId).then((goals) {
      goals.sort((a, b) {
        final aAchieved = a.goal.entryId != null;
        final bAchieved = b.goal.entryId != null;
        if (aAchieved == bAchieved) return 0;
        return aAchieved ? 1 : -1;
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

  Future<void> _confirmDelete(BuildContext context, int goalId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Ziel löschen"),
        content: const Text("Möchtest du dieses Ziel wirklich löschen?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Abbrechen"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Löschen", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await widget.dbService.deleteGoal(goalId);
      _loadGoals();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ziele"),
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
      body: FutureBuilder<List<GoalModel>>(
        future: _goalFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final goals = snapshot.data!;
          if (goals.isEmpty) {
            return const Center(child: Text("Keine Ziele vorhanden."));
          }

          return ListView.builder(
            itemCount: goals.length,
            itemBuilder: (context, index) {
              final g = goals[index];
              final hasCategory = g.category != null;

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
                  return await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Ziel löschen"),
                      content: const Text("Möchtest du dieses Ziel wirklich löschen?"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text("Abbrechen"),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text("Löschen", style: TextStyle(color: Colors.red)),
                        ),
                      ],
                    ),
                  );
                },
                onDismissed: (_) async {
                  await widget.dbService.deleteGoal(g.goal.id);

                  goals.removeAt(index);
                  setState(() {});

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Ziel gelöscht.")),
                  );
                },
                child: Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  elevation: 3,
                  child: ListTile(
                    leading: Icon(
                      Icons.flag,
                      color: g.goal.entryId != null ? Colors.green : Colors.grey,
                    ),
                    title: hasCategory
                        ? Text("Kategorie: ${g.category!.name}")
                        : Text("Ziel-BMI: ${g.goal.targetBmi?.toStringAsFixed(1)}"),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _confirmDelete(context, g.goal.id),
                    ),
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
