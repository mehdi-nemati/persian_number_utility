import 'methods.dart';

extension StringExtensions on String {
  ///convert 123456789 to ۱۲۳۴۵۶۷۸۹
  String toPersianDigit() {
    return NumberUtility.changeDigit(this, NumStrLanguage.Farsi);
  }
  ///convert ۱۲۳۴۵۶۷۸۹ to 123456789
  String toEnglishDigit() {
    return NumberUtility.changeDigit(this, NumStrLanguage.English);
  }

  ///extract number from string; abc123456789xyz to ۱۲۳۴۵۶۷۸۹  Or  ابپ۱۲۳۴۵۶۷۸۹ن to 123456789
  String extractNumber({NumStrLanguage toDigit = NumStrLanguage.Farsi}) {
    return NumberUtility.extractNumber(this, toDigit);
  }

  ///convert 123456789 to 123,456,789
  String seRagham({String separator = ","}) {
    return NumberUtility.seRagham(this, separator: separator);
  }

  ///convert number to string , like: 1000 to 'one thousand' or 'هزار'
  String toWord({NumStrLanguage lang = NumStrLanguage.Farsi}) {
    return NumberUtility.toWord(this, lang);
  }

  ///string is numeric or not
  bool isNumeric() {
    return NumberUtility.isNumeric(this);
  }
}
