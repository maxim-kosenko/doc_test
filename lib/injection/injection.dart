import 'dart:io';

import 'package:dio/dio.dart';
import 'package:doc_test/data/models/error_models.dart';
import 'package:doc_test/data/repository/doc_api.dart';
import 'package:doc_test/injection/injection.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../main.dart';

final GetIt getIt = GetIt.instance;

@injectableInit
Future<void> configureInjection(String env) async {
  return $initGetIt(getIt, environment: env);
}

@module
abstract class RegisterModule {
  @Named('baseUrl')
  String get baseUrl => 'https://dev.hellodoc.app/api/v1/users/';

  @Named('user_id')
  String get userId => '456';

  @Named('token')
  String get token => '743d8dc716179ab4c155b6d30b6121696fc4f24d';

  @singleton
  Dio provideDio() {
    final dio = Dio(
      BaseOptions(
        connectTimeout: 5000,
        receiveTimeout: 5000,
        headers: <String, dynamic>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${getIt.get<String>(instanceName: 'token')}',
        },
      ),
    );
    dio.interceptors
      ..add(LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: dioLogger.d,
      ))
      ..add(InterceptorsWrapper(onError: (error) {
        return _handleDioError(error);
      }));
    return dio;
  }
}

dynamic _handleDioError(
  dynamic error,
) {
  if (error is DioError) {
    switch (error.type) {
      case DioErrorType.CONNECT_TIMEOUT:
      case DioErrorType.SEND_TIMEOUT:
      case DioErrorType.RECEIVE_TIMEOUT:
        return NetworkError(error);
        break;
      case DioErrorType.CANCEL:
        return CancelError(error);
        break;
      case DioErrorType.DEFAULT:
        if (error.error is SocketException) {
          return NetworkError(error);
        } else {
          return error;
        }
        break;
      case DioErrorType.RESPONSE:
        try {
          final apiError = MessageError.fromJson(error.response.data);
          return apiError;
        } catch (serializeError) {
          logger.e(serializeError);
          return error;
        }
        break;
      default:
        return error;
        break;
    }
  } else {
    return error;
  }
}
