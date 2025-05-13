import 'package:enduro/controllers/workout_storage_controller.dart';
import 'package:enduro/model/workout_history_model.dart';
import 'package:enduro/model/workout_summary_model.dart';
import 'package:enduro/utils/workout_analytics.dart';
import 'package:get/get.dart';

class WorkoutHistoryController extends GetxController {
  final WorkoutStorageController _storage = Get.find();

  final RxList<WorkoutHistoryModel> workouts = <WorkoutHistoryModel>[].obs;
  final RxList<WorkoutHistoryModel> recentWorkouts =
      <WorkoutHistoryModel>[].obs;
  final Rx<Map<String, dynamic>> summary = Rx<Map<String, dynamic>>({
    'count': 0,
    'duration': Duration.zero,
    'distance': 0.0,
  });

  @override
  void onInit() {
    super.onInit();
    loadWorkouts();
  }

  Future<void> loadWorkouts() async {
    final data = await _storage.loadWorkouts();
    workouts.value = data;
    recentWorkouts.value = data.take(3).toList();
    summary.value = await _storage.getTotalWorkoutStats();
  }

  Future<void> deleteAllWorkouts() async {
    await _storage.deleteAllWorkouts();
    workouts.clear();
    recentWorkouts.clear();
    summary.value = {'count': 0, 'duration': Duration.zero, 'distance': 0.0};
  }

  Future<void> saveWorkout(WorkoutHistoryModel workout) async {
    await _storage.saveWorkout(workout);
    await loadWorkouts();
  }

  WorkoutSummaryModel getTodaySummary() =>
      WorkoutAnalytics.getTodaySummary(workouts);

  WorkoutSummaryModel getWeeklySummary() =>
      WorkoutAnalytics.getWeeklySummary(workouts);
}
