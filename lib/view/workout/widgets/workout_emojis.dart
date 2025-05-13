import 'package:enduro/model/workout_history_model.dart';
import 'package:enduro/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WorkoutEmojis extends StatelessWidget {
  const WorkoutEmojis({super.key, required this.onFeelingSelected});

  final Function(WorkoutFeeling) onFeelingSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'how_do_you_feel'.tr,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: AppColors.white,
          ),
        ),
        Wrap(
          spacing: 6,
          children:
              feelings.asMap().entries.map((entry) {
                final index = entry.key;
                final feeling = entry.value;
                return GestureDetector(
                  onTap: () => onFeelingSelected(WorkoutFeeling.values[index]),
                  child: Text(
                    feeling['emoji']!,
                    style: TextStyle(fontSize: 24),
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }
}
