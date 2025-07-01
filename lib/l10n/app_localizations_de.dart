// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get language => 'Sprache';

  @override
  String get congratulations => 'Glückwunsch!';

  @override
  String goal_bmi_achieved(Object goal) {
    return 'BMI-Ziel $goal erreicht';
  }

  @override
  String get back => 'Zurück';

  @override
  String get bmiCategories => 'BMI-Kategorien';

  @override
  String get noCategoriesFound => 'Keine Kategorien gefunden.';

  @override
  String bmiRange(Object from, Object to) {
    return 'BMI: $from – $to';
  }

  @override
  String categoryDetail(Object name, Object range) {
    return 'Kategorie: $name\nBMI-Bereich: $range';
  }

  @override
  String get newGoal => 'Neues Ziel';

  @override
  String get category => 'Kategorie';

  @override
  String get targetBmi => 'Ziel-BMI';

  @override
  String get saveGoal => 'Ziel speichern';

  @override
  String get errorProvideCategoryOrBmi =>
      'Bitte entweder eine Kategorie oder einen Ziel-BMI angeben.';

  @override
  String get errorAlreadyInCategory =>
      'Du befindest dich bereits in dieser Kategorie.';

  @override
  String get errorAlreadyAtTargetBmi =>
      'Dein aktueller BMI entspricht bereits dem Ziel.';

  @override
  String get errorDuplicateGoal =>
      'Ein identisches unerreichtes Ziel existiert bereits.';

  @override
  String get goalsTitle => 'Ziele';

  @override
  String get noGoalsAvailable => 'Keine Ziele vorhanden.';

  @override
  String get deleteGoalTitle => 'Ziel löschen';

  @override
  String get deleteGoalConfirm => 'Möchtest du dieses Ziel wirklich löschen?';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get delete => 'Löschen';

  @override
  String get goalDeleted => 'Ziel gelöscht.';

  @override
  String achievedOn(Object date) {
    return 'Erreicht am: $date';
  }

  @override
  String categoryLabel(Object name) {
    return 'Kategorie: $name';
  }

  @override
  String bmiGoalLabel(Object bmi) {
    return 'Ziel-BMI: $bmi';
  }

  @override
  String get historyTitle => 'Messverlauf';

  @override
  String get noEntriesFound => 'Keine Einträge gefunden.';

  @override
  String get deleteEntryTitle => 'Eintrag löschen';

  @override
  String get deleteEntryConfirm =>
      'Möchtest du diesen Eintrag wirklich löschen?';

  @override
  String get entryDeleted => 'Eintrag gelöscht.';

  @override
  String bmiCategoryValue(Object bmi, Object category) {
    return '$bmi ($category)';
  }

  @override
  String entryDetails(Object weight, Object height, Object date) {
    return 'Gewicht: $weight kg, Größe: $height cm\n$date';
  }

  @override
  String get navHistory => 'Verlauf';

  @override
  String get navGoals => 'Ziele';

  @override
  String get navSettings => 'Einstellungen';

  @override
  String get newMeasurement => 'Neue Messung';

  @override
  String get weightInput => 'Gewicht (kg)';

  @override
  String get heightInput => 'Größe (cm)';

  @override
  String get calculateAndSave => 'Berechnen & speichern';

  @override
  String get loginTitle => 'Login';

  @override
  String get usernameLabel => 'Benutzername';

  @override
  String get passwordLabel => 'Passwort';

  @override
  String get loginButton => 'Login';

  @override
  String get registerPrompt => 'Noch kein Konto? Jetzt registrieren';

  @override
  String get loginFailed => 'Login fehlgeschlagen';

  @override
  String get registrationTitle => 'Registrierung';

  @override
  String get registerButton => 'Registrieren';

  @override
  String get userAlreadyExists => 'Benutzer existiert bereits.';

  @override
  String get registrationSuccess => 'Registrierung erfolgreich.';

  @override
  String get settingsTitle => 'Einstellungen';

  @override
  String get logoutButton => 'Abmelden';

  @override
  String get languageEnglish => 'Englisch';

  @override
  String get languageGerman => 'Deutsch';

  @override
  String get bmiCategory_underweight => 'Untergewicht';

  @override
  String get bmiCategory_normal => 'Normalgewicht';

  @override
  String get bmiCategory_overweight => 'Übergewicht';

  @override
  String get bmiCategory_obesity1 => 'Adipositas I';

  @override
  String get bmiCategory_obesity2 => 'Adipositas II';

  @override
  String get bmiCategory_obesity3 => 'Adipositas III';
}
