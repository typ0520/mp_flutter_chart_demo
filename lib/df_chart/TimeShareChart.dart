import 'dart:convert';

import 'package:mp_flutter_chart_demo/df_chart/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:mp_chart/mp/core/adapter_android_mp.dart';
import 'package:mp_chart/mp/core/data/combined_data.dart';
import 'package:mp_chart/mp/core/data/line_data.dart';
import 'package:mp_chart/mp/core/data_set/line_data_set.dart';
import 'package:mp_chart/mp/core/description.dart';
import 'package:mp_chart/mp/core/entry/entry.dart';
import 'package:mp_chart/mp/core/enums/axis_dependency.dart';
import 'package:mp_chart/mp/core/enums/x_axis_position.dart';
import 'package:mp_chart/mp/core/enums/y_axis_label_position.dart';
import 'package:mp_chart/mp/core/value_formatter/value_formatter.dart';

import '../Kline.dart';
import 'DFCombinedChart.dart';
import 'formatter.dart';
import 'constants.dart';
import 'ext.dart';

class TimeShareChart extends StatefulWidget {
  final ChartTheme chartTheme;

  TimeShareChart({this.chartTheme});

  @override
  _TimeShareChartState createState() => _TimeShareChartState();
}

class _TimeShareChartState extends State<TimeShareChart> {
  DFCombinedChartController controller;

  int _count = 720;

