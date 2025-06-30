import 'package:flutter/material.dart';
import '../services/db_service.dart';
import '../models/BmiEntryModel.dart';
import 'categories_screen.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends StatefulWidget {
  final DbService dbService;
  final int userId;

  const HistoryScreen({super.key, required this.dbService, required this.userId});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late Future<List<BmiEntryModel>> _entriesFuture;

  @override
  void initState() {
    super.initState();
    _loadEntries();
  }

  void _loadEntries() {
    _entriesFuture = widget.dbService.getBmiEntries(widget.userId);
  }

  Future<bool> _confirmDelete(BuildContext context, int entryId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Eintrag löschen"),
        content: const Text("Möchtest du diesen Eintrag wirklich löschen?"),
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

    return confirmed ?? false;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Messverlauf"),
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
      body: FutureBuilder<List<BmiEntryModel>>(
        future: _entriesFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

          final entries = snapshot.data!;
          if (entries.isEmpty) return const Center(child: Text("Keine Einträge gefunden."));

          // Sort by date descending
          entries.sort((a, b) => b.entry.date.compareTo(a.entry.date));

          return ListView.builder(
            itemCount: entries.length,
            itemBuilder: (context, index) {
              final e = entries[index];

              return Dismissible(
                key: Key(e.entry.id.toString()),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                confirmDismiss: (_) => _confirmDelete(context, e.entry.id),
                onDismissed: (_) async {
                  await widget.dbService.deleteBmiEntry(e.entry.id);

                  setState(() {
                    entries.removeAt(index);
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Eintrag gelöscht.")),
                  );
                },
                child: Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  elevation: 3,
                  child: ListTile(
                    title: Text("${e.entry.value.toStringAsFixed(1)} (${e.category.name})"),
                    subtitle: Text(
                      "Gewicht: ${e.entry.weight} kg, Größe: ${e.entry.height} cm\n${DateFormat.yMd().add_Hm().format(DateTime.parse(e.entry.date))}",
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        final confirmed = await _confirmDelete(context, e.entry.id);
                        if (confirmed) {
                          await widget.dbService.deleteBmiEntry(e.entry.id);
                          setState(() {
                            entries.removeAt(index);
                          });
                        }
                      },
                    ),
                  ),
                ),
              );

            },
          );
        },
      ),
    );
  }
}
