import 'package:enduro/controllers/language_controller.dart';
import 'package:enduro/utils/localizations/messages.dart' show Messages;
import 'package:enduro/utils/routes/routes.dart';
import 'package:enduro/utils/theme/app_colors.dart';
import 'package:enduro/view/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:enduro/utils/dependency_injection.dart' as dependency_injection;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Map<String, Map<String, String>> languages =
      await dependency_injection.init();
  runApp(MyApp(languages: languages));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.languages});

  final Map<String, Map<String, String>> languages;

  @override
  Widget build(BuildContext contextr) {
    return GetBuilder<LocalizationController>(
      builder:
          (controller) => GetMaterialApp(
            title: 'Enduro',
            debugShowCheckedModeBanner: false,
            initialRoute: Routes.onboarding,
            locale: controller.locale,
            translations: Messages(languages: languages),
            fallbackLocale: Locale('en', 'US'),
            getPages: getScreens,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
              textTheme: GoogleFonts.latoTextTheme(),
            ),
            home: HomeScreen(),
          ),
    );
  }
}
