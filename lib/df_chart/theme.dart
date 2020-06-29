import 'dart:ui';

abstract class ChartTheme {
  Color get borderColor;

  Color get axisLineColor;

  Color get axisTextColor;

  Color get axisGridColor;
}

class WhiteChartTheme extends ChartTheme {
  @override
  Color get borderColor => Color(0xFFDFDFDF);

  @override
  Color get axisLineColor => borderColor;

  @override
  Color get axisTextColor => Color(0xFFD4D4D4);

  @override
  Color get axisGridColor => Color(0xFFDFDFDF);
}