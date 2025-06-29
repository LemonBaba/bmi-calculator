import 'package:flutter/material.dart';
import '../services/db_service.dart';
import '../models/BmiEntryModel.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends StatelessWidget {
  final DbService dbService;
  final int userId;

  const HistoryScreen({super.key, required this.dbService, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Messverlauf")),
      body: FutureBuilder<List<BmiEntryModel>>(
        future: dbService.getBmiEntries(userId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final entries = snapshot.data!;
          if (entries.isEmpty) return const Center(child: Text("Keine Einträge gefunden."));

          return ListView.builder(
            itemCount: entries.length,
            itemBuilder: (context, index) {
              final e = entries[index];
              return ListTile(
                title: Text("${e.entry.value.toStringAsFixed(1)} (${e.category.name})"),
                subtitle: Text("Gewicht: ${e.entry.weight} kg, Größe: ${e.entry.height} cm\n${DateFormat.yMd().add_Hm().format(DateTime.parse(e.entry.date))}"),
              );
            },
          );
        },
      ),
    );
  }
}