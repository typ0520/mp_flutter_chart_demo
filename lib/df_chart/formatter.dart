import 'package:mp_chart/mp/core/value_formatter/value_formatter.dart';

class PriceValueFormatter extends ValueFormatter {
  @override
  String getFormattedValue1(double value) {
    return value.toString();
  }
}