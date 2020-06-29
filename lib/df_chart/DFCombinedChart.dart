import 'package:flutter/gestures.dart';
import 'package:mp_chart/mp/chart/combined_chart.dart';
import 'package:mp_chart/mp/controller/combined_chart_controller.dart';
import 'package:mp_chart/mp/core/utils/highlight_utils.dart';
import 'package:mp_chart/mp/painter/combined_chart_painter.dart';
import 'package:optimized_gesture_detector/details.dart';
import 'package:flutter/rendering.dart';
import 'package:mp_chart/mp/core/axis/y_axis.dart';
import 'package:mp_chart/mp/core/common_interfaces.dart';
import 'package:mp_chart/mp/core/description.dart';
import 'package:mp_chart/mp/core/functions.dart';
import 'package:mp_chart/mp/core/marker/i_marker.dart';
import 'package:mp_chart/mp/core/render/x_axis_renderer.dart';
import 'package:mp_chart/mp/core/render/y_axis_renderer.dart';
import 'package:mp_chart/mp/core/touch_listener.dart';
import 'package:mp_chart/mp/core/chart_trans_listener.dart';
import 'package:mp_chart/mp/core/transformer/transformer.dart';

class DFCombinedChart extends CombinedChart {
  DFCombinedChart(DFCombinedChartController controller) : super(controller);
}

class DFCombinedChartController extends CombinedChartController {

  DFCombinedChartController(
      {bool drawValueAboveBar = false,
        bool highlightFullBarEnabled = true,
        bool drawBarShadow = false,
        bool fitBars = true,
        List<DrawOrder> drawOrder,
        int maxVisibleCount = 100,
        bool autoScaleMinMaxEnabled = true,
        bool doubleTapToZoomEnabled = true,
        bool highlightPerDragEnabled = true,
        bool dragXEnabled = true,
        bool dragYEnabled = true,
        bool scaleXEnabled = true,
        bool scaleYEnabled = true,
        bool drawGridBackground = false,
        bool drawBorders = false,
        bool clipValuesToContent = false,
        double minOffset = 30.0,
        OnDrawListener drawListener,
        YAxis axisLeft,
        YAxis axisRight,
        YAxisRenderer axisRendererLeft,
        YAxisRenderer axisRendererRight,
        Transformer leftAxisTransformer,
        Transformer rightAxisTransformer,
        XAxisRenderer xAxisRenderer,
        bool customViewPortEnabled = false,
        Matrix4 zoomMatrixBuffer,
        bool pinchZoomEnabled = true,
        bool keepPositionOnRotation = false,
        Paint gridBackgroundPaint,
        Paint borderPaint,
        Color backgroundColor,
        Color gridBackColor,
        Color borderColor,
        double borderStrokeWidth = 1.0,
        AxisLeftSettingFunction axisLeftSettingFunction,
        AxisRightSettingFunction axisRightSettingFunction,
        OnTouchEventListener touchEventListener,
        IMarker marker,
        Description description,
        String noDataText = "No chart data available.",
        XAxisSettingFunction xAxisSettingFunction,
        LegendSettingFunction legendSettingFunction,
        DataRendererSettingFunction rendererSettingFunction,
        OnChartValueSelectedListener selectionListener,
        double maxHighlightDistance = 100.0,
        bool highLightPerTapEnabled = true,
        double extraTopOffset = 0.0,
        double extraRightOffset = 0.0,
        double extraBottomOffset = 0.0,
        double extraLeftOffset = 0.0,
        bool drawMarkers = true,
        bool resolveGestureHorizontalConflict = false,
        bool resolveGestureVerticalConflict = false,
        double descTextSize = 12,
        double infoTextSize = 12,
        Color descTextColor,
        Color infoTextColor,
        Color infoBgColor,
        ChartTransListener chartTransListener})
      : super(
      marker: marker,
      description: description,
      noDataText: noDataText,
      xAxisSettingFunction: xAxisSettingFunction,
      legendSettingFunction: legendSettingFunction,
      rendererSettingFunction: rendererSettingFunction,
      selectionListener: selectionListener,
      maxHighlightDistance: maxHighlightDistance,
      highLightPerTapEnabled: highLightPerTapEnabled,
      extraTopOffset: extraTopOffset,
      extraRightOffset: extraRightOffset,
      extraBottomOffset: extraBottomOffset,
      extraLeftOffset: extraLeftOffset,
      drawMarkers: drawMarkers,
      resolveGestureHorizontalConflict: resolveGestureHorizontalConflict,
      resolveGestureVerticalConflict: resolveGestureVerticalConflict,
      descTextSize: descTextSize,
      infoTextSize: infoTextSize,
      descTextColor: descTextColor,
      infoTextColor: infoTextColor,
      infoBgColor: infoBgColor,
      maxVisibleCount: maxVisibleCount,
      autoScaleMinMaxEnabled: autoScaleMinMaxEnabled,
      doubleTapToZoomEnabled: doubleTapToZoomEnabled,
      highlightPerDragEnabled: highlightPerDragEnabled,
      dragXEnabled: dragXEnabled,
      dragYEnabled: dragYEnabled,
      scaleXEnabled: scaleXEnabled,
      scaleYEnabled: scaleYEnabled,
      drawGridBackground: drawGridBackground,
      drawBorders: drawBorders,
      clipValuesToContent: clipValuesToContent,
      minOffset: minOffset,
      drawListener: drawListener,
      axisLeft: axisLeft,
      axisRight: axisRight,
      axisRendererLeft: axisRendererLeft,
      axisRendererRight: axisRendererRight,
      leftAxisTransformer: leftAxisTransformer,
      rightAxisTransformer: rightAxisTransformer,
      xAxisRenderer: xAxisRenderer,
      customViewPortEnabled: customViewPortEnabled,
      zoomMatrixBuffer: zoomMatrixBuffer,
      pinchZoomEnabled: pinchZoomEnabled,
      keepPositionOnRotation: keepPositionOnRotation,
      gridBackgroundPaint: gridBackgroundPaint,
      borderPaint: borderPaint,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      gridBackColor: gridBackColor,
      borderStrokeWidth: borderStrokeWidth,
      axisLeftSettingFunction: axisLeftSettingFunction,
      axisRightSettingFunction: axisRightSettingFunction,
      touchEventListener: touchEventListener,
      chartTransListener: chartTransListener);

