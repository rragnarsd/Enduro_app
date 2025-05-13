import 'package:enduro/controllers/workout_controller.dart';
import 'package:enduro/model/workout_history_model.dart';
import 'package:enduro/utils/routes/routes.dart';
import 'package:enduro/utils/theme/app_colors.dart';
import 'package:enduro/view/widgets/action_buttons.dart';
import 'package:enduro/view/workout/widgets/workout_circle.dart';
import 'package:enduro/view/workout/widgets/workout_emojis.dart';
import 'package:enduro/view/workout/widgets/workout_progress_indicator.dart';
import 'package:enduro/view/workout/widgets/workout_summary.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({super.key});

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  final WorkoutController _controller = Get.put(WorkoutController());

  @override
  void dispose() {
    resetWorkout();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Column(
                    children: [
                      Text(
                        '${'lap:'.tr} ${_controller.lapCount.value + 1}',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: AppColors.white,
                        ),
                      ),
                      SizedBox(height: 24),
                      WorkoutProgressIndicator(
                        //TODO - Add interval (Warmup, walk, run, cooldown)
                        percent: workoutProgress(),
                        currentDistance:
                            _controller.currentDistance.value.toInt(),
                      ),
                    ],
                  ),
                  Positioned(
                    right: -20,
                    bottom: 0,
                    child: WorkoutCircle(
                      text: _formatTime(
                        _controller.elapsedTime.value.inSeconds,
                      ),
                    ),
                  ),
                  Positioned(
                    left: -12,
                    top: 46,
                    child: WorkoutCircle(
                      text: _formatDistance(
                        _controller.currentDistance.value +
                            (_controller.lapCount.value * 400),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 64),
              ActionButtons(
                continueText:
                    _controller.isRunning.value ? 'pause'.tr : 'start'.tr,
                onCancel: () {
                  _controller.stopTimer();
                  _showWorkoutSummary();
                },
                onContinue:
                    _controller.isRunning.value
                        ? _controller.pauseTimer
                        : _controller.startTimer,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void resetWorkout() {
    _controller.stopTimer();
    _controller.currentDistance.value = 0;
    _controller.elapsedTime.value = Duration.zero;
    _controller.lapCount.value = 0;
    _controller.currentIndex.value = 0;
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$hours:$minutes:$seconds';
  }

  double workoutProgress() {
    if (_controller.phases.isEmpty) return 0;
    final double total = _controller.workoutModel.value.distance;
    return _controller.currentDistance.value / total;
  }

  String _formatTime(int seconds) {
    final int minutes = seconds ~/ 60;
    final int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  String _formatDistance(double meters) {
    if (meters < 1000) {
      return '${meters.toInt()} m';
    } else {
      return '${(meters / 1000).toStringAsFixed(1)} km';
    }
  }

  void _showWorkoutSummary() {
    final workoutSummary = _controller.getWorkoutSummary();
    final bool hasWorkoutActivity =
        _controller.elapsedTime.value.inSeconds > 0 ||
        _controller.currentDistance.value > 0 ||
        _controller.lapCount.value > 0;

    Get.bottomSheet(
      backgroundColor: AppColors.primary,
      Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (hasWorkoutActivity)
              Text(
                'workout_complete'.tr,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: AppColors.white,
                ),
              ),
            SizedBox(height: 24),
            WorkoutSummary(
              icon: Icons.directions_run,
              label: 'distance'.tr,
              value: '${workoutSummary['distance'].toStringAsFixed(2)} km',
            ),
            SizedBox(height: 16),
            WorkoutSummary(
              icon: Icons.timer,
              label: 'time'.tr,
              value: _formatDuration(workoutSummary['time'] as Duration),
            ),
            SizedBox(height: 16),
            WorkoutSummary(
              icon: Icons.repeat,
              label: 'laps'.tr,
              value: '${workoutSummary['laps']}',
            ),
            SizedBox(height: 24),
            if (hasWorkoutActivity)
              Column(
                children: [
                  Divider(
                    color: AppColors.white.withValues(alpha: 0.5),
                    thickness: 1,
                  ),
                  SizedBox(height: 16),
                  WorkoutEmojis(
                    onFeelingSelected: (WorkoutFeeling feeling) async {
                      await _controller.completeWorkout(feeling: feeling);
                      Get.back();
                      Get.offNamed(Routes.home);
                    },
                  ),
                  SizedBox(height: 24),
                ],
              ),

            if (hasWorkoutActivity)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondary,
                  minimumSize: Size(double.infinity, 54),
                ),
                onPressed: () async {
                  await _controller.completeWorkout(
                    feeling: WorkoutFeeling.good,
                  );
                  Get.back();
                  Get.offNamed(Routes.home);
                },
                child: Text(
                  'save_finished'.tr,
                  style: TextStyle(color: AppColors.white, fontSize: 16),
                ),
              )
            else
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.tertiary,
                  minimumSize: Size(double.infinity, 54),
                ),
                onPressed: () {
                  Get.back();
                  Get.offNamed(Routes.home);
                },
                child: Text(
                  'cancel'.tr,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
