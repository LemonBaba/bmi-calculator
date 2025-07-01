import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
  ];

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @congratulations.
  ///
  /// In en, this message translates to:
  /// **'Congratulations!'**
  String get congratulations;

  /// Goal achieved message with goal
  ///
  /// In en, this message translates to:
  /// **'BMI-Goal {goal} achieved'**
  String goal_bmi_achieved(Object goal);

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @bmiCategories.
  ///
  /// In en, this message translates to:
  /// **'BMI Categories'**
  String get bmiCategories;

  /// No description provided for @noCategoriesFound.
  ///
  /// In en, this message translates to:
  /// **'No categories found.'**
  String get noCategoriesFound;

  /// Label showing the BMI range for a category
  ///
  /// In en, this message translates to:
  /// **'BMI: {from} – {to}'**
  String bmiRange(Object from, Object to);

  /// Details of the selected BMI category
  ///
  /// In en, this message translates to:
  /// **'Category: {name}\nBMI range: {range}'**
  String categoryDetail(Object name, Object range);

  /// No description provided for @newGoal.
  ///
  /// In en, this message translates to:
  /// **'New Goal'**
  String get newGoal;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @targetBmi.
  ///
  /// In en, this message translates to:
  /// **'Target BMI'**
  String get targetBmi;

  /// No description provided for @saveGoal.
  ///
  /// In en, this message translates to:
  /// **'Save Goal'**
  String get saveGoal;

  /// No description provided for @errorProvideCategoryOrBmi.
  ///
  /// In en, this message translates to:
  /// **'Please provide either a category or a target BMI.'**
  String get errorProvideCategoryOrBmi;

  /// No description provided for @errorAlreadyInCategory.
  ///
  /// In en, this message translates to:
  /// **'You are already in this category.'**
  String get errorAlreadyInCategory;

  /// No description provided for @errorAlreadyAtTargetBmi.
  ///
  /// In en, this message translates to:
  /// **'Your current BMI already matches the target.'**
  String get errorAlreadyAtTargetBmi;

  /// No description provided for @errorDuplicateGoal.
  ///
  /// In en, this message translates to:
  /// **'An identical unachieved goal already exists.'**
  String get errorDuplicateGoal;

  /// No description provided for @goalsTitle.
  ///
  /// In en, this message translates to:
  /// **'Goals'**
  String get goalsTitle;

  /// No description provided for @noGoalsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No goals available.'**
  String get noGoalsAvailable;

  /// No description provided for @deleteGoalTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Goal'**
  String get deleteGoalTitle;

  /// No description provided for @deleteGoalConfirm.
  ///
  /// In en, this message translates to:
  /// **'Do you really want to delete this goal?'**
  String get deleteGoalConfirm;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @goalDeleted.
  ///
  /// In en, this message translates to:
  /// **'Goal deleted.'**
  String get goalDeleted;

  /// Date when the goal was achieved
  ///
  /// In en, this message translates to:
  /// **'Achieved on: {date}'**
  String achievedOn(Object date);

  /// Label for goal based on category
  ///
  /// In en, this message translates to:
  /// **'Category: {name}'**
  String categoryLabel(Object name);

  /// Label for goal based on target BMI
  ///
  /// In en, this message translates to:
  /// **'Target BMI: {bmi}'**
  String bmiGoalLabel(Object bmi);

  /// No description provided for @historyTitle.
  ///
  /// In en, this message translates to:
  /// **'Measurement History'**
  String get historyTitle;

  /// No description provided for @noEntriesFound.
  ///
  /// In en, this message translates to:
  /// **'No entries found.'**
  String get noEntriesFound;

  /// No description provided for @deleteEntryTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Entry'**
  String get deleteEntryTitle;

  /// No description provided for @deleteEntryConfirm.
  ///
  /// In en, this message translates to:
  /// **'Do you really want to delete this entry?'**
  String get deleteEntryConfirm;

  /// No description provided for @entryDeleted.
  ///
  /// In en, this message translates to:
  /// **'Entry deleted.'**
  String get entryDeleted;

  /// BMI value and category name
  ///
  /// In en, this message translates to:
  /// **'{bmi} ({category})'**
  String bmiCategoryValue(Object bmi, Object category);

  /// Measurement details including weight, height and date
  ///
  /// In en, this message translates to:
  /// **'Weight: {weight} kg, Height: {height} cm\n{date}'**
  String entryDetails(Object weight, Object height, Object date);

  /// No description provided for @navHistory.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get navHistory;

  /// No description provided for @navGoals.
  ///
  /// In en, this message translates to:
  /// **'Goals'**
  String get navGoals;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// No description provided for @newMeasurement.
  ///
  /// In en, this message translates to:
  /// **'New Measurement'**
  String get newMeasurement;

  /// No description provided for @weightInput.
  ///
  /// In en, this message translates to:
  /// **'Weight (kg)'**
  String get weightInput;

  /// No description provided for @heightInput.
  ///
  /// In en, this message translates to:
  /// **'Height (cm)'**
  String get heightInput;

  /// No description provided for @calculateAndSave.
  ///
  /// In en, this message translates to:
  /// **'Calculate & Save'**
  String get calculateAndSave;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginTitle;

  /// No description provided for @usernameLabel.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get usernameLabel;

  /// No description provided for @passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// No description provided for @loginButton.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginButton;

  /// No description provided for @registerPrompt.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? Register'**
  String get registerPrompt;

  /// No description provided for @loginFailed.
  ///
  /// In en, this message translates to:
  /// **'Login failed'**
  String get loginFailed;

  /// No description provided for @registrationTitle.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get registrationTitle;

  /// No description provided for @registerButton.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get registerButton;

  /// No description provided for @userAlreadyExists.
  ///
  /// In en, this message translates to:
  /// **'User already exists.'**
  String get userAlreadyExists;

  /// No description provided for @registrationSuccess.
  ///
  /// In en, this message translates to:
  /// **'Registration successful.'**
  String get registrationSuccess;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @logoutButton.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logoutButton;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageGerman.
  ///
  /// In en, this message translates to:
  /// **'German'**
  String get languageGerman;

  /// No description provided for @bmiCategory_underweight.
  ///
  /// In en, this message translates to:
  /// **'Underweight'**
  String get bmiCategory_underweight;

  /// No description provided for @bmiCategory_normal.
  ///
  /// In en, this message translates to:
  /// **'Normal weight'**
  String get bmiCategory_normal;

  /// No description provided for @bmiCategory_overweight.
  ///
  /// In en, this message translates to:
  /// **'Overweight'**
  String get bmiCategory_overweight;

  /// No description provided for @bmiCategory_obesity1.
  ///
  /// In en, this message translates to:
  /// **'Obesity I'**
  String get bmiCategory_obesity1;

  /// No description provided for @bmiCategory_obesity2.
  ///
  /// In en, this message translates to:
  /// **'Obesity II'**
  String get bmiCategory_obesity2;

  /// No description provided for @bmiCategory_obesity3.
  ///
  /// In en, this message translates to:
  /// **'Obesity III'**
  String get bmiCategory_obesity3;

  /// Error message shown
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String error(Object error);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
