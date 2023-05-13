import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioSettings {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://randomuser.me/',
      connectTimeout: const Duration(milliseconds: 15000),
    ),
  );
  void setup() {
    final interceptors = dio.interceptors;

    interceptors.clear();

    final logInterceptor = LogInterceptor(
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
    );

    final headerInterceptors = QueuedInterceptorsWrapper(
      onRequest: (options, handler) {
        print('ON REQUEST');
        return handler.next(options);
      },
      onError: (DioError error, handler) {
        print('ON ERROR');
        handler.next(error);
      },
      onResponse: (response, handler) {
        print('ON RESPONSE');
        return handler.next(response);
      },
    );

    interceptors.addAll([
      if (kDebugMode) logInterceptor,
      headerInterceptors,
    ]);
  }
}
