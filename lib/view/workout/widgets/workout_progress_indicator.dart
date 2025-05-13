import 'package:enduro/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class WorkoutProgressIndicator extends StatelessWidget {
  const WorkoutProgressIndicator({
    super.key,
    required this.percent,
    required this.currentDistance,
  });

  final double percent;
  final int currentDistance;

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      backgroundColor: AppColors.white,
      progressColor: AppColors.secondary,
      lineWidth: 16,
      radius: 120,
      percent: percent,
      center: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$currentDistance m',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w600,
              color: AppColors.white,
            ),
          ),
          SizedBox(height: 8),
          Text('400 m', style: TextStyle(fontSize: 16, color: AppColors.white)),
        ],
      ),
    );
  }
}
