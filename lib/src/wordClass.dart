class EnWord {
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

class FaWord {
  static final List<String> tensNames = [
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

  static final List<String> numNames = [
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

  static final List<String> thousandsNames = [
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

  static final Map<String, int> tensMap = {
    "": 0,
    "ده": 10,
    "بیست": 20,
    "سی": 30,
    "چهل": 40,
    "پنجاه": 50,
    "شصت": 60,
    "هفتاد": 70,
    "هشتاد": 80,
    "نود": 90,
  };

  static final Map<String, int> numsMap = {
    "": 0,
    "یک": 1,
    "دو": 2,
    "سه": 3,
    "چهار": 4,
    "پنج": 5,
    "شش": 6,
    "هفت": 7,
    "هشت": 8,
    "نه": 9,
    "ده": 10,
    "یازده": 11,
    "دوازده": 12,
    "سیزده": 13,
    "چهارده": 14,
    "پانزده": 15,
    "شانزده": 16,
    "هفده": 17,
    "هجده": 18,
    "نوزده": 19,
  };

  static final Map<String, int> thousandsMap = {
    "": 0,
    "صد": 100,
    "دویست": 200,
    "سیصد": 300,
    "چهارصد": 400,
    "پانصد": 500,
    "ششصد": 600,
    "هفتصد": 700,
    "هشتصد": 800,
    "نهصد": 900,
  };

  static final Map<String, int> millionsMap = {
    "هزار": 1000,
    "میلیون": 1000000,
    "میلیارد": 1000000000,
    "تریلیون": 1000000000000,
  };

  static int toNumber(String word) {
    List<String> words = word.split(" و");
    int finalValue = 0;
    int tempValue = 0;
    for (var word in words) {
      List<String> temps = word.split(" ");
      for (var item in temps) {
        if (numsMap.containsKey(item))
          tempValue += numsMap[item] ?? 0;
        else if (tensMap.containsKey(item))
          tempValue += tensMap[item] ?? 0;
        else if (thousandsMap.containsKey(item))
          tempValue += thousandsMap[item] ?? 0;
        else if (millionsMap.containsKey(item)) {
          if (tempValue == 0)
            tempValue += millionsMap[item]!;
          else
            tempValue *= millionsMap[item]!;
          finalValue += tempValue;
          tempValue = 0;
        } else
          throw Exception("Not correct format / Wrong language!");
      }
    }
    finalValue += tempValue;
    return finalValue;
  }

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
