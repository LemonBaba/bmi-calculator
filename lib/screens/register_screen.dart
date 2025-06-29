import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _register() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('registered_users');
    Map<String, String> users = {};

    if (jsonString != null) {
      users = Map<String, String>.from(jsonDecode(jsonString));
    }

    if (users.containsKey(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Benutzer existiert bereits.")),
      );
      return;
    }

    users[email] = password;
    await prefs.setString('registered_users', jsonEncode(users));

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Registrierung erfolgreich.")),
    );
    Navigator.pop(context);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Registrierung")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _emailController, decoration: const InputDecoration(labelText: 'E-Mail')),
            TextField(controller: _passwordController, decoration: const InputDecoration(labelText: 'Passwort'), obscureText: true),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _register, child: const Text("Registrieren")),
          ],
        ),
      ),
    );
  }
}
