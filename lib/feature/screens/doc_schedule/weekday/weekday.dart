import 'package:doc_test/feature/components/slider/aslider.dart';
import 'package:doc_test/feature/components/tappable.dart';
import 'package:doc_test/feature/screens/doc_schedule/weekday/weekday_store.dart';
import 'package:doc_test/feature/theme/app_theme.dart';
import 'package:doc_test/feature/util/convert_util.dart';
import 'package:doc_test/generated/l10n.dart';
import 'package:doc_test/injection/injection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class Weekday extends StatefulWidget {
  final String weekdayName;
  final int schedule;
  final ValueChanged<int> onUpdate;

  const Weekday({
    Key key,
    this.schedule,
    this.weekdayName,
    this.onUpdate,
  }) : super(key: key);

  @override
  _WeekdayState createState() => _WeekdayState();
}

class _WeekdayState extends State<Weekday> {
  final WeekDayStore _store = getIt();

  @override
  void initState() {
    super.initState();
    _store.fetchIntervals(widget.schedule);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
          ),
          child: Column(
            children: [
              Column(
                children: [
                  _title(),
                  _bodyIntervals(),
                ],
              ),
              _addNewIntervalButton(),
            ],
          ),
        ),
        _bottomDivider(),
      ],
    );
  }

  Widget _title() => Row(
        children: [
          Expanded(
            child: Text(
              widget.weekdayName,
              style: Thm.of(context).ubantu17BlackDarkNormal,
            ),
          ),
          Observer(builder: (context) {
            return Material(
              color: Thm.of(context).white,
              child: Transform.scale(
                scale: 1.4,
                child: Switch(
                    activeColor: Thm.of(context).primary,
                    value: _store.isSwitchedOn,
                    onChanged: (value) {
                      _store.isSwitchedOn = value;
                      if (value) {
                        _store.addNewInterval();
                      } else {
                        _store.intervals = {};
                      }
                      updateIntervalsToInt();
                    }),
              ),
            );
          }),
        ],
      );

  Widget _bodyIntervals() => Observer(
      builder: (_) => Column(
            children: [
              Column(
                children: _store.intervals.entries
                    .map(
                      (e) => Provider<WeekDayStore>(
                        create: (_) => _store,
                        child: ASlider(
                          startInterval: e.value.start,
                          endInterval: e.value.end,
                          index: e.key,
                          onChanged: (interval) {
                            _store.changeIntervals(
                              e.key,
                              interval: interval,
                            );
                            updateIntervalsToInt();
                          },
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ));

  Widget _addNewIntervalButton() => Observer(
        builder: (_) => Column(
          children: [
            if (_store.isSwitchedOn) ...[
              Row(
                children: [
                  Tappable(
                    onTap: (){
                      _store.addNewInterval();
                      updateIntervalsToInt();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: Thm.of(context).secondary,
                          width: 1.0,
                        ),
                      ),
                      height: 42.0,
                      width: 42.0,
                      child: Center(
                        child: Icon(
                          Icons.add,
                          color: Thm.of(context).primary,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 15.0),
                  Expanded(
                      child: Text(
                    S.of(context).addInterval,
                    style: Thm.of(context).ubantu17PrimaryW500,
                  ))
                ],
              )
            ],
          ],
        ),
      );

  Widget _bottomDivider() => Observer(
      builder: (_) => Column(
            children: [
              if (_store.isSwitchedOn) ...[
                SizedBox(height: 29.0),
                Container(
                  color: Thm.of(context).background,
                  height: 10.0,
                ),
              ]
            ],
          ));

  void updateIntervalsToInt() {
    widget.onUpdate(
      convertBinaryToInt(
        convertIntervalsToBinary(_store.intervals),
      ),
    );
  }
}
