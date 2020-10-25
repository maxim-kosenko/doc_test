import 'package:doc_test/feature/screens/doc_schedule/weekday/weekday_store.dart';
import 'package:doc_test/feature/theme/app_theme.dart';
import 'package:doc_test/feature/util/convert_util.dart';
import 'package:doc_test/injection/injection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'aslider_store.dart';


double min = 0.0;
double max = 48.0;

class ASlider extends StatefulWidget {
  final Duration startInterval;
  final Duration endInterval;
  final int index;
  final ValueChanged<AInterval> onChanged;

  const ASlider({
    Key key,
    this.startInterval,
    this.endInterval,
    this.index,
    this.onChanged,
  }) : super(key: key);

  @override
  _ASliderState createState() => _ASliderState();
}

class _ASliderState extends State<ASlider> {
  ASliderStore _store = getIt();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WeekDayStore weekDayStore = Provider.of(context);
    _store.weekdayStore = weekDayStore;
    if (widget.startInterval != null && widget.endInterval != null) {
      _store.interval = AInterval(
        start: widget.startInterval,
        end: widget.endInterval,
      );
    }
    _store.index = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Material(
        color: Thm.of(context).white,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                timeInBox(_store.interval.start),
                timeInBox(_store.interval.end),
              ],
            ),
            SizedBox(height: 15),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                  inactiveTrackColor: Thm.of(context).grayLight,
                  activeTrackColor: _store.isCorrect
                      ? Thm.of(context).primary
                      : Thm.of(context).error,
                  rangeThumbShape: _CustomRangeThumbShape(),
                  trackHeight: 2.0),
              child: RangeSlider(
                values: RangeValues(
                  _store.interval.start.inMinutes / 30,
                  _store.interval.end.inMinutes / 30,
                ),
                onChanged: (value) {
                  _store.changeInterval(
                    value.start.toInt(),
                    value.end.toInt(),
                  );
                  widget.onChanged(_store.interval);
                },
                min: min,
                max: max,
              ),
            )
          ],
        ),
      );
    });
  }

  Widget timeInBox(Duration time) => Container(
        width: 141.0,
        height: 55.0,
        decoration: BoxDecoration(
          border: Border.all(
            color: _store.isCorrect
                ? Thm.of(context).secondary
                : Thm.of(context).error,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: Text(
            convertDurationToText(time),
            style: Thm.of(context).ubantu17BlackDarkW500,
          ),
        ),
      );
}

class _CustomRangeThumbShape extends RangeSliderThumbShape {
  _CustomRangeThumbShape({
    this.radius = 14.0,
    this.circleColor = const Color(0xFFFFFFFF),
  });

  final double radius;
  final Color circleColor;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) =>
      Size(radius, radius);

  @override
  void paint(PaintingContext context, Offset center,
      {Animation<double> activationAnimation,
      Animation<double> enableAnimation,
      bool isDiscrete,
      bool isEnabled,
      bool isOnTop,
      TextDirection textDirection,
      SliderThemeData sliderTheme,
      Thumb thumb,
      bool isPressed}) {
    final Canvas canvas = context.canvas;
    canvas.drawShadow(
      Path()
        ..addArc(
          Rect.fromCircle(
            center: center,
            radius: radius,
          ),
          math.pi,
          -math.pi,
        ),
      Color(0xff000000),
      3.0,
      false,
    );

    canvas.drawCircle(
      center,
      radius,
      Paint()..color = circleColor,
    );

    canvas.drawOval(
      Rect.fromCircle(
        center: center,
        radius: radius,
      ),
      Paint()
        ..strokeWidth = 0.5
        ..style = PaintingStyle.stroke
        ..color = Color.fromRGBO(0, 0, 0, 0.04),
    );
  }
}
