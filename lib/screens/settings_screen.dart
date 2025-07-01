import 'package:bmi_manager/main.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';
import '../services/db_service.dart';
import '../l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  final DbService dbService;

  const SettingsScreen({super.key, required this.dbService});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late String _selectedLang;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _selectedLang = Localizations.localeOf(context).languageCode;
  }

  Future<void> _changeLanguage(String langCode) async {
    setState(() => _selectedLang = langCode);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('locale', langCode);

    BmiApp.setLocale(context, Locale(langCode));
  }

  void _logout(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => LoginScreen(dbService: widget.dbService)),
          (route) => false,
    );
  }

  String _getLanguageLabel(BuildContext context, Locale locale) {
    final l10n = AppLocalizations.of(context)!;

    switch (locale.languageCode) {
      case 'de':
        return l10n.languageGerman;
      case 'en':
      default:
        return l10n.languageEnglish;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<String>(
              value: _selectedLang,
              onChanged: (value) {
                if (value != null) _changeLanguage(value);
              },
              decoration: InputDecoration(
                labelText: l10n.language,
                border: OutlineInputBorder(),
              ),
              items: AppLocalizations.supportedLocales.map((locale) {
                return DropdownMenuItem(
                  value: locale.languageCode,
                  child: Text(_getLanguageLabel(context, locale)),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => _logout(context),
              icon: const Icon(Icons.logout),
              label: Text(l10n.logoutButton),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
