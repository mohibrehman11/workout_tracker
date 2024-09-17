import 'package:shared_preferences/shared_preferences.dart';

import '../../model/workout.dart';
import '../../utils/json_util.dart';
import '../workout_repository.dart';

class SharedPreferencesWorkoutRepository implements WorkoutRepository {
  Future<SharedPreferences> get _prefs async => SharedPreferences.getInstance();

  @override
  Future<bool> saveWorkouts(Map<String, Workout> workouts) async {
    final prefs = await _prefs;
    final List<Map<String, dynamic>> jsonList =
    workouts.values.map((workout) => workout.toJson()).toList();
    final workoutsJson = JsonUtil.encode(jsonList);
    return await prefs.setString('workouts', workoutsJson);
  }

  @override
  Future<Map<String, Workout>> loadWorkouts() async {
    final prefs = await _prefs;
    final workoutsJson = prefs.getString('workouts');
    final Map<String, Workout> workouts = {};

    if (workoutsJson != null) {
      final List<dynamic> jsonList = JsonUtil.decode(workoutsJson);
      for (var jsonItem in jsonList) {
        final workout = Workout.fromJson(jsonItem);
        workouts[workout.id] = workout;
      }
    }

    return workouts;
  }
}
