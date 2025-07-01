import 'package:flutter/material.dart';
import 'category_detail_screen.dart';
import '../services/db_service.dart';
import '../database/app_database.dart';
import '../l10n/app_localization_extension.dart';
import '../l10n/app_localizations.dart';

class CategoriesScreen extends StatelessWidget {
  final DbService dbService;
  final int userId;

  const CategoriesScreen({super.key, required this.dbService, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.bmiCategories),
      ),
      body: FutureBuilder<List<CategoryData>>(
        future: dbService.getAllCategories(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final categories = snapshot.data!;
          if (categories.isEmpty) {
            return Center(
              child: Text(AppLocalizations.of(context)!.noCategoriesFound),
            );
          }

          return ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final cat = categories[index];
              return ListTile(
                title: Text(AppLocalizations.of(context)!.localizeCategory(cat.name)),
                subtitle: Text(
                  AppLocalizations.of(context)!.bmiRange(cat.from, cat.to),
                ),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CategoryDetailScreen(
                      name: AppLocalizations.of(context)!.localizeCategory(cat.name),
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
