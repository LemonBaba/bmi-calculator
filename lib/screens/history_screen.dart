import 'package:flutter/material.dart';
import '../models/bmi_entry.dart';
import '../services/local_storage_service.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Messverlauf")),
      body: FutureBuilder<List<BmiEntry>>(
        future: LocalStorageService.getEntries(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final entries = snapshot.data!;
          if (entries.isEmpty) return const Center(child: Text("Keine Einträge gefunden."));

          return ListView.builder(
            itemCount: entries.length,
            itemBuilder: (context, index) {
              final e = entries[index];
              return ListTile(
                title: Text("${e.bmi.toStringAsFixed(1)} (${e.category})"),
                subtitle: Text("Gewicht: ${e.weight} kg, Größe: ${e.height} cm\n${DateFormat.yMd().add_Hm().format(e.date)}"),
              );
            },
          );
        },
      ),
    );
  }
}