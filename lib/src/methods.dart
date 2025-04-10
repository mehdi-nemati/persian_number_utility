// Copyright (c) 2020, Mehdi Nemati.
library persian_number_utility;

import 'word_class.dart';
import 'enums.dart';

class NumberUtility {
  ///convert number to string , like: 1000 to 'one thousand' or 'هزار'
  static String toWord(String number, NumStrLanguage lang) {
    String _words = "";
    String _result = "";
    number = changeDigit(number, NumStrLanguage.English);
    number = extractNumber(number, NumStrLanguage.English);
    if (!isNumeric(number)) {
      return "";
    }
    if (number == "") {
      return '';
    }
    switch (lang) {
      case NumStrLanguage.English:
        _words = EnWord.toWord(number);
        break;
      case NumStrLanguage.Farsi:
        _words = FaWord.toWord(number);
        break;
    }
    _result = _words.replaceAll("^\\s+", "").replaceAll("\\b\\s{2,}\\b", " ");
    return _result.trim();
  }

  /// Converts a string like 'هزار' to 1000
  static int toNumber(String number) {
    return FaWord.toNumber(number);
  }

  ///string is numeric or not
  static bool isNumeric(String? s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  ///string is contains digits
  static bool isContainDigits(String? s) {
    if (s == null) {
      return false;
    }
    return extractNumber(s, NumStrLanguage.English) != "";
  }

  ///convert 123456789 to 123,456,789
  static String seRagham(String number, {String separator = ","}) {
    String str = "";
    var numberSplit = number.split('.');
    number = numberSplit[0].replaceAll(separator, '');
    for (var i = number.length; i > 0;) {
      if (i > 3) {
        str = separator + number.substring(i - 3, i) + str;
      } else {
        str = number.substring(0, i) + str;
      }
      i = i - 3;
    }
    if (numberSplit.length > 1) {
      str += '.' + numberSplit[1];
    }
    return str;
  }

  ///convert 123456789 to ۱۲۳۴۵۶۷۸۹  Or  ۱۲۳۴۵۶۷۸۹ to 123456789
  static String changeDigit(String number, NumStrLanguage toDigit) {
    var persianNumbers = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
    var arabicNumbers = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    var enNumbers = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "."];

    if (toDigit == NumStrLanguage.English) {
      for (var i = 0; i < 10; i++) {
        number = number
            .replaceAll(RegExp(persianNumbers[i]), enNumbers[i])
            .replaceAll(RegExp(arabicNumbers[i]), enNumbers[i]);
      }
    } else {
      for (var i = 0; i < 10; i++) {
        number = number
            .replaceAll(RegExp(enNumbers[i]), persianNumbers[i])
            .replaceAll(RegExp(enNumbers[i]), arabicNumbers[i]);
      }
    }
    return number;
  }

  ///extract number from string; abc123456789xyz to ۱۲۳۴۵۶۷۸۹  Or  ابپ۱۲۳۴۵۶۷۸۹ن to 123456789
  static String extractNumber(String inputString, NumStrLanguage toDigit) {
    String number = "";
    inputString = changeDigit(inputString, NumStrLanguage.English);
    number = inputString.replaceAll(RegExp(r'[^0-9]'), ''); // '23'
    return changeDigit(number, toDigit);
  }

  /// بدست اوردن نام ماه شمسی
  static String getPersianMonthLetter(
    String monthNumber, {
    bool useAfghaniMonthName = false,
  }) {
    monthNumber = changeDigit(monthNumber, NumStrLanguage.English);
    String outputText = "";
    if (monthNumber.startsWith('0')) {
      monthNumber = monthNumber.replaceAll("0", "");
    }
    switch (monthNumber) {
      case "1":
        {
          outputText = useAfghaniMonthName ? "حمل" : "فروردین";
          break;
        }
      case "2":
        {
          outputText = useAfghaniMonthName ? "ثور" : "اردیبهشت";
          break;
        }
      case "3":
        {
          outputText = useAfghaniMonthName ? "جوزا" : "خرداد";
          break;
        }
      case "4":
        {
          outputText = useAfghaniMonthName ? "سرطان" : "تیر";
          break;
        }
      case "5":
        {
          outputText = useAfghaniMonthName ? "اسد" : "مرداد";
          break;
        }
      case "6":
        {
          outputText = useAfghaniMonthName ? "سنبله" : "شهریور";
          break;
        }

      case "7":
        {
          outputText = useAfghaniMonthName ? "میزان" : "مهر";
          break;
        }
      case "8":
        {
          outputText = useAfghaniMonthName ? "عقرب" : "ابان";
          break;
        }
      case "9":
        {
          outputText = useAfghaniMonthName ? "قوس" : "اذر";
          break;
        }

      case "10":
        {
          outputText = useAfghaniMonthName ? "جدی" : "دی";
          break;
        }
      case "11":
        {
          outputText = useAfghaniMonthName ? "دلو" : "بهمن";
          break;
        }
      case "12":
        {
          outputText = useAfghaniMonthName ? "حوت" : "اسفند";
          break;
        }
    }
    return outputText;
  }

