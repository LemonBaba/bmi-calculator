import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

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
        child: Text(
          AppLocalizations.of(context)!.categoryDetail(name, range),
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
