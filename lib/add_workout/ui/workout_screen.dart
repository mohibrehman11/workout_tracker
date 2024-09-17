import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_tracker/utils/logger.dart';

import '../../notifier/workout_notifier.dart';
import '../../model/workout.dart';
import '../../model/workout_set.dart';

class WorkoutScreen extends ConsumerStatefulWidget {
  final String? workoutId;

  const WorkoutScreen({super.key, this.workoutId});

  @override
  _WorkoutScreenState createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends ConsumerState<WorkoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<WorkoutSet> _sets = [];
  String _selectedExercise = 'Barbell row';
  final _weightController = TextEditingController();
  final _repetitionsController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Logger.logInitMethodCalled(runtimeType);

    Logger.log('$runtimeType workout id if not null = ${widget.workoutId}');
    if (widget.workoutId != null) {
      final workout =
          ref.read(workoutProvider.notifier).getWorkoutById(widget.workoutId!);
      if (workout != null) {
        setState(() {
          _sets.addAll(workout.sets);
        });
      }
    }
  }

  void _addSet() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _sets.add(WorkoutSet(
          exercise: _selectedExercise,
          weight: double.tryParse(_weightController.text) ?? 0,
          repetitions: int.tryParse(_repetitionsController.text) ?? 0,
        ));

        _selectedExercise = 'Barbell row';
        _weightController.clear();
        _repetitionsController.clear();

        Logger.info('set is added');
      });
    }
  }

  void _removeSet(int index) {
    setState(() {
      _sets.removeAt(index);
    });
  }

  void _saveWorkout() {
    if (_sets.isNotEmpty) {
      final workout = Workout(
        id: widget.workoutId ?? Random().nextDouble().toString(),
        date: DateTime.now(),
        sets: _sets,
      );

      if (widget.workoutId != null) {
        ref
            .read(workoutProvider.notifier)
            .updateWorkout(widget.workoutId!, workout);
      } else {
        ref.read(workoutProvider.notifier).addWorkout(workout);
      }

      Logger.info('successfully saved workout');
      Navigator.of(context).pop();
    } else {
      Logger.warning('$runtimeType Nothing to save - no sets added yet');
    }
  }

  @override
  void dispose() {
    _weightController.dispose();
    _repetitionsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Logger.logBuildMethodCalled(runtimeType);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.workoutId == null ? 'Add Workout' : 'Edit Workout'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveWorkout,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedExercise,
                      items: [
                        'Barbell row',
                        'Bench press',
                        'Shoulder press',
                        'Deadlift',
                        'Squat'
                      ]
                          .map((exercise) => DropdownMenuItem(
                                value: exercise,
                                child: Text(exercise),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedExercise = value ?? 'Barbell row';
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 95,
                    child: TextFormField(
                      controller: _weightController,
                      decoration:
                          const InputDecoration(labelText: 'Weight (kg)'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter weight';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 60,
                    child: TextFormField(
                      controller: _repetitionsController,
                      decoration: const InputDecoration(labelText: 'Reps'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter reps';
                        }
                        return null;
                      },
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: _addSet,
                  )
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: _sets.length,
                  itemBuilder: (ctx, index) {
                    return ListTile(
                      title: Text(
                          '${_sets[index].exercise} - ${_sets[index].weight}kg x ${_sets[index].repetitions}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.remove_circle),
                        onPressed: () => _removeSet(index),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
