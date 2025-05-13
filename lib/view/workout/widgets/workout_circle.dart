import 'package:enduro/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';

class WorkoutCircle extends StatelessWidget {
  const WorkoutCircle({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        color: AppColors.tertiary,
        border: Border.all(color: AppColors.white, width: 4),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 18, color: AppColors.white),
        ),
      ),
    );
  }
}
