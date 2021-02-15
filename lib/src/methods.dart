// Copyright (c) 2020, Mehdi Nemati.
library persian_number_utility;

import './wordClass.dart';
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
    if (number == null || number == "") {
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

  ///string is numeric or not
  static bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
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
  static String getPersianMonthLetter(String monthNumber) {
    monthNumber = changeDigit(monthNumber, NumStrLanguage.English);
    String outputText = "";
    if (monthNumber.startsWith('0')) {
      monthNumber = monthNumber.replaceAll("0", "");
    }
    switch (monthNumber) {
      case "1":
        {
          outputText = "فروردین";
          break;
        }
      case "2":
        {
          outputText = "اردیبهشت";
          break;
        }
      case "3":
        {
          outputText = "خرداد";
          break;
        }
      case "4":
        {
          outputText = "تیر";
          break;
        }
      case "5":
        {
          outputText = "مرداد";
          break;
        }
      case "6":
        {
          outputText = "شهریور";
          break;
        }

      case "7":
        {
          outputText = "مهر";
          break;
        }
      case "8":
        {
          outputText = "ابان";
          break;
        }
      case "9":
        {
          outputText = "اذر";
          break;
        }

      case "10":
        {
          outputText = "دی";
          break;
        }
      case "11":
        {
          outputText = "بهمن";
          break;
        }
      case "12":
        {
          outputText = "اسفند";
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
}
