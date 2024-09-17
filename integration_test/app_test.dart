import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:integration_test/integration_test.dart';
import 'package:workout_tracker/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Workout App Integration Test', () {
    testWidgets('Add a new workout and verify list', (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({}); // Mock SharedPreferences
      await tester.pumpWidget(const ProviderScope(child: MyApp()));

      // Tap on the add button
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      // Verify Add Workout screen is shown
      expect(find.text('Add Workout'), findsOneWidget);

      // Add exercise details
      await tester.enterText(find.byType(TextFormField).first, '100'); // Weight
      await tester.enterText(find.byType(TextFormField).last, '10'); // Reps
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      // Save workout
      await tester.tap(find.byIcon(Icons.save));
      await tester.pumpAndSettle();

      // Verify workout list shows new workout
      expect(find.textContaining('Workout on'), findsOneWidget);
    });
  });
}
