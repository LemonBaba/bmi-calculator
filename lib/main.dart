import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'services/db_service.dart';
import 'database/app_database.dart';
import '../l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final savedLocaleCode = prefs.getString('locale');
  final locale = savedLocaleCode != null ? Locale(savedLocaleCode) : null;

  await resetDatabase(); // todo remove
  final db = AppDatabase();
  final dbService = DbService(db);

  runApp(BmiApp(dbService: dbService, initialLocale: locale));
}

class BmiApp extends StatefulWidget {
  final DbService dbService;
  final Locale? initialLocale;

  const BmiApp({super.key, required this.dbService, this.initialLocale});

  static void setLocale(BuildContext context, Locale newLocale) {
    final _BmiAppState? state = context.findAncestorStateOfType<_BmiAppState>();
    state?.setLocale(newLocale);
  }

  @override
  State<BmiApp> createState() => _BmiAppState();
}

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();
class _BmiAppState extends State<BmiApp> {
  Locale? _locale;

  @override
  void initState() {
    super.initState();
    _locale = widget.initialLocale;
  }

  void setLocale(Locale newLocale) {
    setState(() => _locale = newLocale);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Manager',
      debugShowCheckedModeBanner: false,
      navigatorObservers: [routeObserver],
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
        return const Locale('en');
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
