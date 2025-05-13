class WorkoutModel {
  double distance;
  WorkoutModel({required this.distance});

  Map<String, dynamic> toJson() => {'distance': distance};

  factory WorkoutModel.fromJson(Map<String, dynamic> json) =>
      WorkoutModel(distance: json['distance'].toDouble());
}
