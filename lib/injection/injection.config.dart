// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../feature/components/slider/aslider_store.dart';
import '../data/repository/doc_api.dart';
import '../feature/screens/doc_schedule/doc_schedule_store.dart';
import 'injection.dart';
import '../feature/screens/doc_schedule/weekday/weekday_store.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final gh = GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  gh.factory<ASliderStore>(() => ASliderStore());
  gh.factory<String>(() => registerModule.baseUrl, instanceName: 'baseUrl');
  gh.factory<String>(() => registerModule.userId, instanceName: 'user_id');
  gh.factory<String>(() => registerModule.token, instanceName: 'token');
  gh.factory<WeekDayStore>(() => WeekDayStore());
  gh.factory<DocScheduleStore>(() => DocScheduleStore(get<DocApi>()));

  // Eager singletons must be registered in the right order
  gh.singleton<Dio>(registerModule.provideDio());
  gh.singleton<DocApi>(
      DocApi(get<Dio>(), baseUrl: get<String>(instanceName: 'baseUrl')));
  return get;
}

class _$RegisterModule extends RegisterModule {}
