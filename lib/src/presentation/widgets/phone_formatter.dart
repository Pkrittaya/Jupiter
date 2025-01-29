import 'package:flutter/services.dart';

class PhoneNumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final List<String> parts = [];

    for (int i = 0; i < newValue.text.length; i++) {
      final String char = newValue.text[i];
      if (i == 3 || i == 6) {
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
