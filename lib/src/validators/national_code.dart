extension StringExtension on String {
  bool get isNumeric => RegExp(r'^\d{10}\$').hasMatch(this);

  bool get hasAllSameDigits => RegExp(r'^(\d)\1{9}\$').hasMatch(this);
}

class NationalCode {
  static bool isValidNationalCode(String? input) {
    if (input == null || input.isEmpty) return false;

    String code = input.padLeft(10, '0');

    if (!code.isNumeric || code.hasAllSameDigits) return false;

    int sum = 0;
    for (int i = 0; i < 9; i++) {
      sum += int.parse(code[i]) * (10 - i);
    }

    int checkDigit = int.parse(code[9]);
    int remainder = sum % 11;

    return (remainder < 2 && checkDigit == remainder) ||
           (remainder >= 2 && checkDigit == 11 - remainder);
  }
}
