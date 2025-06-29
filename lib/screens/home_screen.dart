import 'package:flutter/material.dart';
import 'input_screen.dart';
import 'history_screen.dart';
import 'categories_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("BMI Home")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const InputScreen())),
                child: const Text("Neue Messung")
            ),
            ElevatedButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HistoryScreen())),
                child: const Text("Messverlauf")
            ),
            ElevatedButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CategoriesScreen())),
                child: const Text("BMI Kategorien")
            )
          ],
        ),
      ),
    );
  }
}