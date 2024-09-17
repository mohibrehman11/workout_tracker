import 'package:flutter_test/flutter_test.dart';
import 'package:workout_tracker/model/workout_set.dart';
import 'package:workout_tracker/notifier/workout_notifier.dart';
import 'package:workout_tracker/infrastructure/workout_repository.dart';
import 'package:workout_tracker/model/workout.dart';

class MockWorkoutRepository extends WorkoutRepository {
  @override
  Future<Map<String, Workout>> loadWorkouts() async {
    return {};
  }

  @override
  Future<bool> saveWorkouts(Map<String, Workout> workouts) async {
    return true;
  }
}

void main() {
  late MockWorkoutRepository mockRepository;
  late WorkoutNotifier notifier;

  setUp(() {
    mockRepository = MockWorkoutRepository();
    notifier = WorkoutNotifier(mockRepository);
  });

  group('WorkoutNotifier Test', () {
    final workout = Workout(
      id: '1',
      date: DateTime.now(),
      sets: [WorkoutSet(exercise: 'Bench Press', weight: 100, repetitions: 5)],
    );

    test('Adding a workout updates state', () async {
      await notifier.addWorkout(workout);

      expect(notifier.workouts.length, 1);
      expect(notifier.getWorkoutById('1'), workout);
    });

    test('Deleting a workout updates state', () async {
      await notifier.addWorkout(workout);
      await notifier.deleteWorkout('1');

      expect(notifier.workouts.length, 0);
    });
  });
}
