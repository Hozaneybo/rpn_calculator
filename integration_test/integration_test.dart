import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rpn_calculator/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Calculator Integration Tests', () {
    testWidgets('Should perform multiplication and update display', (WidgetTester tester) async {
      app.main(); // Starts the app.
      await tester.pumpAndSettle(); // Waits for all animations to complete.

      // Simulate button taps for entering '11'
      await tester.tap(find.text('1').at(0));
      await tester.pumpAndSettle(); // Wait for UI to settle.
      await tester.tap(find.text('1').at(1));
      await tester.pumpAndSettle(); // Wait for UI to settle.
      await tester.tap(find.text('Enter'));
      await tester.pumpAndSettle(); // Wait for UI to settle.

      // Simulate button tap for entering '4'
      await tester.tap(find.text('4'));
      await tester.pumpAndSettle(); // Wait for UI to settle.


      // Simulate button tap for performing multiplication
      await tester.tap(find.text('*'));
      await tester.pumpAndSettle(); // Wait for UI to settle.

      // Verify the result is displayed correctly
      expect(find.text('44.0'), findsOneWidget);
    });
  });
}
