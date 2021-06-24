import 'dart:core';

class PersianDate {
  toJalali(int y, int m, int d, {bool twoDigits = false}) {
    var sumMonthDay = [0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334];
    var jY = 0;
    if (y > 1600) {
      jY = 979;
      y -= 1600;
    } else {
      jY = 0;
      y -= 621;
    }
    var gy = (m > 2) ? y + 1 : y;
    var day = (365 * y) +
        ((gy + 3) ~/ 4) -
        ((gy + 99) ~/ 100) +
        ((gy + 399) ~/ 400) -
        80 +
        d +
        sumMonthDay[m - 1];
    jY += 33 * (day.round() / 12053).floor();
    day %= 12053;
    jY += 4 * (day.round() / 1461).floor();
    day %= 1461;
    jY += ((day.round() - 1) / 365).floor();
    if (day > 365) day = ((day - 1).round() % 365);
    int jm;
    var jd;
    int days = day.toInt();
    if (days < 186) {
      jm = 1 + (days ~/ 31);
      jd = 1 + (days % 31);
    } else {
      jm = 7 + ((days - 186) ~/ 30);
      jd = 1 + (days - 186) % 30;
    }
    var persionDate;
    String monthString =
        twoDigits ? jm.toString().padLeft(2, '0') : jm.toString();
    String dayString =
        twoDigits ? jd.toString().padLeft(2, '0') : jd.toString();

    persionDate = "$jY/$monthString/$dayString";
    return persionDate;
  }

  jalaliToGregorian(int y, int m, int d, [String separator = "/"]) {
    int gY;
    if (y > 979) {
      gY = 1600;
      y -= 979;
    } else {
      gY = 621;
    }

    var days = (365 * y) +
        ((y / 33).floor() * 8) +
        (((y % 33) + 3) / 4) +
        78 +
        d +
        (((m < 7) ? (m - 1) * 31 : (((m - 7) * 30) + 186)));
    gY += 400 * (days ~/ 146097);
    days %= 146097;
    if (days.floor() > 36524) {
      gY += 100 * (--days ~/ 36524);
      days %= 36524;
      if (days >= 365) days++;
    }
    gY += 4 * (days ~/ 1461);
    days %= 1461;
    gY += (days - 1) ~/ 365;

    if (days > 365) days = (days - 1) % 365;
    var gD = (days + 1).floor();
    var montDays = [
      0,
      31,
      (((gY % 4 == 0) && (gY % 100 != 0)) || (gY % 400 == 0)) ? 29 : 28,
      31,
      30,
      31,
      30,
      31,
      31,
      30,
      31,
      30,
      31
    ];
    int i = 0;
    for (; i <= 12; i++) {
      if (gD <= montDays[i]) break;
      gD -= montDays[i];
    }
    var gregorianDate;
    gregorianDate = "${gY}${separator}${i}${separator}${gD}";
    return gregorianDate;
  }
}
