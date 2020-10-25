import 'package:dio/dio.dart';
import 'package:doc_test/data/models/shedule_models.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'doc_api.g.dart';

@singleton
@RestApi()
abstract class DocApi {
  @factoryMethod
  factory DocApi(
      Dio dio, {
        @required @Named('baseUrl') String baseUrl,
      }) = _DocApi;

  @GET('/{id}/schedule/')
  Future<Schedule> getSchedules(@Path() String id);

  @PATCH('/{id}/schedule/')
  Future<Schedule> patchSchedules(@Path() String id,@Body() Schedule schedule);
}

class NetworkError implements Exception {
  final RequestOptions request;
  final Response response;
  final DioErrorType type;

  NetworkError(DioError dioError)
      : request = dioError.request,
        response = dioError.response,
        type = dioError.type;
}

class CancelError implements Exception {
  final RequestOptions request;
  final DioErrorType type;

  CancelError(DioError dioError)
      : request = dioError.request,
        type = dioError.type;
}