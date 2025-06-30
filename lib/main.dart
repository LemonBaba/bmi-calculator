import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'services/db_service.dart';
import 'database/app_database.dart';
import '../l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await resetDatabase(); // todo remove
  final db = AppDatabase();
  final dbService = DbService(db);

  runApp(BmiApp(dbService: dbService));
}

class BmiApp extends StatefulWidget {
  final DbService dbService;

  const BmiApp({super.key, required this.dbService});

  // This is how we expose the language change to the whole app
  static void setLocale(BuildContext context, Locale newLocale) {
    final _BmiAppState? state = context.findAncestorStateOfType<_BmiAppState>();
    state?.setLocale(newLocale);
  }

  @override
  State<BmiApp> createState() => _BmiAppState();
}

class _BmiAppState extends State<BmiApp> {
  Locale? _locale;

  void setLocale(Locale newLocale) {
    setState(() {
      _locale = newLocale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Manager',
      debugShowCheckedModeBanner: false,
      locale: _locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      localeResolutionCallback: (locale, supportedLocales) {
        if (_locale != null) return _locale;
        for (final supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale?.languageCode) {
            return supportedLocale;
          }
        }
        return const Locale('en'); // fallback
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1565C0)),
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
            backgroundColor: const Color(0xFF1565C0),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFF1565C0), width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      home: LoginScreen(dbService: widget.dbService),
    );
  }
}
