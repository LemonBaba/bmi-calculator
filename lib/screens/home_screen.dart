import 'package:flutter/material.dart';
import '../services/db_service.dart';
import '../database/app_database.dart';
import 'input_screen.dart';
import 'history_screen.dart';
import 'goals_screen.dart';

class HomeScreen extends StatefulWidget {
  final DbService dbService;
  final UserData user;

  const HomeScreen({super.key, required this.dbService, required this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      HistoryScreen(dbService: widget.dbService, userId: widget.user.id),
      GoalsScreen(dbService: widget.dbService, userId: widget.user.id),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: "Verlauf",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.flag),
            label: "Ziele",
          ),
        ],
      ),
    );
  }
}
