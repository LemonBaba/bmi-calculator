import 'package:flutter/material.dart';
import 'register_screen.dart';
import 'home_screen.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }


  Future<void> _login() async {
    final inputEmail = _emailController.text.trim();
    final inputPassword = _passwordController.text.trim();

    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('registered_users');

    if (jsonString == null) {
      _showFailedLoginMessage();
      return;
    }

    final users = Map<String, String>.from(jsonDecode(jsonString));

    if (users[inputEmail] == inputPassword) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      _showFailedLoginMessage();
    }
  }

  _showFailedLoginMessage() async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Login fehlgeschlagen")),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _emailController, decoration: const InputDecoration(labelText: 'E-Mail')),
            TextField(controller: _passwordController, decoration: const InputDecoration(labelText: 'Passwort'), obscureText: true),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _login, child: const Text("Login")),
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const RegisterScreen()),
              ),
              child: const Text("Noch kein Konto? Registrieren"),
            )
          ],
        ),
      ),
    );
  }
}