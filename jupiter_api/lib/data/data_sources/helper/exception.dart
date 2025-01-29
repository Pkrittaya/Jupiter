import 'package:dio/dio.dart';

class ServerException implements Exception {}

class UnAuthorizedException implements DioException {
  @override
  DioException copyWith(
      {RequestOptions? requestOptions,
      Response? response,
      DioExceptionType? type,
      Object? error,
      StackTrace? stackTrace,
      String? message}) {
    return DioException(
      requestOptions: requestOptions ?? this.requestOptions,
      response: response ?? this.response,
      type: type ?? this.type,
      error: error ?? this.error,
      stackTrace: stackTrace ?? this.stackTrace,
      message: message ?? this.message,
    );
  }

  @override
  Object? get error => error;

  @override
  String? get message => message;

  @override
  RequestOptions get requestOptions => requestOptions;

  @override
  Response? get response => response;

  @override
  StackTrace get stackTrace => StackTrace.current;

  @override
  DioExceptionType get type => type;
}