  /// بدست اوردن نام روز
  static String getPersianDayLetter(String dayNumber) {
    dayNumber = changeDigit(dayNumber, NumStrLanguage.English);
    String outputText = "";
    if (dayNumber.startsWith('0')) dayNumber = dayNumber.replaceAll("0", "");
    switch (dayNumber) {
      case "1":
        {
          outputText = "دوشنبه";
          break;
        }
      case "2":
        {
          outputText = "سه شنبه";
          break;
        }
      case "3":
        {
          outputText = "چهارشنبه";
          break;
        }
      case "4":
        {
          outputText = "پنج شنبه";
          break;
        }
      case "5":
        {
          outputText = "جمعه";
          break;
        }
      case "6":
        {
          outputText = "شنبه";
          break;
        }
      case "7":
        {
          outputText = "یکشنبه";
          break;
        }
    }
    return outputText;
  }

  static String getBankNameFromCardNumber(String cartNumber) {
    if (cartNumber.length < 6) {
      return '-';
    }
    cartNumber = cartNumber.substring(0, 6);

    switch (cartNumber) {
      case '636214':
        return 'بانک آینده';

      case '627381':
        return 'بانک انصار';

      case '505785':
        return 'بانک ایران زمین';

      case '622106':
      case '627884':
      case '639194':
        return 'بانک پارسیان';

      case '502229':
      case '639347':
        return 'بانک پاسارگاد';

      case '627760':
        return 'پست بانک ایران';

      case '585983':
      case '627353':
        return 'بانک تجارت';

      case '502908':
        return 'بانک توسعه تعاون';

      case '504172':
        return 'بانک رسالت';

      case '207177':
      case '627648':
        return 'بانک توسعه صادرات';

      case '636949':
        return 'بانک حکمت ایرانیان';

      case '585947':
        return 'بانک خاورمیانه';

      case '627412':
        return 'بانک اقتصاد نوین';

      case '502938':
        return 'بانک دی';

      case '589463':
        return 'بانک رفاه کارگران';

      case '621986':
        return 'بانک سامان';

      case '589210':
        return 'بانک سپه';

      case '639607':
        return 'بانک سرمایه';

      case '639346':
        return 'بانک سینا';

      case '504706':
      case '502806':
        return 'بانک شهر';

      case '603769':
        return 'بانک صادرات ایران';

      case '627961':
        return 'بانک صنعت و معدن';

      case '639599':
        return 'بانک قوامین';

      case '627488':
      case '502910':
        return 'بانک کارآفرین';

      case '639217':
      case '603770':
        return 'بانک کشاورزی';

      case '505416':
        return 'بانک گردشگری';

      case '636795':
        return 'بانک مرکزی';

      case '628023':
        return 'بانک مسکن';

      case '991975':
      case '610433':
        return 'بانک ملت';

      case '603799':
        return 'بانک ملی ایران';

      case '606373':
        return 'بانک قرض الحسنه مهر ایران';

      case '505801':
        return 'موسسه کوثر';

      case '606256':
        return 'موسسه اعتباری ملل';

      case '628157':
        return 'موسسه اعتباری توسعه';

      case '639370':
        return 'بانک مهر اقتصاد';

      default:
        return '-';
    }
  }

  /// جداسازی چهار رقم اعداد (استفاده معمول برای خوانا کردن شماره کارت)
  static String charRagham(String inputNumber, {String separator = "-"}) {
    String outputString = "";
    var numberSplit = inputNumber.split('.');
    inputNumber = numberSplit[0].replaceAll(separator, '');
    for (var i = inputNumber.length; i > 0;) {
      if (i > 4) {
        outputString =
            separator + inputNumber.substring(i - 4, i) + outputString;
      } else {
        outputString = inputNumber.substring(0, i) + outputString;
      }
      i = i - 4;
    }
    return outputString;
  }

  /// تبدیل حروف عربی و ... به حروف استاندارد فارسی
  static String fixPersianChars(String inputString) {
    return inputString
        .replaceAll("ﮎ", "ک")
        .replaceAll("ﮏ", "ک")
        .replaceAll("ﮐ", "ک")
        .replaceAll("ﮑ", "ک")
        .replaceAll("ك", "ک")
        .replaceAll("ي", "ی")
        .replaceAll(" ", " ")
        .replaceAll("ھ", "ه")
        .replaceAll("ئ", "ی");
  }
}
