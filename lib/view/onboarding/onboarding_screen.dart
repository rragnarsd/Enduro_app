import 'package:enduro/controllers/language_controller.dart';
import 'package:enduro/utils/localizations/language_constants.dart';
import 'package:enduro/utils/routes/routes.dart';
import 'package:enduro/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/enduro.png'),
            SizedBox(height: 46),
            LocaleOptions(),
          ],
        ),
      ),
    );
  }
}

class LocaleOptions extends StatelessWidget {
  const LocaleOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocalizationController>(
      builder:
          (controller) => Row(
            children: [
              LocaleOptionButton(
                onPressed: () {
                  controller.setLanguage(Locale('is', 'IS'));
                  Get.toNamed(Routes.home);
                },
                imageUrl: AppConstants.languages[1].imageUrl,
                language: 'icelandic'.tr,
              ),
              SizedBox(width: 16),
              LocaleOptionButton(
                onPressed: () {
                  controller.setLanguage(Locale('en', 'US'));
                  Get.toNamed(Routes.home);
                },
                imageUrl: AppConstants.languages[0].imageUrl,
                language: 'english'.tr,
              ),
            ],
          ),
    );
  }
}

class LocaleOptionButton extends StatelessWidget {
  const LocaleOptionButton({
    super.key,
    required this.onPressed,
    required this.imageUrl,
    required this.language,
  });

  final VoidCallback onPressed;
  final String imageUrl;
  final String language;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.tertiary,
          minimumSize: Size(double.infinity, 54),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 12,
          children: [
            Text(imageUrl, style: TextStyle(fontSize: 20)),
            Text(
              language,
              style: TextStyle(fontSize: 16, color: AppColors.white),
            ),
          ],
        ),
      ),
    );
  }
}
