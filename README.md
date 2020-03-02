# A Flutter Package for convert number to English or Persian (Farsi) letter

A Flutter Package for convert number to English or Persian (Farsi) letter and allow you to separate an integer by comma (or other) for every three digits 

پکیجی برای تبدیل اعداد به حروف فارسی یا انگلیسی و همچنین برای جدا سازی سه رقمی ارقام

See the [Dart packages](https://pub.dev/packages/persian_number_utility).

## Usage

  

Add it to your pubspec.yaml file:

  

```yaml

dependencies:

persian_number_utility: ^0.0.1

```

In your library add the following import:

  
```dart

import  'package:persian_number_utility/persian_number_utility.dart';

```


Here is an example how to use:

```dart

import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart'; //import

class NumToStr extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String number = "100092";//number here

    return Scaffold(
        body: new Center(
            child: new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        new Text(number),//the number

        //تبدیل عدد به حروف فارسی - convert number to persian (farsi) letter
        new Text(NumberUtility.toWord(number, NumStrLanguage.Farsi)),//صد هزار و نود و دو

        //تبدیل عدد به حروف انگلیسی - convert number to english letter
        new Text(NumberUtility.toWord(number, NumStrLanguage.English)),//one hundred thousand ninety two

        //رشته ورودی عددی هست یا نه - string is numeric or not
        new Text(NumberUtility.isNumeric(number).toString()),//true

        //جدا سازی سه رقمی ارقام با ویرگول - separate an integer by comma for every three digits
        new Text(NumberUtility.seRagham(number)),//100,092

        //جدا سازی سه رقمی ارقام با علامت انتخابی - separate an integer by custom character for every three digits
        new Text(NumberUtility.seRagham(number, separator: "."))//100.092

        //تبدیل اعداد انگلیسی به فارسی - convert english digit to persian digit
        new Text(NumberUtility.seRagham(number, NumStrLanguage.Farsi))//123456789 to ۱۲۳۴۵۶۷۸۹

        //تبدیل اعداد فارسی یا عربی به انگلیسی - convert persian/arabic digit to english digit
        new Text(NumberUtility.seRagham(number, NumStrLanguage.English))//۱۲۳۴۵۶۷۸۹ to 123456789
      ],
    )));
  }
}


```


## Getting Started

This project is a starting point for a Dart
[package](https://flutter.dev/developing-packages/),
a library module containing code that can be shared easily across
multiple Flutter or Dart projects.

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
