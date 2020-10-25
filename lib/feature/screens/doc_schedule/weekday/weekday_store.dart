import 'package:doc_test/data/models/shedule_models.dart';
import 'package:doc_test/feature/util/convert_util.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'weekday_store.g.dart';

@injectable
class WeekDayStore = WeekDayStoreBase with _$WeekDayStore;

abstract class WeekDayStoreBase with Store {

  @observable
  Map<int, AInterval> intervals;

  @observable
  bool isCorrect = false;

  @observable
  bool isSwitchedOn = false;

  @action
  fetchIntervals(int schedule) {
    intervals = convertToIntervalOfTime(convertIntToBinary(schedule));
    isSwitchedOn = intervals.isNotEmpty;
  }

  @action
  changeIntervals(int index, {AInterval interval}) {
    if (intervals.containsKey(index) && interval != null) {
      intervals = Map.from(intervals)
        ..update(
          index,
          (value) => interval,
        );
    }
  }


  @action
  addNewInterval() {
    intervals = Map.from(intervals)
      ..addAll({
        intervals.length: AInterval(
          start: Duration(hours: 8),
          end: Duration(hours: 20),
        )
      });
  }

  @action
  removeInterval(int index) {
    intervals = (intervals.values.toList()..removeAt(index)).asMap();
  }
}

