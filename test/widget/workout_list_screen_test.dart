import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_tracker/notifier/workout_notifier.dart';
import 'package:workout_tracker/workout_listing/ui/workout_list_screen.dart';
import 'package:mockito/mockito.dart';

class MockWorkoutNotifier extends Mock implements WorkoutNotifier {}

void main() {
  testWidgets('WorkoutListScreen displays empty message', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: WorkoutListScreen()),
      ),
    );

    expect(find.text('No workouts saved yet'), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
  });
}
