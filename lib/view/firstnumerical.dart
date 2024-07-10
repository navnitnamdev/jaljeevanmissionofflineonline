import 'package:flutter/services.dart';

class FirstNonNumericalFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Check if the new value is not empty and the first character is numerical
    if (newValue.text.isNotEmpty && _isNumeric(newValue.text[0])) {
      // If the first character is numerical, keep the old value
      return oldValue;
    } else {
      // If the first character is not numerical, allow the new value
      return newValue;
    }
  }

  // Helper function to check if a character is numerical
  bool _isNumeric(String s) {
    return double.tryParse(s) != null;
  }
}
