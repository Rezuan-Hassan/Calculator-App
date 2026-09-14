import 'package:flutter_test/flutter_test.dart';
import 'package:stitch_calculator/controllers/calculator_controller.dart';
import 'package:stitch_calculator/main.dart';

void main() {
  group('CalculatorController Unit Tests', () {
    late CalculatorController controller;

    setUp(() {
      controller = CalculatorController();
    });

    test('Initial display is 0', () {
      expect(controller.primaryDisplay, '0');
      expect(controller.expressionDisplay, '');
    });

    test('Number input streams correctly', () {
      controller.onKeyPressed('1');
      controller.onKeyPressed('2');
      controller.onKeyPressed('5');
      controller.onKeyPressed('0');
      expect(controller.primaryDisplay, '1250');
      expect(CalculatorController.formatForDisplay(controller.primaryDisplay), '1,250');
    });

    test('Addition evaluation 1250 + 250 = 1500', () {
      controller.onKeyPressed('1');
      controller.onKeyPressed('2');
      controller.onKeyPressed('5');
      controller.onKeyPressed('0');
      controller.onKeyPressed('+');
      controller.onKeyPressed('2');
      controller.onKeyPressed('5');
      controller.onKeyPressed('0');
      controller.onKeyPressed('=');

      expect(controller.primaryDisplay, '1500');
      expect(controller.lastResult, '1500');
      expect(controller.history.length, 1);
    });

    test('Stitch sample: 1250 × 24 = 30,000', () {
      controller.onKeyPressed('1');
      controller.onKeyPressed('2');
      controller.onKeyPressed('5');
      controller.onKeyPressed('0');
      controller.onKeyPressed('×');
      controller.onKeyPressed('2');
      controller.onKeyPressed('4');
      controller.onKeyPressed('=');

      expect(controller.primaryDisplay, '30000');
      expect(CalculatorController.formatForDisplay(controller.primaryDisplay), '30,000');
    });

    test('Backspace removes last digit', () {
      controller.onKeyPressed('1');
      controller.onKeyPressed('2');
      controller.onKeyPressed('3');
      controller.onKeyPressed('BACKSPACE');
      expect(controller.primaryDisplay, '12');
    });

    test('Clear all resets displays', () {
      controller.onKeyPressed('9');
      controller.onKeyPressed('+');
      controller.onKeyPressed('AC');
      expect(controller.primaryDisplay, '0');
      expect(controller.expressionDisplay, '');
    });

    test('Percentage calculation', () {
      controller.onKeyPressed('5');
      controller.onKeyPressed('0');
      controller.onKeyPressed('%');
      expect(controller.primaryDisplay, '0.5');
    });
  });

  testWidgets('App UI loads correctly with Stitch brand header and keypad', (WidgetTester tester) async {
    await tester.pumpWidget(const StitchCalculatorApp());
    await tester.pumpAndSettle();

    expect(find.text('Rimon Calculator'), findsOneWidget);
    expect(find.text('Standard'), findsOneWidget);
    expect(find.text('DEG'), findsOneWidget);
    expect(find.text('AC'), findsOneWidget);
    expect(find.text('='), findsOneWidget);
  });
}
