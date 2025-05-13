import 'dart:convert';
import 'package:enduro/model/workout_history_model.dart';
import 'package:enduro/model/workout_model.dart';
import 'package:enduro/utils/localizations/language_constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  final _settingsStore = stringMapStoreFactory.store('app_settings');
  final _workoutHistoryStore = intMapStoreFactory.store('workout_history');
  final _savedWorkoutsStore = stringMapStoreFactory.store('saved_workouts');

  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    final dir = await getApplicationDocumentsDirectory();
    final dbPath = join(dir.path, 'enduro.db');
    _database = await databaseFactoryIo.openDatabase(dbPath);
    return _database!;
  }

  Future<void> initializeSettings() async {
    final db = await database;

    final lang = await _settingsStore.record('languageCode').get(db);
    if (lang == null) {
      await _settingsStore.record('languageCode').put(db, {
        'value': AppConstants.languages[0].languageCode,
      });
      await _settingsStore.record('countryCode').put(db, {
        'value': AppConstants.languages[0].countryCode,
      });
    }
  }

  Future<String?> getSetting(String key) async {
    final db = await database;
    final record = await _settingsStore.record(key).get(db);
    return record?['value'] as String?;
  }

  Future<void> setSetting(String key, String value) async {
    final db = await database;
    await _settingsStore.record(key).put(db, {'value': value});
  }

  Future<int> insertWorkoutHistory(WorkoutHistoryModel workout) async {
    final db = await database;
    final record = await _workoutHistoryStore.add(db, {
      'date': workout.date.toIso8601String(),
      'duration': workout.duration.inSeconds,
      'distance': workout.distance,
      'difficulty': workout.difficulty.index,
    });
    return record;
  }

  Future<List<WorkoutHistoryModel>> getWorkoutHistory() async {
    final db = await database;
    final records = await _workoutHistoryStore.find(
      db,
      finder: Finder(sortOrders: [SortOrder('date', false)]),
    );

    return records.map((snapshot) {
      final data = snapshot.value;
      return WorkoutHistoryModel(
        date: DateTime.parse(data['date'] as String),
        duration: Duration(seconds: data['duration'] as int),
        distance: data['distance'] as double,
        difficulty: WorkoutFeeling.values[data['difficulty'] as int],
      );
    }).toList();
  }

  Future<List<WorkoutHistoryModel>> getWeeklyWorkouts() async {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final start = DateTime(
      startOfWeek.year,
      startOfWeek.month,
      startOfWeek.day,
    );
    final end = start.add(Duration(days: 7));

    final allWorkouts = await getWorkoutHistory();
    return allWorkouts
        .where(
          (w) =>
              w.date.isAfter(start.subtract(const Duration(seconds: 1))) &&
              w.date.isBefore(end),
        )
        .toList();
  }

  Future<Map<String, dynamic>> getTotalWorkoutSummary() async {
    final workouts = await getWorkoutHistory();
    return {
      'count': workouts.length,
      'duration': workouts.fold(
        Duration.zero,
        (sum, workout) => sum + workout.duration,
      ),
      'distance': workouts.fold(0.0, (sum, workout) => sum + workout.distance),
    };
  }

  Future<void> deleteAllWorkouts() async {
    final db = await database;
    await _workoutHistoryStore.delete(db);
  }

  Future<void> saveWorkout(String name, List<WorkoutModel> phases) async {
    final db = await database;
    final phasesJson = jsonEncode(phases.map((p) => p.toJson()).toList());
    await _savedWorkoutsStore.record(name).put(db, {'phases': phasesJson});
  }

  Future<List<WorkoutModel>> loadWorkout(String name) async {
    final db = await database;
    final record = await _savedWorkoutsStore.record(name).get(db);
    if (record == null) return [];

    final phasesJson = jsonDecode(record['phases'] as String);
    return phasesJson.map((json) => WorkoutModel.fromJson(json)).toList();
  }

  Future<List<String>> getSavedWorkoutNames() async {
    final db = await database;
    final records = await _savedWorkoutsStore.find(db);
    return records.map((e) => e.key).toList();
  }
}
