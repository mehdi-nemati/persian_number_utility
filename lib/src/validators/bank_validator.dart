import '../extensions.dart';

class BankValidator {
  static bool verifyCardNumber(String inputString) {
    if (!inputString.isNumeric()) {
      return false;
    }

    var length = inputString.length;
    if (length < 16 ||
        int.parse(inputString.substring(1, 11)) == 0 ||
        int.parse(inputString.substring(10, 16)) == 0) {
      return false;
    }

    dynamic even, tempDigit, sumOfItems = 0;
    for (int i = 0; i < 16; i++) {
      even = i % 2 == 0 ? 2 : 1;
      tempDigit = int.parse(inputString.substring(i, i + 1)) * even;
      sumOfItems += tempDigit > 9 ? tempDigit - 9 : tempDigit;
    }
    return sumOfItems % 10 == 0;
  }

  static bool verifyShebaNumber(String inputString) {
    bool startsWithIR = inputString.toLowerCase().contains('ir');
    bool isShebaSizeWrong =
        startsWithIR ? inputString.length != 26 : inputString.length != 24;
    if (isShebaSizeWrong) return false;

    String part1 = inputString.substring(startsWithIR ? 5 : 3);

    String part2 =
        inputString.replaceFirst(startsWithIR ? 'IR' : '', '1827').substring(0, 7);

    String ibanNumber = part1 + part2;

    BigInt ibanInt = BigInt.parse(ibanNumber);
    return ibanInt % BigInt.from(97) == BigInt.from(10);
  }
}
