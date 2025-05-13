import 'package:enduro/model/language_model.dart';

class AppConstants {
  static const String countryCode = 'country_code';
  static const String languageCode = 'language_code';

  static List<LanguageModel> languages = [
    LanguageModel(
      imageUrl: "🇺🇸",
      languageName: 'English',
      countryCode: 'US',
      languageCode: 'en',
    ),
    LanguageModel(
      imageUrl: "🇮🇸",
      languageName: 'Icelandic',
      countryCode: 'IS',
      languageCode: 'is',
    ),
  ];
}
