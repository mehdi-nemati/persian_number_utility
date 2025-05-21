extension StringExtension on String {
  bool get isNumeric => RegExp(r'^\d+\$').hasMatch(this);
}

class BankValidator {
  static bool verifyCardNumber(String cardNumber) {
    if (cardNumber.length != 16 || !cardNumber.isNumeric) return false;

    final prefix = int.tryParse(cardNumber.substring(1, 11)) ?? 0;
    final suffix = int.tryParse(cardNumber.substring(10, 16)) ?? 0;
    if (prefix == 0 || suffix == 0) return false;

    int sum = 0;
    for (int i = 0; i < cardNumber.length; i++) {
      int digit = int.parse(cardNumber[i]);
      if (i % 2 == 0) {
        digit *= 2;
        if (digit > 9) digit -= 9;
      }
      sum += digit;
    }

    return sum % 10 == 0;
  }

  static bool verifyShebaNumber(String sheba) {
    if (!sheba.toUpperCase().startsWith('IR') || sheba.length != 26) return false;

    final String countryCode = sheba.substring(0, 2).toUpperCase();
    final String checksum = sheba.substring(2, 4);
    final String bban = sheba.substring(4);

    final String rearranged = bban + checksum + countryCode.codeUnits.map((c) => (c - 55).toString()).join();

    try {
      final BigInt iban = BigInt.parse(rearranged);
      return iban % BigInt.from(97) == BigInt.one;
    } catch (_) {
      return false;
    }
  }
}
