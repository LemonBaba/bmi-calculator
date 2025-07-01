# BMI Manager

This is a Flutter BMI manager project. It's a study project that should meet the following requirements:

- View BMI information
- Enter measurement data
- View analyzed measurement data with BMI
- Save measurement data
- View list of saved measurement data
- View list of categories
- View details for a category
- Register user
- Login

## Prerequisites

Ensure the following tools are installed on your system:

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Dart SDK](https://dart.dev/get-dart)
- [Android Studio](https://developer.android.com/studio) or [VS Code](https://code.visualstudio.com/) (optional)
- Android Emulator or real device for testing (optional)

## Getting started

### install dependencies

```bash
flutter pub get
```

### run
```bash
flutter run
```

## Screens

### Login
![img_7.png](readme_login_screen.png)

### Register
![img_8.png](readme_register_screen.png)

### History
![img.png](readme_history_screen.png)

### New Measurement
![img_1.png](readme_new_measurement_screen.png)

### Goals
![img_5.png](readme_goals_screen.png)

### Add Goal
![img_6.png](readme_add_goal_screen.png)

### Achievement Screen
![img_4.png](readme_achievement_screen.png)

### Settings
![img.png](readme_settings_screen.png)

### Categories
![img_2.png](readme_categories_screen.png)

### Category Detail
![img_3.png](readme_category_detail_screen.png)

## Development

### App Icon

If you change the app icon under `assets/icon` make sure you adjust the paths under `flutter_launcher_icons:` in `pubspec.yaml` and run:

```bash
flutter pub run flutter_launcher_icons:main
```

### Database Schema

If you change anything inside `lib/database/app_database.dart` you have to run:

```bash
dart run build_runner build --delete-conflicting-outputs
```

I am using `drift` as a low level ORM

### Translations (l10n)

If you change translations installing dependencies is enough

```bash
flutter pub get
```
