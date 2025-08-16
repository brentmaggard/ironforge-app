import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ironforge_app/presentation/screens/goals/goals_screen.dart';

void main() {
  testWidgets('Goals screen renders without crash', (WidgetTester tester) async {
    // Build the Goals screen wrapped in ProviderScope
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: const GoalsScreen(),
        ),
      ),
    );

    // Just pump once to see if it renders
    await tester.pump();

    // Verify that the screen has loaded and shows loading state
    expect(find.byType(CircularProgressIndicator), findsWidgets);
  });
}