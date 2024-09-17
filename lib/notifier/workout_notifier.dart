import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../infrastructure/local/sharedpreferences_workout_repository.dart';
import '../infrastructure/workout_repository.dart';
import '../model/workout.dart';

class WorkoutNotifier extends StateNotifier<Map<String, Workout>> {
  final WorkoutRepository _repository;

  WorkoutNotifier(this._repository) : super({}) {
    loadAllWorkouts();
  }

  List<Workout> get workouts => state.values.toList();

  Workout? getWorkoutById(String id) {
    return state[id];
  }

  Future<void> addWorkout(Workout workout) async {
    state = {
      ...state,
      workout.id: workout,
    };
    await _repository.saveWorkouts(state);
  }

  Future<void> updateWorkout(String id, Workout updatedWorkout) async {
    if (state.containsKey(id)) {
      state = {
        ...state,
        id: updatedWorkout,
      };
      await _repository.saveWorkouts(state);
    }
  }

  Future<void> deleteWorkout(String id) async {
    if (state.containsKey(id)) {
      final updatedState = Map<String, Workout>.from(state)..remove(id);
      state = updatedState;
      await _repository.saveWorkouts(state);
    }
  }

  Future loadAllWorkouts() async {
    final loadedWorkouts = await _repository.loadWorkouts();
    state = loadedWorkouts;
  }
}

// Provider to expose the WorkoutNotifier
final workoutProvider =
    StateNotifierProvider<WorkoutNotifier, Map<String, Workout>>((ref) {
  final repository = SharedPreferencesWorkoutRepository(); // Inject repository
  return WorkoutNotifier(repository);
});