  @override
  void initState() {
    _initController();
    super.initState();

    this._loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
            right: 0,
            left: 0,
            top: 0,
            bottom: 0,
            child: DFCombinedChart(controller)),
      ],
    );
  }

  void _initController() {
    var desc = Description()..enabled = false;
    controller = DFCombinedChartController(
      axisLeftSettingFunction: (axisLeft, controller) {
        axisLeft
          ..enabled = false
        ;
      },
      legendSettingFunction: (legend, controller) {
        legend
          ..enabled = false;
      },
      axisRightSettingFunction: (axisRight, controller) {
        axisRight
          ..drawGridLines = (true)
          ..axisLineColor = widget.chartTheme.axisLineColor
          ..position = YAxisLabelPosition.INSIDE_CHART
          ..textSize = 10
          ..textColor = widget.chartTheme.axisTextColor
          ..gridColor = widget.chartTheme.axisGridColor
          ..axisValueFormatter = PriceValueFormatter()
          ..enableGridDashedLine(10, 10, 0)
        ;
      },
      xAxisSettingFunction: (xAxis, controller) {
        xAxis
          ..drawGridLines = (true)
          ..axisLineColor = widget.chartTheme.axisLineColor
          ..setAxisMinimum(0)
          ..position = XAxisPosition.BOTTOM_INSIDE
          ..textSize = 10
          ..textColor = widget.chartTheme.axisTextColor
          ..gridColor = widget.chartTheme.axisGridColor
          ..axisValueFormatter = _TimeValueFormatter(this)
          ..enableGridDashedLine(10, 10, 0)
        ;
      },

      noDataText: 'Loading...',
      drawMarkers: true,
      drawGridBackground: false,
      dragXEnabled: true,
      dragYEnabled: true,
      scaleXEnabled: true,
      scaleYEnabled: false,
      pinchZoomEnabled: false,
      minOffset: 0,
      highlightPerDragEnabled: true,
      highLightPerTapEnabled: false,
      doubleTapToZoomEnabled: false,
      autoScaleMinMaxEnabled: false,
      description: desc,
      drawBorders: false,
      borderColor: widget.chartTheme.borderColor,
    );

    controller.viewPortHandler.setMinimumScaleX(_count / 300);
    controller.viewPortHandler.setMaximumScaleX(_count / 20);
    controller.viewPortHandler.setDragOffsetX(80);
  }

  void _loadData() {
    var json = jsonDecode('[ { "C": "9145.66", "T": "1593251100" }, { "C": "9143.09", "T": "1593252000" }, { "C": "9153.72", "T": "1593252900" }, { "C": "9159.83", "T": "1593253800" }, { "C": "9142.64", "T": "1593254700" }, { "C": "9135.29", "T": "1593255600" }, { "C": "9141.80", "T": "1593256500" }, { "C": "9168.48", "T": "1593257400" }, { "C": "9159.34", "T": "1593258300" }, { "C": "9165.10", "T": "1593259200" }, { "C": "9150.90", "T": "1593260100" }, { "C": "9155.75", "T": "1593261000" }, { "C": "9164.09", "T": "1593261900" }, { "C": "9172.46", "T": "1593262800" }, { "C": "9159.75", "T": "1593263700" }, { "C": "9155.62", "T": "1593264600" }, { "C": "9157.64", "T": "1593265500" }, { "C": "9133.72", "T": "1593266400" }, { "C": "9151.23", "T": "1593267300" }, { "C": "9161.94", "T": "1593268200" }, { "C": "9147.84", "T": "1593269100" }, { "C": "9137.80", "T": "1593270000" }, { "C": "9140.20", "T": "1593270900" }, { "C": "9151.48", "T": "1593271800" }, { "C": "9131.83", "T": "1593272700" }, { "C": "9098.23", "T": "1593273600" }, { "C": "9105.74", "T": "1593274500" }, { "C": "9080.70", "T": "1593275400" }, { "C": "9100.99", "T": "1593276300" }, { "C": "9113.38", "T": "1593277200" }, { "C": "9103.31", "T": "1593278100" }, { "C": "9077.40", "T": "1593279000" }, { "C": "9081.01", "T": "1593279900" }, { "C": "9087.44", "T": "1593280800" }, { "C": "9082.63", "T": "1593281700" }, { "C": "9100.50", "T": "1593282600" }, { "C": "9089.08", "T": "1593283500" }, { "C": "9100.27", "T": "1593284400" }, { "C": "9086.26", "T": "1593285300" }, { "C": "9022.94", "T": "1593286200" }, { "C": "8939.03", "T": "1593287100" }, { "C": "8965.45", "T": "1593288000" }, { "C": "8966.95", "T": "1593288900" }, { "C": "8970.30", "T": "1593289800" }, { "C": "8953.14", "T": "1593290700" }, { "C": "8968.96", "T": "1593291600" }, { "C": "8971.65", "T": "1593292500" }, { "C": "8949.52", "T": "1593293400" }, { "C": "9058.84", "T": "1593294300" }, { "C": "9057.30", "T": "1593295200" }, { "C": "8992.67", "T": "1593296100" }, { "C": "8998.96", "T": "1593297000" }, { "C": "8972.99", "T": "1593297900" }, { "C": "8994.44", "T": "1593298800" }, { "C": "8984.01", "T": "1593299700" }, { "C": "9027.17", "T": "1593300600" }, { "C": "9011.96", "T": "1593301500" }, { "C": "8997.42", "T": "1593302400" }, { "C": "8987.62", "T": "1593303300" }, { "C": "8970.98", "T": "1593304200" }, { "C": "8981.22", "T": "1593305100" }, { "C": "8983.28", "T": "1593306000" }, { "C": "8967.41", "T": "1593306900" }, { "C": "8956.29", "T": "1593307800" }, { "C": "8973.79", "T": "1593308700" }, { "C": "8961.69", "T": "1593309600" }, { "C": "8966.47", "T": "1593310500" }, { "C": "8974.10", "T": "1593311400" }, { "C": "8979.79", "T": "1593312300" }, { "C": "8970.09", "T": "1593313200" }, { "C": "8971.95", "T": "1593314100" }, { "C": "8976.24", "T": "1593315000" }, { "C": "8975.84", "T": "1593315900" }, { "C": "8966.31", "T": "1593316800" }, { "C": "8963.65", "T": "1593317700" }, { "C": "8961.52", "T": "1593318600" }, { "C": "8968.84", "T": "1593319500" }, { "C": "8969.36", "T": "1593320400" }, { "C": "8973.85", "T": "1593321300" }, { "C": "8975.81", "T": "1593322200" }, { "C": "8963.16", "T": "1593323100" }, { "C": "8988.16", "T": "1593324000" }, { "C": "8990.65", "T": "1593324900" }, { "C": "9001.25", "T": "1593325800" }, { "C": "9016.84", "T": "1593326700" }, { "C": "9002.45", "T": "1593327600" }, { "C": "9002.08", "T": "1593328500" }, { "C": "9001.47", "T": "1593329400" }, { "C": "9023.92", "T": "1593330300" }, { "C": "9007.98", "T": "1593331200" }, { "C": "9009.40", "T": "1593332100" }, { "C": "9021.95", "T": "1593333000" }, { "C": "9053.46", "T": "1593333900" }, { "C": "9050.38", "T": "1593334800" }, { "C": "9050.68", "T": "1593335700" }, { "C": "9071.03", "T": "1593336600" }, { "C": "9075.04", "T": "1593337500" }, { "C": "9060.64", "T": "1593338400" }, { "C": "9064.19", "T": "1593339300" }, { "C": "9071.64", "T": "1593340200" }, { "C": "9051.96", "T": "1593341100" }, { "C": "9069.93", "T": "1593342000" }, { "C": "9072.15", "T": "1593342900" }, { "C": "9056.68", "T": "1593343800" }, { "C": "9050.51", "T": "1593344700" }, { "C": "9051.15", "T": "1593345600" }, { "C": "9030.19", "T": "1593346500" }, { "C": "9041.12", "T": "1593347400" }, { "C": "9050.42", "T": "1593348300" }, { "C": "9051.11", "T": "1593349200" }, { "C": "9055.33", "T": "1593350100" }, { "C": "9045.22", "T": "1593351000" }, { "C": "9052.95", "T": "1593351900" }, { "C": "9125.47", "T": "1593352800" }, { "C": "9132.07", "T": "1593353700" }, { "C": "9147.52", "T": "1593354600" }, { "C": "9154.75", "T": "1593355500" }, { "C": "9145.47", "T": "1593356400" }, { "C": "9136.61", "T": "1593357300" }, { "C": "9150.19", "T": "1593358200" }, { "C": "9159.21", "T": "1593359100" }, { "C": "9179.84", "T": "1593360000" }, { "C": "9179.96", "T": "1593360900" }, { "C": "9143.51", "T": "1593361800" }, { "C": "9147.46", "T": "1593362700" }, { "C": "9139.07", "T": "1593363600" }, { "C": "9139.21", "T": "1593364500" }, { "C": "9147.60", "T": "1593365400" }, { "C": "9156.11", "T": "1593366300" }, { "C": "9160.39", "T": "1593367200" }, { "C": "9163.80", "T": "1593368100" }, { "C": "9148.06", "T": "1593369000" }, { "C": "9152.46", "T": "1593369900" }, { "C": "9164.11", "T": "1593370800" }, { "C": "9165.45", "T": "1593371700" }, { "C": "9141.58", "T": "1593372600" }, { "C": "9111.85", "T": "1593373500" }, { "C": "9129.11", "T": "1593374400" }, { "C": "9136.08", "T": "1593375300" }, { "C": "9110.09", "T": "1593376200" }, { "C": "9114.05", "T": "1593377100" }, { "C": "9124.11", "T": "1593378000" }, { "C": "9097.06", "T": "1593378900" }, { "C": "9111.76", "T": "1593379800" }, { "C": "9128.24", "T": "1593380700" }, { "C": "9079.99", "T": "1593381600" }, { "C": "9096.07", "T": "1593382500" }, { "C": "9102.96", "T": "1593383400" }, { "C": "9104.08", "T": "1593384300" }, { "C": "9110.99", "T": "1593385200" }, { "C": "9098.21", "T": "1593386100" }, { "C": "9105.36", "T": "1593387000" }, { "C": "9118.40", "T": "1593387900" }, { "C": "9118.00", "T": "1593388800" }, { "C": "9100.92", "T": "1593389700" }, { "C": "9107.07", "T": "1593390600" }, { "C": "9123.58", "T": "1593391500" }, { "C": "9129.82", "T": "1593392400" }, { "C": "9123.19", "T": "1593393300" }, { "C": "9137.08", "T": "1593394200" }, { "C": "9143.59", "T": "1593395100" }, { "C": "9137.08", "T": "1593396000" }, { "C": "9137.32", "T": "1593396900" }, { "C": "9138.46", "T": "1593397800" }, { "C": "9128.26", "T": "1593398700" }, { "C": "9113.19", "T": "1593399600" }, { "C": "9107.53", "T": "1593400500" }, { "C": "9105.96", "T": "1593401400" }, { "C": "9098.97", "T": "1593402300" }, { "C": "9108.48", "T": "1593403200" }, { "C": "9110.04", "T": "1593404100" }, { "C": "9097.62", "T": "1593405000" }, { "C": "9115.20", "T": "1593405900" }, { "C": "9113.55", "T": "1593406800" }, { "C": "9121.42", "T": "1593407700" }, { "C": "9124.95", "T": "1593408600" }, { "C": "9113.62", "T": "1593409500" }, { "C": "9107.45", "T": "1593410400" }, { "C": "9110.81", "T": "1593411300" }, { "C": "9099.27", "T": "1593412200" } ]');
    var klines = ((json as List) ?? []).map((item) => Kline.fromJson(item)).toList();

    Future.delayed(Duration(seconds: 1)).then((value) => _setNewData(klines));
  }

  void _setNewData(List<Kline> klines) {
    CombinedData data = controller?.data;
    List<Entry> closePriceEntries = klines?.toClosePriceEntryList() ?? [];
    LineDataSet closePriceLineDataSet = data?.getDataSetByLabel(DATA_SET_LABEL_CLOSE, false);
    if (closePriceLineDataSet == null) {
      closePriceLineDataSet = createClosePriceLineDataSet(closePriceEntries);

      if (data == null) {
        data = CombinedData();
        controller.data = data;
      }
      LineData lineData = data.getLineData();
      if (lineData == null) {
        lineData = LineData();
        data.setData1(lineData);
      }
      lineData.addDataSet(closePriceLineDataSet);
    } else {
      closePriceLineDataSet.setValues(closePriceEntries);
    }

    data.notifyDataChanged();

    controller.state?.setStateIfNotDispose();
    //controller.moveViewToX(data.getEntryCount().toDouble());
    controller.moveViewToAnimated(data.getEntryCount().toDouble(), 0.0, AxisDependency.LEFT, 1);
  }

  LineDataSet createClosePriceLineDataSet(List<Entry> closePriceEntries) {
    LineDataSet set = LineDataSet(closePriceEntries, DATA_SET_LABEL_CLOSE)
      ..setColor1(Color(0xFF639AFF))
      ..setLineWidth(1)
      ..setDrawCircleHole(false)
      ..setDrawIcons(true)
      ..setHighlightEnabled(true)
      ..setHighLightColor(Color(0xFF639AFF))
      ..setValueTextSize(9)
      ..setDrawFilled(true)
      ..setFormLineWidth(1)
      ..setFormLineDashEffect(DashPathEffect(10, 5, 0))
      ..setFormSize(15)
      ..setDrawValues(false)
      ..setDrawCircles(false)
      ..setAxisDependency(AxisDependency.RIGHT);
    return set;
  }
}

class _TimeValueFormatter extends ValueFormatter {
  final _TimeShareChartState state;

  final DateFormat dateFormat = DateFormat('HH:mm');

  _TimeValueFormatter(this.state);

  @override
  String getFormattedValue1(double value) {
    LineDataSet closePriceLineDataSet = state.controller.data.getDataSetByLabel(DATA_SET_LABEL_CLOSE, false);
    int index = value.toInt();
    if (index < 0 || index >= closePriceLineDataSet.getEntryCount()) {
      return '';
    }
    var entry = closePriceLineDataSet.getEntryForIndex(index);
    return dateFormat.format(DateTime.fromMillisecondsSinceEpoch(entry.time * 1000));
  }
}