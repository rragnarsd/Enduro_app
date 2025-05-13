import 'package:enduro/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';

class WorkoutSummary extends StatelessWidget {
  const WorkoutSummary({
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
    return Row(
      children: [
        Icon(icon, size: 24, color: AppColors.white),
        SizedBox(width: 16),
        Text(label, style: TextStyle(fontSize: 18, color: AppColors.white)),
        Spacer(),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
        ),
      ],
    );
  }
}
