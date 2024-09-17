import 'package:flutter_test/flutter_test.dart';
import 'package:workout_tracker/model/workout.dart';
import 'package:workout_tracker/model/workout_set.dart';

void main() {
  group('Workout Model Test', () {
    final workoutSet = WorkoutSet(exercise: 'Squat', weight: 100, repetitions: 8);
    final workout = Workout(
      id: 'workout1',
      date: DateTime.parse('2023-09-15'),
      sets: [workoutSet],
    );

    test('Workout should convert to JSON and back', () {
      final json = workout.toJson();
      final fromJson = Workout.fromJson(json);

      expect(fromJson.id, workout.id);
      expect(fromJson.date, workout.date);
      expect(fromJson.sets.length, workout.sets.length);
      expect(fromJson.sets.first.exercise, workoutSet.exercise);
    });

    test('WorkoutSet should convert to JSON and back', () {
      final json = workoutSet.toJson();
      final fromJson = WorkoutSet.fromJson(json);

      expect(fromJson.exercise, workoutSet.exercise);
      expect(fromJson.weight, workoutSet.weight);
      expect(fromJson.repetitions, workoutSet.repetitions);
    });
  });
}
