import 'package:freezed_annotation/freezed_annotation.dart';

part 'shedule_models.freezed.dart';
part 'shedule_models.g.dart';


@freezed
abstract class Schedule
    with _$Schedule {
  factory Schedule({
    @JsonKey(name: 'monday') int monday,
    @JsonKey(name: 'tuesday') int tuesday,
    @JsonKey(name: 'wednesday') int wednesday,
    @JsonKey(name: 'thursday') int thursday,
    @JsonKey(name: 'friday') int friday,
    @JsonKey(name: 'saturday') int saturday,
    @JsonKey(name: 'sunday') int sunday,
  }) = _RSchedule;

  factory Schedule.fromJson(Map<String, dynamic> json) =>
      _$ScheduleFromJson(json);
}