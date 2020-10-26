import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NumToStr(),
    );
  }
}

class NumToStr extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String number = "100092"; //number here

    return Scaffold(
        body: new Center(
            child: new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        //تبدیل عدد به حروف فارسی - convert number to persian (farsi) letter
        Text(number.toWord()), //صد هزار و نود و دو

        //تبدیل عدد به حروف انگلیسی - convert number to english letter
        Text(number.toWord(
            lang: NumStrLanguage.English)), //one hundred thousand ninety two

        //رشته ورودی عددی هست یا نه - string is numeric or not
        Text(number.isNumeric().toString()), //true

        //جدا سازی سه رقمی ارقام با ویرگول - separate an integer by comma for every three digits
        Text(number.seRagham()), //100,092

        //جدا سازی سه رقمی ارقام با علامت انتخابی - separate an integer by custom character for every three digits
        Text(number.seRagham(separator: ".")), //100.092

        //تبدیل اعداد انگلیسی به فارسی - convert english digit to persian digit
        Text(number.toEnglishDigit()), //123456789 to ۱۲۳۴۵۶۷۸۹

        //تبدیل اعداد فارسی یا عربی به انگلیسی - convert persian/arabic digit to english digit
        Text(number.toEnglishDigit()), //۱۲۳۴۵۶۷۸۹ to 123456789

        //جدا سازی اعداد از رشته - extract number from string
        Text("123456+.abc".extractNumber()), //۱۲۳۴۵۶

        //جدا سازی اعداد از رشته - extract number from string
        Text("number123456اب ج -"
            .extractNumber(toDigit: NumStrLanguage.English)), //123456

        //تبدیل تاریخ میلادی به تاریخ شمسی
        Text(DateTime.now().toPersianDate()), //۱۳۹۹/۰۷/۱۶

        //تبدیل تاریخ میلادی به تاریخ شمسی از متن
        Text("2020-10-07T07:47:03.233Z".toPersianDigit()), //۱۳۹۹/۰۷/۱۶

        //تبدیل تاریخ میلادی به متن تاریخ شمسی
        Text(DateTime.now().toPersianDateStr(
            strDay: true, strMonth: true)), // شانزده مهر  ۱۳۹۹
        Text(DateTime.now()
            .toPersianDateStr(showDayStr: true)), //چهارشنبه ۱۶ مهر  ۱۳۹۹

        //صحیح بودن کد ملی ایرانیان - Checking the validity of the Iranian National Code
        Text('1234567890'.isValidIranianNationalCode().toString()), // false

        //بررسی صحیح بودن شماره موبایل ایرانیان - Checking the validity of the Iranian mobile number
        Text('12345678901'.isValidIranianMobileNumber().toString()), // false
        Text('09353391994'.isValidIranianMobileNumber().toString()), // true
        Text('+989353391994'.isValidIranianMobileNumber().toString()), // true
        Text('00989353391994'.isValidIranianMobileNumber().toString()) // true
      ],
    )));
  }
}
