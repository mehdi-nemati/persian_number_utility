import 'package:flutter/services.dart';
import '../extensions.dart';

class PersianDigitOnlyTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
        text: newValue.text.toPersianDigit(),
        selection: newValue.selection,
        composing: newValue.composing);
  }
}

class PersianDigitOnlyTextInputFormatterWithRange
    extends PersianDigitOnlyTextInputFormatter {
  final int? min;
  final int? max;

  PersianDigitOnlyTextInputFormatterWithRange({this.min, this.max})
      : assert(min == null || max == null || max > min);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var val = int.tryParse(newValue.text.toEnglishDigit());
    if (val == null) return newValue;
    if (min != null && val < min!) val = min!;
    if (max != null && val > max!) val = max!;
    var newest = TextEditingValue(
        text: val.toString(),
        selection: TextSelection.collapsed(offset: val.toString().length),
        composing: TextRange.empty);

    return super.formatEditUpdate(oldValue, newest);
  }
}
