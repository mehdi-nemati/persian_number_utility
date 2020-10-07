import 'dateClass.dart';
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

  ///تبدیل تاریخ از متن به تاریخ شمسی
  String toPersinaDate({NumStrLanguage digitType = NumStrLanguage.Farsi}) {
    try {
      var inputStr = this.replaceAll("/", "-");
      var splitedStr = inputStr.split("-");
      if (splitedStr[2].length == 1) {
        splitedStr[2] = "0" + splitedStr[2];
      }
      if (splitedStr[1].length == 1) {
        splitedStr[1] = "0" + splitedStr[1];
      }
      var changedToDate = DateTime.parse(splitedStr.join("-"));
      return changedToDate.toPersianDate(digitType: digitType);
    } catch (e) {
      return "0000/00/00";
    }
  }
}

extension PersianDateTimeExtensions on DateTime {
  ///تبدیل تاریخ میلادی به تاریخ شمسی
  String toPersianDate({NumStrLanguage digitType = NumStrLanguage.Farsi}) {
    return NumberUtility.changeDigit(PersianDate(this).toString(), digitType);
  }

  ///تبدیل تاریخ میلادی به نوشتاری شمسی
  String toPersianDateStr(
      {bool strYear = false,
      bool strMonth = true,
      bool strDay = false,
      bool showDayStr = false,
      String seprator = " ",
      String monthString = " "}) {
    var input = this.toPersianDate();
    var splitedStr = input.split("/");
    String outputString = "";

    outputString += showDayStr
        ? NumberUtility.getPersianDayLetter(this.weekday.toString()) + seprator
        : "";

    outputString += strDay ? splitedStr[2].toWord() : splitedStr[2];
    outputString += seprator;

    outputString += strMonth
        ? NumberUtility.getPersianMonthLetter(splitedStr[1]) + monthString
        : splitedStr[1];
    outputString += seprator;

    outputString += strYear ? splitedStr[0].toWord() : splitedStr[0];

    return outputString;
  }
}
