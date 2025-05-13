import 'package:enduro/model/workout_history_model.dart';
import 'package:enduro/model/workout_summary_model.dart';

class WorkoutAnalytics {
  static WorkoutSummaryModel getTodaySummary(
    List<WorkoutHistoryModel> workouts,
  ) {
    final today = DateTime.now();
    final filtered =
        workouts
            .where(
              (w) =>
                  w.date.year == today.year &&
                  w.date.month == today.month &&
                  w.date.day == today.day,
            )
            .toList();

    final duration = filtered.fold(Duration.zero, (a, b) => a + b.duration);
    final distance = filtered.fold(0.0, (a, b) => a + b.distance);

    return WorkoutSummaryModel(
      duration: duration,
      distance: distance,
      count: filtered.length,
    );
  }

  static WorkoutSummaryModel getWeeklySummary(
    List<WorkoutHistoryModel> workouts,
  ) {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));

    final filtered =
        workouts
            .where(
              (w) =>
                  w.date.isAfter(
                    startOfWeek.subtract(const Duration(days: 1)),
                  ) &&
                  w.date.isBefore(startOfWeek.add(const Duration(days: 7))),
            )
            .toList();

    final duration = filtered.fold(Duration.zero, (a, b) => a + b.duration);
    final distance = filtered.fold(0.0, (a, b) => a + b.distance);

    return WorkoutSummaryModel(
      duration: duration,
      distance: distance,
      count: filtered.length,
    );
  }
}
