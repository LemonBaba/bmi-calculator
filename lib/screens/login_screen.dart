import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'register_screen.dart';
import '../services/db_service.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatefulWidget {
  final DbService dbService;

  const LoginScreen({super.key, required this.dbService});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _login() async {
    final inputEmail = _emailController.text.trim();
    final inputPassword = _passwordController.text.trim();

    try {
      final user = await widget.dbService.loginUser(inputEmail, inputPassword);

      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => HomeScreen(
              dbService: widget.dbService,
              user: user,
            ),
          ),
        );
      } else {
        _showFailedLoginMessage();
      }
    } catch (e) {
      _showFailedLoginMessage();
    }
  }

  void _showFailedLoginMessage() {
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
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: TextField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Passwort'),
                obscureText: true,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: const Text("Login"),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: TextButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RegisterScreen(dbService: widget.dbService),
                  ),
                ),
                child: const Text("Noch kein Konto? Registrieren"),
              ),
            ),
            Expanded(
              child: Lottie.asset(
                  'assets/animations/body_scan.json',
                  height: 200,
                  fit: BoxFit.contain,
                )
              ,)

          ],
        ),
      ),
    );
  }
}
