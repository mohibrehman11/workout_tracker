import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../add_workout/ui/workout_screen.dart';
import '../../utils/logger.dart';
import '../../notifier/workout_notifier.dart';

class WorkoutListScreen extends ConsumerWidget {
  const WorkoutListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Logger.logBuildMethodCalled(runtimeType);

    final workouts = ref.watch(workoutProvider).values.toList();

    Logger.info('$runtimeType workouts length = ${workouts.length}');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Workouts'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => const WorkoutScreen()),
              );
            },
          )
        ],
      ),
      body: workouts.isEmpty
          ? const Center(
              child: Text('No workouts saved yet'),
            )
          : ListView.builder(
              itemCount: workouts.length,
              itemBuilder: (ctx, i) {
                return ListTile(
                  title: Text('Workout on ${workouts[i].date}'),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) =>
                            WorkoutScreen(workoutId: workouts[i].id),
                      ),
                    );
                  },
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      ref
                          .read(workoutProvider.notifier)
                          .deleteWorkout(workouts[i].id);
                    },
                  ),
                );
              },
            ),
    );
  }
}
