class WorkoutSet {
  final String exercise;
  final double weight;
  final int repetitions;

  WorkoutSet({
    required this.exercise,
    required this.weight,
    required this.repetitions,
  });

  WorkoutSet.fromJson(Map<String, dynamic> json)
      : exercise = json['exercise'],
        weight = json['weight'],
        repetitions = json['repetitions'];

  Map<String, dynamic> toJson() => {
    'exercise': exercise,
    'weight': weight,
    'repetitions': repetitions,
  };
}
