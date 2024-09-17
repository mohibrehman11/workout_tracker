import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_tracker/add_workout/ui/workout_screen.dart';

void main() {
  testWidgets('Add workout screen renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: WorkoutScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.text('Add Workout'), findsOneWidget);
    expect(find.byType(DropdownButtonFormField<String>), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
  });
}
