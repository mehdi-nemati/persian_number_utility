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
}
