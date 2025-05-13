import 'package:get/get.dart';

class WorkoutHistoryModel {
  final DateTime date;
  final Duration duration;
  final double distance;
  final WorkoutFeeling difficulty;

  WorkoutHistoryModel({
    required this.date,
    required this.duration,
    required this.distance,
    required this.difficulty,
  });

  String get formattedDate =>
      '${date.day} ${_getMonthName(date.month)} ${date.year} at ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  String get formattedDuration =>
      '${duration.inHours}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';

  String _getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month - 1];
  }

  Map<String, dynamic> toJson() => {
    'date': date.toIso8601String(),
    'duration': duration.inSeconds,
    'distance': distance,
    'difficulty': difficulty.name,
  };

  factory WorkoutHistoryModel.fromJson(Map<String, dynamic> json) =>
      WorkoutHistoryModel(
        date: DateTime.parse(json['date']),
        duration: Duration(seconds: json['duration']),
        distance: json['distance'],
        difficulty: WorkoutFeeling.values.firstWhere(
          (e) => e.name == json['difficulty'],
          orElse: () => WorkoutFeeling.okay,
        ),
      );
}

enum WorkoutFeeling { great, good, okay, tired, exhausted }

final List<Map<String, String>> feelings = [
  {'emoji': '😄', 'label': 'great'.tr},
  {'emoji': '🙂', 'label': 'good'.tr},
  {'emoji': '😐', 'label': 'okay'.tr},
  {'emoji': '😓', 'label': 'tired'.tr},
  {'emoji': '😩', 'label': 'exhausted'.tr},
];
