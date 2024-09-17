import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workout_tracker/infrastructure/local/sharedpreferences_workout_repository.dart';
import 'package:workout_tracker/infrastructure/workout_repository.dart';
import 'package:workout_tracker/model/workout.dart';
import 'dart:convert';

import 'package:workout_tracker/model/workout_set.dart';


void main() {
  // Ensure Flutter binding is initialized
  TestWidgetsFlutterBinding.ensureInitialized();

  late SharedPreferencesWorkoutRepository repository;

  setUp(() {
    repository = SharedPreferencesWorkoutRepository();
    SharedPreferences.setMockInitialValues({});
  });

  group('SharedPreferencesWorkoutRepository', () {
    test('Save and load workouts', () async {
      final workout = Workout(
        id: '1',
        date: DateTime.now(),
        sets: [WorkoutSet(exercise: 'Bench Press', weight: 100, repetitions: 5)],
      );

      final workouts = <String, Workout>{workout.id: workout};

      await repository.saveWorkouts(workouts);

      final loadedWorkouts = await repository.loadWorkouts();

      expect(loadedWorkouts.length, 1);
      expect(loadedWorkouts.containsKey('1'), true);
      expect(loadedWorkouts['1']!.id, workout.id);
    });
  });
}
