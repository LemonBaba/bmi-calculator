import 'app_localizations.dart';

extension CategoryLocalization on AppLocalizations {
  String localizeCategory(String key) {
    switch (key) {
      case 'underweight':
        return bmiCategory_underweight;
      case 'normal':
        return bmiCategory_normal;
      case 'overweight':
        return bmiCategory_overweight;
      case 'obesity1':
        return bmiCategory_obesity1;
      case 'obesity2':
        return bmiCategory_obesity2;
      case 'obesity3':
        return bmiCategory_obesity3;
      default:
        return key;
    }
  }
}

