import 'dart:convert';

import 'package:enduro/controllers/language_controller.dart';
import 'package:enduro/controllers/workout_history_controller.dart';
import 'package:enduro/controllers/workout_storage_controller.dart';
import 'package:enduro/model/language_model.dart';
import 'package:enduro/utils/helpers/database_helper.dart';
import 'package:enduro/utils/localizations/language_constants.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

Future<Map<String, Map<String, String>>> init() async {
  final dbHelper = DatabaseHelper();
  await dbHelper.initializeSettings();

  Get.lazyPut(() => dbHelper);
  Get.lazyPut(() => WorkoutStorageController());
  Get.lazyPut(() => LocalizationController());
  Get.lazyPut(() => WorkoutHistoryController());

  Map<String, Map<String, String>> languages = {};
  for (LanguageModel languageModel in AppConstants.languages) {
    String jsonStringValues = await rootBundle.loadString(
      'assets/locales/${languageModel.languageCode}.json',
    );
    Map<String, dynamic> mappedJson = jsonDecode(jsonStringValues);

    Map<String, String> json = {};
    mappedJson.forEach((key, value) {
      json[key] = value.toString();
    });

    languages['${languageModel.languageCode}_${languageModel.countryCode}'] =
        json;
  }
  return languages;
}
