import 'package:freezed_annotation/freezed_annotation.dart';

part 'error_models.freezed.dart';
part 'error_models.g.dart';

@freezed
abstract class MessageError with _$MessageError, Exception {
  factory MessageError({
    @JsonKey(name: 'message') String message,
  }) = _MessageError;

  factory MessageError.fromJson(Map<String, dynamic> json) =>
      _$MessageErrorFromJson(json);
}
