import '../model/workout.dart';

abstract class WorkoutRepository {
  Future<bool> saveWorkouts(Map<String, Workout> workouts);
  Future<Map<String, Workout>> loadWorkouts();
}

