import 'package:dio/dio.dart';

abstract class Result<T> {
  final T? data;
  final DioException? exception;

  const Result({this.data, this.exception});
}

class Ok<T> extends Result<T> {
  const Ok(T data) : super(data: data);
}

class Err<T> extends Result<T> {
  const Err(DioException exception) : super(exception: exception);
}
