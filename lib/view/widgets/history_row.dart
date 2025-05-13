import 'package:enduro/utils/theme/app_colors.dart';
import 'package:enduro/view/home/widgets/workout_display.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryRow extends StatelessWidget {
  const HistoryRow({
    super.key,
    required this.count,
    required this.duration,
    required this.distance,
  });

  final String count;
  final String duration;
  final String distance;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.tertiary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            WorkoutDisplay(label: 'workouts'.tr, value: count),
            WorkoutDisplay(label: 'time'.tr, value: duration),
            WorkoutDisplay(label: 'distance'.tr, value: distance),
          ],
        ),
      ),
    );
  }
}
