class RegexValidators {
  ///بررسی صحیح بودن شماره موبایل ایرانیان
  static bool isValidIranianMobileNumber(String? inputString) {
    if (inputString == null) {
      return false;
    }
    var regex = RegExp(
        r'^(((98)|(\+98)|(0098)|0)(9){1}((0)|(1)|(3)|(9)|(2)){1}[0-9]{8})+$',
        caseSensitive: false);
    return regex.hasMatch(inputString);
  }

  ///بررسی صحیح بودن کد پستی ایرانیان
  static bool isValidIranianPostalCode(String? inputString) {
    if (inputString == null) {
      return false;
    }
    var regex = RegExp(r'\b(?!(\d)\1{3})[13-9]{4}[1346-9][013-9]{5}\b',
        caseSensitive: false);
    return regex.hasMatch(inputString);
  }
}
