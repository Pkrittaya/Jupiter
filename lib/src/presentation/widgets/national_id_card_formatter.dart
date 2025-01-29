import 'package:flutter/services.dart';

class NationalIDCardInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final List<String> parts = [];

    for (int i = 0; i < newValue.text.length; i++) {
      final String char = newValue.text[i];
      if (i == 1 || i == 5 || i == 10 || i == 12) {
        parts.add('-');
      }
      if (char != '-') {
        parts.add(char);
      }
    }

    final String formattedText = parts.join('');

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
