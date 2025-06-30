import 'package:bmi_manager/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import '../services/db_service.dart';
import '../database/app_database.dart';
import 'history_screen.dart';
import 'goals_screen.dart';
import '../l10n/app_localizations.dart';

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
      SettingsScreen(dbService: widget.dbService),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.history),
            label: l10n.navHistory,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.flag),
            label: l10n.navGoals,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: l10n.navSettings,
          ),
        ],
      ),
    );
  }
}
