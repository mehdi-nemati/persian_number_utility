import 'validators/regex_validators.dart';

import 'date_class.dart';
import 'enums.dart';
import 'difference_date.dart';
import 'methods.dart';
import 'validators/bank_validator.dart';
import 'validators/national_code.dart';

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

  /// convert 6037991123456789 to 6037-9911-2345-6789
  String charRagham({String separator = "-"}) {
    return NumberUtility.charRagham(this, separator: separator);
  }

  ///convert number to string , like: 1000 to 'one thousand' or 'هزار'
  String toWord({NumStrLanguage lang = NumStrLanguage.Farsi}) {
    return NumberUtility.toWord(this, lang);
  }

  ///convert string to number , like: هزار to 1000
  int toNumber() {
    return NumberUtility.toNumber(this);
  }

  ///string is numeric or not
  bool isNumeric() {
    return NumberUtility.isNumeric(this);
  }

  ///string is contains digits
  bool isContainDigits() {
    return NumberUtility.isContainDigits(this);
  }

  @Deprecated("استفاده شود toPersianDate به خاطر اشتباه نوشتاری در متد از")

  /// استفاده شود toPersianDate به خاطر اشتباه نوشتاری در متد از
  String toPersinaDate({NumStrLanguage digitType = NumStrLanguage.Farsi}) {
    try {
      var inputStr = replaceAll("/", "-");
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
      var inputStr = replaceAll("/", "-");
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

  //صحیح بودن شماره شبا بانکی
  bool isValidBankShebaNumber() {
    return BankValidator.verifyShebaNumber(this);
  }

  //صحیح بودن شماره موبایل ایرانیان
  bool isValidIranianMobileNumber() {
    return RegexValidators.isValidIranianMobileNumber(this);
  }

  //صحیح بودن کد پستی ایرانیان
  bool isValidIranianPostalCode() {
    return RegexValidators.isValidIranianPostalCode(this);
  }

  //تبدیل به تومان - Convert price to Toman
  String beToman() {
    var strNumber = NumberUtility.extractNumber(this, NumStrLanguage.English);
    var convertedNumber = int.parse(strNumber);
    return (convertedNumber / 10).toString().replaceAll('.0', '');
  }

   // تبدیل به تومان به صورت رند شده - Convert price to Toman and rounded
  String beTomanRounded() {
    var strNumber = NumberUtility.extractNumber(this, NumStrLanguage.English);
    var convertedNumber = int.parse(strNumber);
    return (convertedNumber / 10).round().toString();
  }

  //تبدیل به ریال - Convert price to Rial
  String beRial() {
    var strNumber = NumberUtility.extractNumber(this, NumStrLanguage.English);
    var convertedNumber = int.parse(strNumber);
    return (convertedNumber * 10).toString();
  }

  //گرفتن نام بانک از روی شماره کارت،
  // اعتبار سنجی شماره کارت در این متد انجام نمیشود
  //حداقل رقم وارد شده 6 عدد میباشد
  String getBankNameFromCardNumber() {
    return NumberUtility.getBankNameFromCardNumber(this);
  }

  /// تبدیل حروف عربی و ... به حروف استاندارد فارسی
  String fixPersianChars() {
    return NumberUtility.fixPersianChars(this);
  }
}

extension PersianDateTimeExtensions on DateTime {
  ///تبدیل تاریخ میلادی به تاریخ شمسی
  String toPersianDate(
      {NumStrLanguage digitType = NumStrLanguage.Farsi,
      bool twoDigits = true,
      bool showTime = false,
      String timeSeprator = " ",
      bool changeDirectionShowTimw = true,
      bool showTimeSecond = false}) {
    PersianDate persianDate = PersianDate();
    String time = "";
    if (showTime) {
      time =
          "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}";
      if (showTimeSecond) {
        time = "$time:${second.toString().padLeft(2, '0')}";
      }
      if (changeDirectionShowTimw) {
        time = timeSeprator + time;
      } else {
        time = time + timeSeprator;
      }
    }

    if (changeDirectionShowTimw) {
      return NumberUtility.changeDigit(
          persianDate
                  .toJalali(year, month, day, twoDigits: twoDigits)
                  .toString() +
              time,
          digitType);
    } else {
      return NumberUtility.changeDigit(
          time +
              persianDate
                  .toJalali(year, month, day, twoDigits: twoDigits)
                  .toString(),
          digitType);
    }
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
    var input = toPersianDate();
    var splitedStr = input.split("/");
    String outputString = "";

    outputString += showDayStr
        ? NumberUtility.getPersianDayLetter(weekday.toString()) + seprator
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
