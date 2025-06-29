import 'package:flutter/material.dart';
import 'category_detail_screen.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  final categories = const [
    {"name": "Untergewicht", "range": "< 18.5"},
    {"name": "Normalgewicht", "range": "18.5 - 24.9"},
    {"name": "Übergewicht", "range": "25 - 29.9"},
    {"name": "Adipositas I", "range": "30 - 34.9"},
    {"name": "Adipositas II", "range": "35 - 39.9"},
    {"name": "Adipositas III", "range": "≥ 40"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("BMI Kategorien")),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final cat = categories[index];
          return ListTile(
            title: Text(cat['name']!),
            subtitle: Text("BMI: ${cat['range']}"),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => CategoryDetailScreen(name: cat['name']!, range: cat['range']!)),
            ),
          );
        },
      ),
    );
  }
}