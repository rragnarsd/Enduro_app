import 'package:enduro/controllers/workout_history_controller.dart';
import 'package:enduro/utils/helpers/workout_helpers.dart';
import 'package:enduro/utils/routes/routes.dart';
import 'package:enduro/utils/theme/app_colors.dart';
import 'package:enduro/view/history/widgets/workout_section.dart';
import 'package:enduro/view/widgets/action_buttons.dart';
import 'package:enduro/view/widgets/history_row.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryScreen extends GetView<WorkoutHistoryController> {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.white),
        ),
        title: Text(
          'training_history'.tr,
          style: TextStyle(color: AppColors.white),
        ),
        actions: [
          if (controller.workouts.isNotEmpty)
            IconButton(
              onPressed: () => showModalSheet(context),
              icon: Icon(Icons.delete, color: AppColors.white),
            ),
        ],
      ),
      body: Obx(() {
        final summary = controller.summary.value;
        return controller.workouts.isEmpty
            ? EmptyWorkout()
            : CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: SizedBox(height: 24)),
                SliverToBoxAdapter(
                  child: HistoryRow(
                    count: '${summary['count']}',
                    distance: '${(summary['distance']).toStringAsFixed(1)} km',
                    duration: formatDuration(summary['duration']),
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 24)),
                WorkoutHistoryList(controller: controller),
                SliverToBoxAdapter(child: SizedBox(height: 24)),
              ],
            );
      }),
    );
  }

  Future<dynamic> showModalSheet(BuildContext context) {
    return Get.bottomSheet(
      backgroundColor: AppColors.primary,
      Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.question_mark_rounded, size: 66, color: AppColors.white),
            SizedBox(height: 24),
            Text(
              'delete_workouts'.tr,
              style: TextStyle(fontSize: 16, color: AppColors.white),
            ),
            SizedBox(height: 32),
            ActionButtons(
              continueText: 'delete'.tr,
              onCancel: () => Get.back(),
              onContinue: () {
                controller.deleteAllWorkouts();
                Get.back();
              },
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class EmptyWorkout extends StatelessWidget {
  const EmptyWorkout({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/empty_state.png'),
            SizedBox(height: 24),
            Text(
              'no_workouts'.tr,
              style: TextStyle(fontSize: 18, color: AppColors.white),
            ),
            SizedBox(height: 24),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                onPressed: () => Get.offNamed(Routes.workout),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondary,
                  minimumSize: Size(double.infinity, 54),
                ),
                child: Text(
                  'start_workout'.tr,
                  style: TextStyle(color: AppColors.white, fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
