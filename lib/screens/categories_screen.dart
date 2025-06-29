import 'package:flutter/material.dart';
import 'category_detail_screen.dart';
import '../services/db_service.dart';
import '../database/app_database.dart';

class CategoriesScreen extends StatelessWidget {
  final DbService dbService;
  final int userId;

  const CategoriesScreen({super.key, required this.dbService, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("BMI Kategorien")),
      body: FutureBuilder<List<CategoryData>>(
        future: dbService.getAllCategories(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final categories = snapshot.data!;
          if (categories.isEmpty) return const Center(child: Text("Keine Kategorien gefunden."));

          return ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final cat = categories[index];
              return ListTile(
                title: Text(cat.name),
                subtitle: Text("BMI: ${cat.from} – ${cat.to}"),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CategoryDetailScreen(
                      name: cat.name,
                      range: "${cat.from} – ${cat.to}",
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
