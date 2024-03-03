
import 'package:flutter_test/flutter_test.dart';
import '../lib/logic.dart';

void main() {
  group('Calculator Logic Tests', () {
    test('Addition Test', () {
      final calculator = Calculator();
      calculator.push(2);
      calculator.push(3);
      calculator.performOperation('+');
      expect(calculator.stack.last, 5);
    });

    test('Substraction Test', () {
      final calculator = Calculator();
      calculator.push(11);
      calculator.push(3);
      calculator.performOperation('-');
      expect(calculator.stack.last, 8);
    });

    test('Multiply Test', () {
      final calculator = Calculator();
      calculator.push(11);
      calculator.push(3);
      calculator.performOperation('*');
      expect(calculator.stack.last, 33);
    });

    test('Division Test', () {
      final calculator = Calculator();
      calculator.push(12);
      calculator.push(3);
      calculator.performOperation('/');
      expect(calculator.stack.last, 4);
    });
  });
}