  @override
  CombinedChartState createRealState() {
    return DFCombinedChartState();
  }
}

class DFCombinedChartState extends CombinedChartState {
  void onMoveUpdate(OpsMoveUpdateDetails details) {
    print('onMoveUpdate');
    var highlightPerDragEnabled = widget.controller.painter.highlightPerDragEnabled;
    widget.controller.painter.setHighlightFullBarEnabled(false);
    super.onMoveUpdate(details);
    widget.controller.painter.setHighlightFullBarEnabled(highlightPerDragEnabled);
  }

  @override
  void onMoveEnd(OpsMoveEndDetails details) {
    print('onMoveEnd');

    lastHighlighted = null;
    widget.controller.painter.highlightValue6(null, true);
    super.onMoveEnd(details);
  }

  @override
  void onDragStart(LongPressStartDetails details) {
    print('onDragStart');
    if (widget.controller.painter.highlightPerDragEnabled) {
      final highlighted = widget.controller.painter.getHighlightByTouchPoint(
          details.localPosition.dx, details.globalPosition.dy);
      if (highlighted?.equalTo(lastHighlighted) == false) {
        lastHighlighted = HighlightUtils.performHighlight(
            widget.controller.painter, highlighted, lastHighlighted);
        setStateIfNotDispose();
      }
    }
    super.onDragStart(details);
  }

  @override
  void onTapDown(TapDownDetails details) {
    print('onTapDown');

    super.onTapDown(details);
  }

  @override
  void onDragUpdate(LongPressMoveUpdateDetails details) {
    print('onDragUpdate');

    if (widget.controller.painter.highlightPerDragEnabled) {
      final highlighted = widget.controller.painter.getHighlightByTouchPoint(
          details.localPosition.dx, details.localPosition.dy);
      if (highlighted?.equalTo(lastHighlighted) == false) {
        lastHighlighted = HighlightUtils.performHighlight(
            widget.controller.painter, highlighted, lastHighlighted);
        setStateIfNotDispose();
      }
    }
    super.onDragUpdate(details);
  }

  @override
  void onScaleEnd(OpsScaleEndDetails details) {
    print('onScaleEnd');
    super.onScaleEnd(details);
  }

  @override
  void onDragEnd(LongPressEndDetails details) {
    print('onDragEnd');
    if (lastHighlighted != null) {
      lastHighlighted = null;
      widget.controller.painter.highlightValue6(null, true);
      setStateIfNotDispose();
    }
    super.onDragEnd(details);
  }
}