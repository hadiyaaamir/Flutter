library hello_package;

import 'dart:math';

/// A Calculator.
class Calculator {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;

  int add(int value1, int value2) => value1 + value2;
  int subtract(int value1, int value2) => value1 - value2;
  double divide(double value1, double value2) => value1 / value2;
  double multiply(double value1, double value2) => value1 * value2;
  num power(num value, num exp) => pow(value, exp);
  num squareRoot(num value) => sqrt(value);
}
