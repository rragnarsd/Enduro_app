import 'package:enduro/controllers/workout_history_controller.dart';
import 'package:enduro/model/workout_history_model.dart';
import 'package:enduro/utils/helpers/workout_helpers.dart';
import 'package:enduro/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';

class WorkoutHistoryList extends StatelessWidget {
  const WorkoutHistoryList({super.key, required this.controller});

  final WorkoutHistoryController controller;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final workout = controller.workouts[index];
        return WorkoutHistoryItem(workout: workout, isFirstItem: index == 0);
      }, childCount: controller.workouts.length),
    );
  }
}

class WorkoutHistoryItem extends StatelessWidget {
  const WorkoutHistoryItem({
    super.key,
    required this.workout,
    required this.isFirstItem,
  });

  final WorkoutHistoryModel workout;
  final bool isFirstItem;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.tertiary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin:
          isFirstItem
              ? EdgeInsets.only(left: 16, right: 16, bottom: 8)
              : EdgeInsets.symmetric(horizontal: 16, vertical: 8),

      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WorkoutHeader(
              date: workout.formattedDate,
              difficulty:
                  '${getDifficultyLabel(workout.difficulty)} ${getDifficultyEmoji(workout.difficulty)}',
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Divider(),
            ),
            WorkoutInfoOverview(
              duration: workout.formattedDuration,
              distance: '${workout.distance.toStringAsFixed(2)} km',
            ),
          ],
        ),
      ),
    );
  }
}

class WorkoutHeader extends StatelessWidget {
  const WorkoutHeader({
    super.key,
    required this.date,
    required this.difficulty,
  });

  final String date;
  final String difficulty;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(date, style: TextStyle(fontSize: 14, color: AppColors.white)),
        Text(
          difficulty,
          style: TextStyle(fontSize: 14, color: AppColors.white),
        ),
      ],
    );
  }
}

class WorkoutInfoOverview extends StatelessWidget {
  const WorkoutInfoOverview({
    super.key,
    required this.duration,
    required this.distance,
  });

  final String duration;
  final String distance;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        WorkoutInfo(icon: Icons.access_time_filled, value: duration),
        WorkoutInfo(icon: Icons.directions_run, value: distance),
      ],
    );
  }
}

class WorkoutInfo extends StatelessWidget {
  const WorkoutInfo({super.key, required this.icon, required this.value});

  final IconData icon;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 6,
      children: <Widget>[
        Icon(icon, size: 18, color: AppColors.white),
        Text(value, style: TextStyle(fontSize: 16, color: AppColors.white)),
      ],
    );
  }
}
