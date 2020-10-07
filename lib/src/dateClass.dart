import 'dart:core';

class PersianDate {
  static const _persianLength = 365.24219879;
  static const _gregorianLength = 365.2425;
  static const _gregorianOriginFromPersianBase = 629964;
  static final _gregorianMonthLength = [
    0,
    31,
    28,
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

  int year;
  int month;
  int day;

  @override
  String toString() {
    return '$year/${month.toString().padLeft(2, '0')}/${day.toString().padLeft(2, '0')}';
  }

  PersianDate(DateTime date) {
    // passed days from Greg orig
    final d = ((date.year - 1) * _gregorianLength).ceil();
    final persianBase = d +
        _gregorianOriginFromPersianBase +
        _getGregDayOfYear(date.year, date.month, date.day);

    final persianDayOfYear = (((persianBase / _persianLength) -
                    (persianBase / _persianLength).floor()) *
                365)
            .floor() +
        1;

    year = (persianBase / _persianLength).ceil() - 2346;
    month = _month(persianDayOfYear);
    day = _dayOfMonth(persianDayOfYear);
  }
  static int _month(int day) {
    if (day < 6 * 31) {
      return (day / 31.0).ceil();
    } else {
      return (((day - 6 * 31) / 30.0) + 6).ceil();
    }
  }

  static int _dayOfMonth(int day) {
    final m = _month(day);
    if (m <= 6) {
      return day - 31 * (m - 1);
    } else {
      return day - (6 * 31) - (m - 7) * 30;
    }
  }

  static int _getGregDayOfYear(int year, int month, int day) {
    bool leap = (year % 4) == 0 && (year % 400) != 0;
    int sum = 0;
    for (int i = 0; i < month; i++) {
      if (i == 2 && leap) {
        sum += 29;
      } else {
        sum += _gregorianMonthLength[i];
      }
    }
    return sum + day - 2;
  }

  /// Constructs a new [PersianDate] instance
  /// with the given [millisecondsSinceEpoch].
  ///
  /// If [isUtc] is false then the date is in the local time zone.
  ///
  /// The constructed [PersianDate] represents
  /// 1970-01-01T00:00:00Z + [millisecondsSinceEpoch] ms in the given
  /// time zone (local or UTC).
  ///
  PersianDate.fromMillisecondsSinceEpoch(int millisecondsSinceEpoch,
      {bool isUtc = false})
      : this(DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch,
            isUtc: isUtc));

  /// Constructs a new [PersianDate] instance
  /// with the given [microsecondsSinceEpoch].
  ///
  /// If [isUtc] is false then the date is in the local time zone.
  ///
  /// The constructed [PersianDate] represents
  /// 1970-01-01T00:00:00Z + [microsecondsSinceEpoch] us in the given
  /// time zone (local or UTC).
  PersianDate.fromMicrosecondsSinceEpoch(int microsecondsSinceEpoch,
      {bool isUtc = false})
      : this(DateTime.fromMicrosecondsSinceEpoch(microsecondsSinceEpoch,
            isUtc: isUtc));
}
