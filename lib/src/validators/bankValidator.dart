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

    var even, tempDigit, sumOfItems = 0;
    for (int i = 0; i < 16; i++) {
      even = i % 2 == 0 ? 2 : 1;
      tempDigit = int.parse(inputString.substring(i, i + 1)) * even;
      sumOfItems += tempDigit > 9 ? tempDigit - 9 : tempDigit;
    }
    return sumOfItems % 10 == 0;
  }
}
