import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'services/db_service.dart';
import 'database/app_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await resetDatabase(); // todo remove
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
      title: 'BMI Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF1565C0)),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1565C0),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF1565C0),
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF1565C0),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF1565C0), width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      home: LoginScreen(dbService: dbService),
    );
  }
}
