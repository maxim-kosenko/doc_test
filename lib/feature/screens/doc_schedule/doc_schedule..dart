import 'package:doc_test/data/models/error_models.dart';
import 'package:doc_test/feature/components/a_toast.dart';
import 'package:doc_test/feature/components/tappable.dart';
import 'package:doc_test/feature/screens/doc_schedule/weekday/weekday.dart';
import 'package:doc_test/feature/theme/app_theme.dart';
import 'package:doc_test/generated/l10n.dart';
import 'package:doc_test/injection/injection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

import 'doc_schedule_store.dart';

class DocScheduleScreen extends StatefulWidget {
  @override
  _DocScheduleScreenState createState() => _DocScheduleScreenState();
}

class _DocScheduleScreenState extends State<DocScheduleScreen> {
  DocScheduleStore _store = getIt();

  @override
  void initState() {
    super.initState();
    _store.fetchScheduleAtWeek();

    reaction((_) => _store.error, (error) {
      if (error is MessageError) {
        showToast(
            context,
            AToast(
              title: error.message,
            ));
      } else {
        showToast(
            context,
            AToast(
              title: S.of(context).netError,
            ));
      }
    });

    reaction((_) => _store.isUpdated, (isUpdated) {
      if (isUpdated) {
        showToast(
            context,
            AToast(
              title: S.of(context).scheduleUpdated,
            ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Observer(builder: (context) {
        if (_store.isLoadingFetch) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        }
        return CustomScrollView(
          cacheExtent: 10,
          slivers: [
            _header(),
            _weekSchedule(),
            _button(),
          ],
        );
      }),
    );
  }

  Widget _header() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20.0,
          right: 60.0,
          top: 24.0,
          bottom: 16.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              S.of(context).workSchedule,
              style: Thm.of(context).ubantu20BlackLightNormal,
            ),
            SizedBox(height: 31.0),
            Text(
              S.of(context).specifiedTime,
              style: Thm.of(context).ubantu13GrayWithOpacityW500,
            ),
          ],
        ),
      ),
    );
  }

  Widget _weekSchedule() {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          if (_store.schedule != null) ...[
            Weekday(
              schedule: _store.monday,
              weekdayName: S.of(context).monday,
              onUpdate: (value) {
                _store.monday = value;
              },
            ),
            Weekday(
              schedule: _store.tuesday,
              weekdayName: S.of(context).tuesday,
              onUpdate: (value) {
                _store.tuesday = value;
              },
            ),
            Weekday(
              schedule: _store.wednesday,
              weekdayName: S.of(context).wednesday,
              onUpdate: (value) {
                _store.wednesday = value;
              },
            ),
            Weekday(
              schedule: _store.thursday,
              weekdayName: S.of(context).thursday,
              onUpdate: (value) {
                _store.thursday = value;
              },
            ),
            Weekday(
              schedule: _store.friday,
              weekdayName: S.of(context).friday,
              onUpdate: (value) {
                _store.friday = value;
              },
            ),
            Weekday(
              schedule: _store.saturday,
              weekdayName: S.of(context).saturday,
              onUpdate: (value) {
                _store.saturday = value;
              },
            ),
            Weekday(
              schedule: _store.sunday,
              weekdayName: S.of(context).sunday,
              onUpdate: (value) {
                _store.sunday = value;
              },
            ),
          ]
        ],
      ),
    );
  }

  Widget _button() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 46.0),
        child: Tappable(
          onTap: () {
            _store.updateSchedule();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Thm.of(context).primary,
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 17.0,
                  horizontal: 55.0,
                ),
                child: Center(
                  child: Observer(builder: (context) {
                    if (_store.isLoadingPatch) {
                      return CupertinoActivityIndicator();
                    }
                    return Text(
                      S.of(context).done,
                      style: Thm.of(context).ubantu14WhiteNormal,
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
