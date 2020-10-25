import 'package:dio/dio.dart';
import 'package:doc_test/data/models/shedule_models.dart';
import 'package:doc_test/data/repository/doc_api.dart';
import 'package:doc_test/feature/util/convert_util.dart';
import 'package:doc_test/injection/injection.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'doc_schedule_store.g.dart';

@injectable
class DocScheduleStore = DocScheduleStoreBase with _$DocScheduleStore;

abstract class DocScheduleStoreBase with Store {
  final DocApi api;

  DocScheduleStoreBase(this.api);

  @observable
  Schedule schedule;

  @observable
  int monday;

  @observable
  int tuesday;

  @observable
  int wednesday;

  @observable
  int thursday;

  @observable
  int friday;

  @observable
  int saturday;

  @observable
  int sunday;

  @observable
  dynamic error;

  @observable
  bool isLoadingFetch = false;

  @action
  fetchScheduleAtWeek() async {
    error = null;
    isLoadingFetch = true;
    try {
      schedule =
          await api.getSchedules(getIt.get<String>(instanceName: 'user_id'));
      monday = schedule.monday;
      tuesday = schedule.tuesday;
      wednesday = schedule.wednesday;
      thursday = schedule.thursday;
      friday = schedule.friday;
      saturday = schedule.saturday;
      sunday = schedule.sunday;
    } on DioError catch (e) {
      error = e.error;
    }
    isLoadingFetch = false;
  }

  @observable
  bool isLoadingPatch = false;

  @observable
  bool isUpdated = false;

  updateSchedule() async {
    error = null;
    isLoadingPatch = true;
    isUpdated = false;
    try {
      schedule = Schedule(
        monday: monday,
        tuesday: tuesday,
        wednesday: wednesday,
        thursday: thursday,
        friday: friday,
        saturday: saturday,
        sunday: sunday,
      );
      await api.patchSchedules(
        getIt.get<String>(instanceName: 'user_id'),
        schedule,
      );
      isUpdated = true;
    } on DioError catch (e) {
      error = e.error;
    }
    isLoadingPatch = false;
  }
}
