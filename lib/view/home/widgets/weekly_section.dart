import 'package:enduro/controllers/workout_history_controller.dart';
import 'package:enduro/utils/helpers/workout_helpers.dart';
import 'package:enduro/view/home/widgets/section_header.dart';
import 'package:enduro/view/widgets/history_row.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WeeklySection extends GetView<WorkoutHistoryController> {
  const WeeklySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final summary = controller.getWeeklySummary();

      return SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SectionHeader(title: 'weekly_progress'.tr),
            const SizedBox(height: 8),
            HistoryRow(
              count: '${summary.count}',
              distance: '${summary.distance.toStringAsFixed(1)} km',
              duration: formatDuration(summary.duration),
            ),

            const SizedBox(height: 24),
          ],
        ),
      );
    });
  }
}
