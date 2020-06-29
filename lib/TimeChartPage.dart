import 'package:flutter/material.dart';

import 'df_chart/TimeShareChart.dart';
import 'df_chart/theme.dart';

class TimeChartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: SizedBox(
        height: 500,
        child: TimeShareChart(chartTheme: WhiteChartTheme(),),
      ),
    );
  }
}
