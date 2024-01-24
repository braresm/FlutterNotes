class CalculatorUtils {
  /// Convert a string number to an integer or a double
  static convertStringToNumber(String? value) {
    if (value == null) {
      return 0;
    }

    if (value.contains('.')) {
      return double.parse(value);
    }
    return int.parse(value);
  }
}
