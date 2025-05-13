import 'dart:async';
import 'package:enduro/controllers/workout_history_controller.dart';
import 'package:enduro/model/workout_history_model.dart';
import 'package:enduro/model/workout_model.dart';
import 'package:enduro/utils/helpers/database_helper.dart';
import 'package:get/get.dart';

class WorkoutController extends GetxController {
  Rx<WorkoutModel> workoutModel = WorkoutModel(distance: 400).obs;
  RxList<WorkoutModel> phases = <WorkoutModel>[].obs;

  final WorkoutHistoryController _historyController =
      Get.find<WorkoutHistoryController>();
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Timer? _timer;
  Rx<double> currentDistance = 0.0.obs;
  Rx<int> currentIndex = 0.obs;
  Rx<int> lapCount = 0.obs;
  Rx<bool> isRunning = false.obs;
  Rx<Duration> elapsedTime = Duration.zero.obs;

  @override
  void onInit() {
    super.onInit();
    phases.value = [WorkoutModel(distance: 400)];
    workoutModel.value = phases[0];
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  void _handleWorkoutComplete() {
    currentIndex.value++;
    lapCount.value++;
    currentDistance.value = 0;
  }

  double get totalWorkoutDistance =>
      phases.fold(0.0, (sum, p) => sum + p.distance) * lapCount.value;

  Future<void> saveWorkout(String name) async {
    await _dbHelper.saveWorkout(name, phases);
  }

  Future<void> loadWorkout(String name) async {
    final loadedPhases = await _dbHelper.loadWorkout(name);
    if (loadedPhases.isNotEmpty) {
      phases.value = loadedPhases;
      workoutModel.value = phases[0];
    }
  }

  Future<List<String>> getSavedWorkouts() async {
    return await _dbHelper.getSavedWorkoutNames();
  }

  void startTimer() {
    if (!isRunning.value) {
      isRunning.value = true;
      if (currentDistance.value == 0) {
        currentDistance.value = 0;
      }

      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        elapsedTime.value += const Duration(seconds: 1);
        currentDistance.value += 1.5;

        if (currentDistance.value >= workoutModel.value.distance) {
          _handleWorkoutComplete();
        }
      });
    }
  }

  void pauseTimer() {
    _timer?.cancel();
    _timer = null;
    isRunning.value = false;
  }

  void stopTimer() {
    pauseTimer();
    isRunning.value = false;
  }

  Future<void> completeWorkout({required WorkoutFeeling feeling}) async {
    final workout = WorkoutHistoryModel(
      date: DateTime.now(),
      duration: elapsedTime.value,
      distance: totalWorkoutDistance / 1000,
      difficulty: feeling,
    );

    await _historyController.saveWorkout(workout);
    stopTimer();
  }

  Map<String, dynamic> getWorkoutSummary() {
    return {
      'distance': totalWorkoutDistance / 1000,
      'time': elapsedTime.value,
      'laps': lapCount.value,
    };
  }
}
