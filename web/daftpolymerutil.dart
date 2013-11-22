library DaftPolymerUtil;

/***
 * Oddball collection of handy Polymer classes and functions.
 */

import 'package:polymer_expressions/filter.dart';

// <--Seth Ladd's Transformer Code
// See https://github.com/sethladd/dart-polymer-dart-examples/tree/master/web/bind_number_to_text_field_with_filter
class StringToInt extends Transformer<String, int> {
  final int radix;
  StringToInt({this.radix: 10});
  String forward(int i) => '$i';
  int reverse(String s) => s == null ? null : int.parse(s, radix: radix, onError: (s) => null);
}
// Seth Ladd's Transformer Code -->