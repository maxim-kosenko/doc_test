import 'package:doc_test/feature/screens/doc_schedule/weekday/weekday_store.dart';
import 'package:doc_test/feature/util/convert_util.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'aslider_store.g.dart';

@injectable
class ASliderStore = ASliderStoreBase with _$ASliderStore;

abstract class ASliderStoreBase with Store {
  @observable
  WeekDayStore weekdayStore;

  @observable
  int index;

  @observable
  AInterval interval;

  @computed
  bool get isCorrect =>
      weekdayStore.intervals.isEmpty ||
      checkIsCorrectInterval(
        Map.from(weekdayStore.intervals)..remove(index),
        interval,
      );

  @action
  changeInterval(int indexStart, int indexEnd) {
    interval = AInterval(
      start: Duration(minutes: indexStart * 30),
      end: Duration(minutes: indexEnd * 30),
    );
  }
}
