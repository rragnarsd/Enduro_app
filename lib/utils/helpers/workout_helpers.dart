import 'package:enduro/model/workout_history_model.dart';

String getDifficultyEmoji(WorkoutFeeling feeling) {
  return feelings[feeling.index]['emoji']!;
}

String getDifficultyLabel(WorkoutFeeling feeling) {
  final label = feelings[feeling.index]['label']!;
  return label[0].toUpperCase() + label.substring(1);
}

String formatDuration(Duration duration, {bool includeSeconds = true}) {
  final hours = duration.inHours;
  final minutes = duration.inMinutes.remainder(60);
  final seconds = duration.inSeconds.remainder(60);

  if (hours > 0) {
    return '${hours}h ${minutes}m';
  } else if (minutes > 0) {
    return includeSeconds ? '${minutes}m ${seconds}s' : '${minutes}m';
  } else {
    return includeSeconds ? '${seconds}s' : '0m';
  }
}
