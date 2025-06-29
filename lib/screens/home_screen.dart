import 'package:flutter/material.dart';
import 'input_screen.dart';
import 'history_screen.dart';
import 'categories_screen.dart';
import '../database/app_database.dart';
import '../services/db_service.dart';

class HomeScreen extends StatelessWidget {
  final DbService dbService;
  final UserData user;

  const HomeScreen({super.key, required this.dbService, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("BMI Home")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => InputScreen(dbService: dbService, userId: user.id))),
                child: const Text("Neue Messung")
            ),
            ElevatedButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => HistoryScreen(dbService: dbService, userId: user.id))),
                child: const Text("Messverlauf")
            ),
            ElevatedButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CategoriesScreen(dbService: dbService, userId: user.id))),
                child: const Text("BMI Kategorien")
            )
          ],
        ),
      ),
    );
  }
}