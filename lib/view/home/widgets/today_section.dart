import 'package:enduro/controllers/workout_history_controller.dart';
import 'package:enduro/utils/helpers/workout_helpers.dart';
import 'package:enduro/utils/theme/app_colors.dart';
import 'package:enduro/view/home/widgets/section_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TodaySection extends GetView<WorkoutHistoryController> {
  const TodaySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final summary = controller.getTodaySummary();

      return SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(title: 'today_progress'.tr),
            const SizedBox(height: 8),
            Row(
              children: [
                WorkoutStatusCard(
                  icon: Icons.access_time,
                  label: 'time'.tr,
                  value: formatDuration(summary.duration),
                ),
                WorkoutStatusCard(
                  icon: Icons.directions_run,
                  label: 'distance'.tr,
                  value: '${summary.distance.toStringAsFixed(1)} km',
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      );
    });
  }
}

class WorkoutStatusCard extends StatelessWidget {
  const WorkoutStatusCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        color: AppColors.tertiary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: EdgeInsets.symmetric(horizontal: 16),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(icon, size: 18, color: AppColors.white),
                  const SizedBox(width: 6),
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(fontSize: 24, color: AppColors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
