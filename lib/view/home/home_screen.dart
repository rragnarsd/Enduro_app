import 'package:enduro/utils/routes/routes.dart';
import 'package:enduro/utils/theme/app_colors.dart';
import 'package:enduro/view/home/widgets/history_section.dart';
import 'package:enduro/view/home/widgets/today_section.dart';
import 'package:enduro/view/home/widgets/weekly_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Image.asset('assets/enduro.png'),
        ),
        leadingWidth: 100,
        actions: <Widget>[
          ElevatedButton(
            onPressed: () => Get.toNamed(Routes.workout),
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              backgroundColor: AppColors.secondary,
              foregroundColor: AppColors.white,
            ),
            child: Icon(Icons.add_rounded, color: AppColors.white, size: 22),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          TodaySection(),
          WeeklySection(),
          HistorySection(),
          SliverToBoxAdapter(child: SizedBox(height: 32)),
        ],
      ),
    );
  }
}
