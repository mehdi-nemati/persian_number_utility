// Copyright (c) 2020, Mehdi Nemati.
library persian_number_utility;

class NumberUtility {
  ///convert number to string , like: 1000 to 'one thousand' or 'هزار'
  static String toWord(String number, NumStrLanguage lang) {
    String _words = "";
    String _result = "";
    number = changeDigit(number, NumStrLanguage.English);
    if (!_ifullNumber(number)) {
      return "";
    }
    if (number == null || number == "") {
      return '';
    }
    switch (lang) {
      case NumStrLanguage.English:
        _words = _EnWord.toWord(number);
        break;
      case NumStrLanguage.Farsi:
        _words = _FaWord.toWord(number);
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
    number = number.replaceAll(separator, '');
    for (var i = number.length; i > 0;) {
      if (i > 3) {
        str = separator + number.substring(i - 3, i) + str;
      } else {
        str = number.substring(0, i) + str;
      }
      i = i - 3;
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
    if (monthNumber.startsWith('0'))
      monthNumber = monthNumber.replaceAll("0", "");
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

enum NumStrLanguage { Farsi, English }

bool _ifullNumber(String s) {
  if (s == null) {
    return false;
  }
  return double.tryParse(s) != null;
}

class _EnWord {
  static String toWord(String inputNumber) {
    int number = int.parse(inputNumber);
    if (number == 0) {
      return "zero";
    }
    String fullNumber = inputNumber;
    for (var i = 0; i < 15 - fullNumber.length; i++) {
      inputNumber = "0" + inputNumber;
    }
    fullNumber = inputNumber;
    int trillion = int.parse(fullNumber.substring(0, 3));
    int billions = int.parse(fullNumber.substring(3, 6));
    int millions = int.parse(fullNumber.substring(6, 9));
    int hundredThousands = int.parse(fullNumber.substring(9, 12));
    int thousands = int.parse(fullNumber.substring(12, 15));

    String tradtrillion;

    switch (trillion) {
      case 0:
        tradtrillion = "";
        break;
      case 1:
        tradtrillion = _convertLessThanOneThousand(trillion) + " Trillion ";
        break;
      default:
        tradtrillion = _convertLessThanOneThousand(trillion) + " Trillion ";
    }
    String result = tradtrillion;

    String tradBillions;

    switch (billions) {
      case 0:
        tradBillions = "";
        break;
      case 1:
        tradBillions = _convertLessThanOneThousand(billions) + " billion ";
        break;
      default:
        tradBillions = _convertLessThanOneThousand(billions) + " billion ";
    }
    result += tradBillions;

    String tradMillions;

    switch (millions) {
      case 0:
        tradMillions = "";
        break;
      case 1:
        tradMillions = _convertLessThanOneThousand(millions) + " million ";
        break;
      default:
        tradMillions = _convertLessThanOneThousand(millions) + " million ";
    }
    result = result + tradMillions;

    String tradHundredThousands;
    switch (hundredThousands) {
      case 0:
        tradHundredThousands = "";
        break;
      case 1:
        tradHundredThousands = "one thousand ";
        break;
      default:
        tradHundredThousands =
            _convertLessThanOneThousand(hundredThousands) + " thousand ";
    }
    result = result + tradHundredThousands;

    String tradThousand;
    tradThousand = _convertLessThanOneThousand(thousands);
    result = result + tradThousand;
    return result;
  }

  static String _convertLessThanOneThousand(int number) {
    List<String> tensNames = [
      "",
      " ten",
      " twenty",
      " thirty",
      " forty",
      " fifty",
      " sixty",
      " seventy",
      " eighty",
      " ninety"
    ];

    List<String> numNames = [
      "",
      " one",
      " two",
      " three",
      " four",
      " five",
      " six",
      " seven",
      " eight",
      " nine",
      " ten",
      " eleven",
      " twelve",
      " thirteen",
      " fourteen",
      " fifteen",
      " sixteen",
      " seventeen",
      " eighteen",
      " nineteen"
    ];
    String soFar;
    if (number % 100 < 20) {
      soFar = numNames[number % 100];
      number = number ~/ 100;
    } else {
      soFar = numNames[number % 10];
      number = number ~/ 10;
      soFar = tensNames[number % 10] + soFar;
      number = number ~/ 10;
    }
    if (number == 0) {
      return soFar;
    }
    return numNames[number] + " hundred" + soFar;
  }
}

class _FaWord {
  static String toWord(String inputNumber) {
    int number = int.parse(inputNumber);
    if (number == 0) {
      return "صفر";
    }
    String fullNumber = inputNumber;
    for (var i = 0; i < 15 - fullNumber.length; i++) {
      inputNumber = "0" + inputNumber;
    }
    fullNumber = inputNumber;

    int trillion = int.parse(fullNumber.substring(0, 3));
    int billions = int.parse(fullNumber.substring(3, 6));
    int millions = int.parse(fullNumber.substring(6, 9));
    int hundredThousands = int.parse(fullNumber.substring(9, 12));
    int thousands = int.parse(fullNumber.substring(12, 15));

    String tradtrillion;

    switch (trillion) {
      case 0:
        tradtrillion = "";
        break;
      case 1:
        tradtrillion = _convertLessThanOneThousand(trillion) + " تریلیون ";
        break;
      default:
        tradtrillion = _convertLessThanOneThousand(trillion) + " تریلیون و";
    }
    String result = tradtrillion;

    String tradBillions;

    switch (billions) {
      case 0:
        tradBillions = "";
        break;
      default:
        tradBillions = _convertLessThanOneThousand(billions) + " میلیارد و";
    }
    result += tradBillions;

    String tradMillions;

    switch (millions) {
      case 0:
        tradMillions = "";
        break;
      default:
        tradMillions = _convertLessThanOneThousand(millions) + " میلیون و";
    }
    result = result + tradMillions;

    String tradHundredThousands;
    switch (hundredThousands) {
      case 0:
        tradHundredThousands = "";
        break;
      case 1:
        tradHundredThousands = "هزار و";
        break;
      default:
        tradHundredThousands =
            _convertLessThanOneThousand(hundredThousands) + " هزار و";
    }
    result = result + tradHundredThousands;

    String tradThousand;
    tradThousand = _convertLessThanOneThousand(thousands);
    result = result + tradThousand;

    if (result.endsWith(" و")) {
      result = result.substring(0, result.length - 2);
    }

    return result;
  }

  static String _convertLessThanOneThousand(int number) {
    List<String> tensNames = [
      "",
      " ده و",
      " بیست و",
      " سی و",
      " چهل و",
      " پنجاه و",
      " شصت و",
      " هفتاد و",
      " هشتاد و",
      " نود و"
    ];

    List<String> numNames = [
      "",
      " یک",
      " دو",
      " سه",
      " چهار",
      " پنج",
      " شش",
      " هفت",
      " هشت",
      " نه",
      " ده",
      " یازده",
      " دوازده",
      " سیزده",
      " چهارده",
      " پانزده",
      " شانزده",
      " هفده",
      " هجده",
      " نوزده"
    ];

    List<String> thousandsNames = [
      "",
      " صد و",
      " دویست و",
      " سیصد و",
      " چهارصد و",
      " پانصد و",
      " ششصد و",
      " هفتصد و",
      " هشتصد و",
      " نهصد و"
    ];
    String soFar;
    if (number % 100 < 20) {
      soFar = numNames[number % 100];
      number = number ~/ 100;
    } else {
      soFar = numNames[number % 10];
      number = number ~/ 10;
      soFar = tensNames[number % 10] + soFar;
      number = number ~/ 10;
    }
    if (number == 0) {
      if (soFar.endsWith(" و")) {
        soFar = soFar.substring(0, soFar.length - 2);
      }
      return soFar;
    }
    var str = "";
    str = (thousandsNames[number] + soFar);
    if (str.endsWith(" و") || str.endsWith("و ")) {
      str = str.substring(0, str.length - 2);
    }
    return str;
  }
}
