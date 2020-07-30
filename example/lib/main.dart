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
        new Text(number),
        new Text(NumberUtility.toWord(
            number, NumStrLanguage.Farsi)), //صد هزار و نود و دو
        new Text(NumberUtility.toWord(
            number, NumStrLanguage.English)), //one hundred thousand ninety two
        new Text(NumberUtility.isNumeric(number).toString()), //true
        new Text(NumberUtility.seRagham("100092")), //100,092
        new Text(NumberUtility.seRagham(number, separator: ".")), //100.092
        new Text(NumberUtility.extractNumber(
            "123456+.abc", NumStrLanguage.Farsi)), //100.092
        new Text(NumberUtility.extractNumber(
            "number123456اب ج -", NumStrLanguage.English)) //100.092
      ],
    )));
  }
}
