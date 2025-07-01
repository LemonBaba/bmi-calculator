import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home_screen.dart';
import 'register_screen.dart';
import '../services/db_service.dart';
import 'package:lottie/lottie.dart';
import '../l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  final DbService dbService;

  const LoginScreen({super.key, required this.dbService});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _login() async {
    final inputUsername = _usernameController.text.trim();
    final inputPassword = _passwordController.text.trim();

    try {
      final user = await widget.dbService.loginUser(inputUsername, inputPassword);

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
    } catch (_) {
      _showFailedLoginMessage();
    }
  }

  void _showFailedLoginMessage() {
    final l10n = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.loginFailed)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.loginTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              keyboardType: TextInputType.text,
              maxLength: 255,
              buildCounter: (
                  BuildContext context, {
                    required int currentLength,
                    required bool isFocused,
                    required int? maxLength,
                  }) {
                return null;
              },
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
              ],
              decoration: InputDecoration(labelText: l10n.usernameLabel),
            ),
            const SizedBox(height: 10),
            TextField(
              keyboardType: TextInputType.text,
              controller: _passwordController,
              maxLength: 255,
              buildCounter: (
                  BuildContext context, {
                    required int currentLength,
                    required bool isFocused,
                    required int? maxLength,
                  }) {
                return null;
              },
              decoration: InputDecoration(labelText: l10n.passwordLabel),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text(l10n.loginButton),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => RegisterScreen(dbService: widget.dbService),
                ),
              ),
              child: Text(l10n.registerPrompt),
            ),
            Expanded(
              child: Lottie.asset(
                'assets/animations/body_scan.json',
                height: 200,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
