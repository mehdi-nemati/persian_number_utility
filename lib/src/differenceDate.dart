class DifferenceDate {
  ///نمایش اختلاف بین دو تاریخ به صورت خلاصه وار و متنی
  static String getStringDate(DateTime inputDatetime,
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
    if (systemDatetime == null) {
      systemDatetime = DateTime.now();
    }

    final differenceInDays = systemDatetime.difference(inputDatetime).inDays;
    if (differenceInDays > days) {
      if (differenceInDays > 7 && differenceInDays < 14) {
        return lastWeekText;
      } else if (differenceInDays < 7 * weeks) {
        return aFewWeeksAgoText;
      } else if (differenceInDays >= 30 && differenceInDays < 60) {
        return lastMonthText;
      } else if (differenceInDays < 30 * months) {
        return aFewMonthsAgoText;
      } else if (differenceInDays >= 365 && differenceInDays < 730) {
        return lastYearText;
      } else {
        return someYearsAgoText;
      }
    } else {
      final differenceInSeconds =
          systemDatetime.difference(inputDatetime).inSeconds;
      if (differenceInSeconds < seconds) {
        return aFewSecondsAgoText;
      } else if (differenceInSeconds < 60 * minutes) {
        return aFewMinutesAgoText;
      } else if (differenceInSeconds < 3600 * hours) {
        return someHoursAgoText;
      } else if (differenceInSeconds >= 3600 * 24 &&
          differenceInSeconds < 3600 * 24 * 2) {
        return yesterdayText;
      } else {
        return aFewDaysAgoText;
      }
    }
  }
}
