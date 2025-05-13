import 'dart:async';
import 'dart:ui';
import 'package:enduro/model/language_model.dart';
import 'package:enduro/utils/helpers/database_helper.dart';
import 'package:enduro/utils/localizations/language_constants.dart';
import 'package:get/get.dart';

class LocalizationController extends GetxController implements GetxService {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  LocalizationController() {
    _initializeLanguage();
  }

  Locale _locale = Locale(
    AppConstants.languages[0].languageCode,
    AppConstants.languages[0].countryCode,
  );

  int _selectedIndex = 0;
  List<LanguageModel> _languages = [];

  int get selectedIndex => _selectedIndex;
  Locale get locale => _locale;
  List<LanguageModel> get languages => _languages;

  Future<void> _initializeLanguage() async {
    try {
      await _dbHelper.initializeSettings();
      await loadCurrentLanguage();
    } catch (e) {
      _setDefaultLanguage();
    }
  }

  void _setDefaultLanguage() {
    _locale = Locale(
      AppConstants.languages[0].languageCode,
      AppConstants.languages[0].countryCode,
    );
    _selectedIndex = 0;
    _languages = List.from(AppConstants.languages);
    update();
  }

  Future<void> loadCurrentLanguage() async {
    await _dbHelper.initializeSettings();

    String languageCode =
        await _dbHelper.getSetting(AppConstants.languageCode) ??
        AppConstants.languages[0].languageCode;

    String countryCode =
        await _dbHelper.getSetting(AppConstants.countryCode) ??
        AppConstants.languages[0].countryCode;

    _locale = Locale(languageCode, countryCode);

    for (int index = 0; index < AppConstants.languages.length; index++) {
      if (AppConstants.languages[index].languageCode == _locale.languageCode) {
        _selectedIndex = index;
        break;
      }
    }

    _languages = List.from(AppConstants.languages);
    update();
  }

  void setLanguage(Locale locale) {
    Get.updateLocale(locale);
    _locale = locale;
    update();
  }

  void saveLanguage(Locale locale) {
    _dbHelper.setSetting(AppConstants.languageCode, locale.languageCode);
    _dbHelper.setSetting(AppConstants.countryCode, locale.countryCode ?? '');
  }
}
