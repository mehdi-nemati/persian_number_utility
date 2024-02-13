import 'package:test/test.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

void main() {
  group('Number to word methods', () {
    group('converting English numbers to words', () {
      test('1000 to english word', () {
        expect(NumberUtility.toWord('1000', NumStrLanguage.English),
            'one thousand');
      });
      test('100 to english word', () {
        expect(
            NumberUtility.toWord('100', NumStrLanguage.English), 'one hundred');
      });
    });

    group('converting Farsi numbers to words', () {
      test('1000 to persian word', () {
        expect(NumberUtility.toWord('1000', NumStrLanguage.Farsi), 'هزار');
      });
      test('100 to persian word', () {
        expect(NumberUtility.toWord('100', NumStrLanguage.Farsi), 'صد');
      });
      test('10522 to persian word', () {
        expect(NumberUtility.toWord('10522', NumStrLanguage.Farsi),
            'ده هزار و پانصد و بیست و دو');
      });
    });
  });

  group('Persian word to number methods', () {
    test('converting 21000', () {
      expect(NumberUtility.toNumber('بیست و یک هزار'), 21000);
    });
    test('converting 21000', () {
      expect(NumberUtility.toNumber('صد و بیست و دو'), 122);
    });
  });

  group('seRagham method test', () {
    test('seRagham', () {
      expect(NumberUtility.seRagham('122500000'), '122,500,000');
    });
    test('seRagham with custom separator', () {
      expect(NumberUtility.seRagham('99999999',separator: '|'), '99|999|999');
    });
  });

    group('changeDigit method test', () {
    test('English to Persian digits', () {
      expect(NumberUtility.changeDigit('1234567890',NumStrLanguage.Farsi), '۱۲۳۴۵۶۷۸۹۰');
    });
    test('Persian to English digits', () {
      expect(NumberUtility.changeDigit('۱۲۳۴۵۶۷۸۹۰',NumStrLanguage.English), '1234567890');
    });
  });
}
