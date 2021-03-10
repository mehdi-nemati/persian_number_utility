import 'package:persian_number_utility/src/validators/regexValidators.dart';

import 'dateClass.dart';
import 'enums.dart';
import 'differenceDate.dart';
import 'methods.dart';
import 'validators/bankValidator.dart';
import 'validators/nationalCode.dart';

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

  @deprecated

  /// استفاده شود toPersianDate به خاطر اشتباه نوشتاری در متد از
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

  ///تبدیل تاریخ از متن به تاریخ شمسی
  String toPersianDate({NumStrLanguage digitType = NumStrLanguage.Farsi}) {
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

  //صحیح بودن کد ملی ایرانیان
  bool isValidIranianNationalCode() {
    return NationalCode.isValidNationalCode(this);
  }

  //صحیح بودن شماره کارت بانکی
  bool isValidBankCardNumber() {
    return BankValidator.verifyCardNumber(this);
  }

  //صحیح بودن شماره موبایل ایرانیان
  bool isValidIranianMobileNumber() {
    return RegexValidators.isValidIranianMobileNumber(this);
  }

  //تبدیل به تومان - Convert price to Toman
  String beToman() {
    var strNumber = NumberUtility.extractNumber(this, NumStrLanguage.English);
    var convertedNumber = int.parse(strNumber);
    return (convertedNumber / 10).toString().replaceAll('.0', '');
  }

  //تبدیل به ریال - Convert price to Rial
  String beRial() {
    var strNumber = NumberUtility.extractNumber(this, NumStrLanguage.English);
    var convertedNumber = int.parse(strNumber);
    return (convertedNumber * 10).toString();
  }
}

extension PersianDateTimeExtensions on DateTime {
  ///تبدیل تاریخ میلادی به تاریخ شمسی
  String toPersianDate({NumStrLanguage digitType = NumStrLanguage.Farsi}) {
    PersianDate persianDate = PersianDate();
    return NumberUtility.changeDigit(
        persianDate.toJalali(this.year, this.month, this.day).toString(),
        digitType);
  }

  ///نمایش اختلاف بین دو تاریخ به صورت خلاصه وار و متنی
  String getDifferenceDateString(
      {int seconds = 60,
      int minutes = 60,
      int hours = 24,
      int days = 7,
      int weeks = 4,
      int months = 12,
      DateTime? systemDatetime,
      String aFewSecondsAgoText = "لحظاتی پیش",
      String aFewMinutesAgoText = "دقایقی پیش",
      String someHoursAgoText = "ساعاتی پیش",
      String yesterdayText = "دیروز",
      String aFewDaysAgoText = "چند روز پیش",
      String lastWeekText = "هفته پیش",
      String aFewWeeksAgoText = "چند هفته پیش",
      String lastMonthText = "ماه پیش",
      String aFewMonthsAgoText = "چند ماه پیش",
      String lastYearText = "سال پیش",
      String someYearsAgoText = "چند سال پیش"}) {
    return DifferenceDate.getStringDate(this,
        seconds: seconds,
        minutes: minutes,
        hours: hours,
        days: days,
        weeks: weeks,
        months: months,
        systemDatetime: systemDatetime,
        aFewSecondsAgoText: aFewSecondsAgoText,
        aFewMinutesAgoText: aFewMinutesAgoText,
        someHoursAgoText: someHoursAgoText,
        yesterdayText: yesterdayText,
        aFewDaysAgoText: aFewDaysAgoText,
        lastWeekText: lastWeekText,
        aFewWeeksAgoText: aFewWeeksAgoText,
        lastMonthText: lastMonthText,
        aFewMonthsAgoText: aFewMonthsAgoText,
        lastYearText: lastYearText,
        someYearsAgoText: someYearsAgoText);
  }

  ///تبدیل تاریخ میلادی به نوشتاری شمسی
  String toPersianDateStr({
    bool strYear = false,
    bool strMonth = true,
    bool strDay = false,
    bool showDayStr = false,
    String seprator = " ",
    String monthString = " ",

    ///نام ماه های افغانی مثل: حمل، ثور ....
    bool useAfghaniMonthName = false,
  }) {
    var input = this.toPersianDate();
    var splitedStr = input.split("/");
    String outputString = "";

    outputString += showDayStr
        ? NumberUtility.getPersianDayLetter(this.weekday.toString()) + seprator
        : "";

    outputString += strDay ? splitedStr[2].toWord() : splitedStr[2];
    outputString += seprator;

    outputString += strMonth
        ? NumberUtility.getPersianMonthLetter(splitedStr[1],
                useAfghaniMonthName: useAfghaniMonthName) +
            monthString
        : splitedStr[1];
    outputString += seprator;

    outputString += strYear ? splitedStr[0].toWord() : splitedStr[0];

    return outputString;
  }
}
