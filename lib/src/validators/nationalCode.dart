import '../extensions.dart';

class NationalCode {
  static bool isValidNationalCode(String? inputString) {
    if (inputString == null || inputString.isEmpty) {
      return false;
    }
    inputString = inputString.padLeft(10, '0');

    if (inputString.length != 10 && !inputString.isNumeric()) {
      return false;
    }

    var nationalCodeLength = 10;
    var sum = 0;
    for (var i = 0; i < inputString.length - 1; i++) {
      sum += int.parse(inputString[i]) * nationalCodeLength--;
    }

    var remainder = sum % 11;
    var controlNumber = int.parse(inputString[9]);
    return remainder < 2 && controlNumber == remainder ||
        remainder >= 2 && controlNumber == 11 - remainder;
  }
}
