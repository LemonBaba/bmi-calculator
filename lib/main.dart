import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'services/db_service.dart';
import 'database/app_database.dart';

void main() {
  final db = AppDatabase();
  final dbService = DbService(db);

  runApp(BmiApp(dbService: dbService));
}

class BmiApp extends StatelessWidget {
  final DbService dbService;

  const BmiApp({super.key, required this.dbService});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI App Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginScreen(dbService: dbService),
    );
  }
}
