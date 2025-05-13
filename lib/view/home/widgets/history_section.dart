import 'package:enduro/controllers/workout_history_controller.dart';
import 'package:enduro/utils/helpers/workout_helpers.dart';
import 'package:enduro/utils/routes/routes.dart';
import 'package:enduro/utils/theme/app_colors.dart';
import 'package:enduro/view/history/widgets/workout_section.dart';
import 'package:enduro/view/home/widgets/section_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistorySection extends GetView<WorkoutHistoryController> {
  const HistorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        HistoryHeader(),
        SizedBox(height: 8),
        Obx(() {
          if (controller.recentWorkouts.isEmpty) {
            return WorkoutEmptyState();
          }
          return WorkoutList(controller: controller);
        }),
      ]),
    );
  }
}

class HistoryHeader extends StatelessWidget {
  const HistoryHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.history),
      child: SectionHeader(
        title: 'history'.tr,
        trailing: Row(
          spacing: 6,
          children: <Widget>[
            Text(
              'see_more'.tr,
              style: TextStyle(fontSize: 16, color: AppColors.white),
            ),
            Icon(Icons.arrow_forward, size: 18, color: AppColors.white),
          ],
        ),
      ),
    );
  }
}

class WorkoutList extends StatelessWidget {
  const WorkoutList({super.key, required this.controller});

  final WorkoutHistoryController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children:
          controller.recentWorkouts
              .map(
                (workout) => Card(
                  color: AppColors.tertiary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  margin:
                      workout == controller.recentWorkouts.first
                          ? EdgeInsets.only(left: 16, right: 16, bottom: 8)
                          : EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              workout.formattedDate,
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.white,
                              ),
                            ),
                            SizedBox(width: 16),
                            Text(
                              '${getDifficultyLabel(workout.difficulty)} ${getDifficultyEmoji(workout.difficulty)}',
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.white,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Divider(),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            WorkoutInfo(
                              icon: Icons.access_time_filled,
                              value: workout.formattedDuration,
                            ),
                            WorkoutInfo(
                              icon: Icons.directions_run,
                              value: '${workout.distance} km',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
    );
  }
}

class WorkoutEmptyState extends StatelessWidget {
  const WorkoutEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 32),
        Image.asset('assets/empty_state.png'),
        SizedBox(height: 24),
        Text(
          'no_workouts'.tr,
          style: TextStyle(fontSize: 16, color: AppColors.white),
        ),
      ],
    );
  }
}
