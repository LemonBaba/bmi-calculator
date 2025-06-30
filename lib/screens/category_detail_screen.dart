import 'package:flutter/material.dart';

class CategoryDetailScreen extends StatelessWidget {
  final String name;
  final String range;

  const CategoryDetailScreen({super.key, required this.name, required this.range});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text("Kategorie: $name\nBMI-Bereich: $range\n\nDiese Kategorie beschreibt typische Gesundheitsrisiken entsprechend dem BMI-Wert.",
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
