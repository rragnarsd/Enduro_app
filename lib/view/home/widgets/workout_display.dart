import 'package:enduro/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';

class WorkoutDisplay extends StatelessWidget {
  const WorkoutDisplay({
    super.key,
    required this.label,
    required this.value,
    this.fontSize,
  });

  final String label;
  final String value;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: fontSize ?? 14, color: AppColors.white),
        ),
        Text(
          value,
          style: TextStyle(fontSize: fontSize ?? 24, color: AppColors.white),
        ),
      ],
    );
  }
}
