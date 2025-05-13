import 'package:enduro/model/workout_history_model.dart';
import 'package:enduro/model/workout_model.dart';
import 'package:enduro/utils/helpers/database_helper.dart';
import 'package:get/get.dart';

class WorkoutStorageController extends GetxController {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<List<WorkoutHistoryModel>> loadWorkouts() async =>
      await _dbHelper.getWorkoutHistory();

  Future<void> deleteAllWorkouts() async => await _dbHelper.deleteAllWorkouts();

  Future<List<WorkoutHistoryModel>> loadWeeklyWorkouts() async =>
      await _dbHelper.getWeeklyWorkouts();

  Future<Map<String, dynamic>> getTotalWorkoutStats() async =>
      await _dbHelper.getTotalWorkoutSummary();

  Future<void> saveWorkout(WorkoutHistoryModel workout) async =>
      await _dbHelper.insertWorkoutHistory(workout);

  Future<void> saveCustomWorkout(
    String name,
    List<WorkoutModel> phases,
  ) async => await _dbHelper.saveWorkout(name, phases);

  Future<List<WorkoutModel>> loadCustomWorkout(String name) async =>
      await _dbHelper.loadWorkout(name);

  Future<List<String>> getSavedWorkoutNames() async =>
      await _dbHelper.getSavedWorkoutNames();
}
