// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get language => 'Language';

  @override
  String get congratulations => 'Congratulations!';

  @override
  String goal_bmi_achieved(Object goal) {
    return 'BMI-Goal $goal achieved';
  }

  @override
  String get back => 'Back';

  @override
  String get bmiCategories => 'BMI Categories';

  @override
  String get noCategoriesFound => 'No categories found.';

  @override
  String bmiRange(Object from, Object to) {
    return 'BMI: $from – $to';
  }

  @override
  String categoryDetail(Object name, Object range) {
    return 'Category: $name\nBMI range: $range';
  }

  @override
  String get newGoal => 'New Goal';

  @override
  String get category => 'Category';

  @override
  String get targetBmi => 'Target BMI';

  @override
  String get saveGoal => 'Save Goal';

  @override
  String get errorProvideCategoryOrBmi =>
      'Please provide either a category or a target BMI.';

  @override
  String get errorAlreadyInCategory => 'You are already in this category.';

  @override
  String get errorAlreadyAtTargetBmi =>
      'Your current BMI already matches the target.';

  @override
  String get errorDuplicateGoal =>
      'An identical unachieved goal already exists.';

  @override
  String get goalsTitle => 'Goals';

  @override
  String get noGoalsAvailable => 'No goals available.';

  @override
  String get deleteGoalTitle => 'Delete Goal';

  @override
  String get deleteGoalConfirm => 'Do you really want to delete this goal?';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get goalDeleted => 'Goal deleted.';

  @override
  String achievedOn(Object date) {
    return 'Achieved on: $date';
  }

  @override
  String categoryLabel(Object name) {
    return 'Category: $name';
  }

  @override
  String bmiGoalLabel(Object bmi) {
    return 'Target BMI: $bmi';
  }

  @override
  String get historyTitle => 'Measurement History';

  @override
  String get noEntriesFound => 'No entries found.';

  @override
  String get deleteEntryTitle => 'Delete Entry';

  @override
  String get deleteEntryConfirm => 'Do you really want to delete this entry?';

  @override
  String get entryDeleted => 'Entry deleted.';

  @override
  String bmiCategoryValue(Object bmi, Object category) {
    return '$bmi ($category)';
  }

  @override
  String entryDetails(Object weight, Object height, Object date) {
    return 'Weight: $weight kg, Height: $height cm\n$date';
  }

  @override
  String get navHistory => 'History';

  @override
  String get navGoals => 'Goals';

  @override
  String get navSettings => 'Settings';

  @override
  String get newMeasurement => 'New Measurement';

  @override
  String get weightInput => 'Weight (kg)';

  @override
  String get heightInput => 'Height (cm)';

  @override
  String get calculateAndSave => 'Calculate & Save';

  @override
  String get loginTitle => 'Login';

  @override
  String get usernameLabel => 'Username';

  @override
  String get passwordLabel => 'Password';

  @override
  String get loginButton => 'Login';

  @override
  String get registerPrompt => 'Don\'t have an account? Register';

  @override
  String get loginFailed => 'Login failed';

  @override
  String get registrationTitle => 'Register';

  @override
  String get registerButton => 'Register';

  @override
  String get userAlreadyExists => 'User already exists.';

  @override
  String get registrationSuccess => 'Registration successful.';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get logoutButton => 'Log out';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageGerman => 'German';

  @override
  String get bmiCategory_underweight => 'Underweight';

  @override
  String get bmiCategory_normal => 'Normal weight';

  @override
  String get bmiCategory_overweight => 'Overweight';

  @override
  String get bmiCategory_obesity1 => 'Obesity I';

  @override
  String get bmiCategory_obesity2 => 'Obesity II';

  @override
  String get bmiCategory_obesity3 => 'Obesity III';
}
