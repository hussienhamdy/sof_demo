import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:sof_demo/core/exceptions.dart';
import 'package:sof_demo/core/network_info.dart';

class ApiService {
  static ApiService? _instance;

  Dio _dio = Dio();
  static const int timeDuration = 30000;

  static ApiService getInstance() {
    _instance ??= ApiService();
    return _instance!;
  }

  ApiService() {
    _dio = Dio();
    _initInterceptor();
  }

  _initInterceptor() {
    _dio.interceptors.clear();
    _dio.interceptors.add(
      QueuedInterceptorsWrapper(
        onRequest: (options, handler) {
          return handler.next(options); //continue
        },
        onResponse: (response, handler) {
          return handler.next(response); // continue
        },
        onError: (DioException error, handler) async {
          debugPrint('****** Dio Interceptor onError $error');
          debugPrint(
            '****** Dio Interceptor onError path ${error.requestOptions.path}',
          );
          handler.next(error);
        },
      ),
    );
  }

  Future<dynamic>? tryCatchAsyncWrapper(
    String functionName,
    Function fn, {
    Function? onErrorCallback,
  }) async {
    try {
      if (await NetworkInfo().isConnected()) {
        dynamic value = await fn();
        return value;
      } else {
        throw NetworkException();
      }
    } on SocketException catch (_) {
      throw NetworkException();
    } on NetworkException {
      rethrow;
    } on DioException catch (error) {
      debugPrint('logMessage  $error');
      if (error.type == DioExceptionType.receiveTimeout ||
          error.type == DioExceptionType.sendTimeout ||
          error.type == DioExceptionType.connectionTimeout) {
        throw NetworkException();
      }
      if (error.message?.contains('connection abort') == true ||
          error.message?.contains('Failed host lookup') == true) {
        throw NetworkException();
      }
      debugPrint('error.type ${error.type}');
      debugPrint('eeeeeeee $error');
      debugPrint('$functionName ERROR !!!! ${error.response?.statusCode}');
      debugPrint('$functionName ERROR !!!! ${error.response?.data}');
      try {
        var responseJson = json.decode(utf8.decode(error.response?.data));
        if (responseJson['error_message'] != null) {
          debugPrint('responseJson[message] != null $responseJson');
          debugPrint(
            'responseJson[message] != null ${responseJson['message']}',
          );
          if (responseJson['error_message'] is List) {
            throw ExceptionWithMessage(
              message: responseJson['error_message'][0],
            );
          } else {
            throw ExceptionWithMessage(message: responseJson['error_message']);
          }
        } else {
          return _handleErrorStatus(error.response?.statusCode);
        }
      } catch (e) {
        debugPrint('logMessage ##### $e');
        rethrow;
      }
    } catch (error, stackTrace) {
      debugPrint('$functionName ERROR !!!! $error, $stackTrace');
      throw Exception();
    }
  }

  Future<dynamic> get({Uri? uri, bool parseJson = true}) async {
    return await tryCatchAsyncWrapper('get', () async {
      _setDioHeaders();
      final response = await _dio.getUri(uri!);
      var responseJson = _returnResponse(
        response: response,
        parseJson: parseJson,
      );
      debugPrint("$responseJson");
      return responseJson;
    });
  }

  Future<dynamic> post({
    required Uri? uri,
    required dynamic body,
    bool shouldParseBody = true,
    bool parseJson = true,
  }) async {
    return await tryCatchAsyncWrapper('post', () async {
      debugPrint('post body is $body');

      dynamic data;
      if (shouldParseBody) {
        data = json.encode(body);
      } else {
        data = body;
      }
      debugPrint('post data is $data');
      _setDioHeaders();
      Response response = await _dio.postUri(uri!, data: data);
      debugPrint('post response is $response');
      var responseJson = _returnResponse(
        response: response,
        parseJson: parseJson,
      );
      debugPrint('post responseJson is $responseJson');
      return responseJson;
    });
  }

  Future<dynamic> put({Uri? uri, dynamic body, bool parseJson = true}) async {
    return await tryCatchAsyncWrapper('put', () async {
      _setDioHeaders();
      final response = await _dio.putUri(uri!, data: body);
      var responseJson = _returnResponse(
        response: response,
        parseJson: parseJson,
      );
      return responseJson;
    });
  }

  Future<dynamic> patch({Uri? uri, String? body, bool parseJson = true}) async {
    return await tryCatchAsyncWrapper('patch', () async {
      _setDioHeaders();
      final response = await _dio.patchUri(uri!, data: body);
      var responseJson = _returnResponse(
        response: response,
        parseJson: parseJson,
      );
      return responseJson;
    });
  }

  Future<dynamic> delete({
    Uri? uri,
    bool parseJson = true,
    String body = "",
  }) async {
    return await tryCatchAsyncWrapper('delete', () async {
      _setDioHeaders();
      final response = await _dio.deleteUri(uri!, data: body);
      var responseJson = _returnResponse(
        response: response,
        parseJson: parseJson,
      );
      return responseJson;
    });
  }

  bool _isSuccess(statusCode) {
    return statusCode == 200 ||
        statusCode == 201 ||
        statusCode == 204 ||
        statusCode == 208;
  }

  _handleErrorStatus(statusCode) {
    debugPrint('statusCode $statusCode');
    throw Exception();
  }

  dynamic _returnResponse({Response? response, bool parseJson = true}) {
    if (_isSuccess(response!.statusCode)) {
      if (parseJson) {
        var responseJson = json.decode(utf8.decode(response.data));
        return responseJson;
      } else {
        debugPrint("${response.headers}");
        return {'headers': response.headers, 'data': response.data};
      }
    }
    debugPrint(
      'Error response.statusCode ${response.statusCode} ${response.headers}',
    );
    debugPrint('post ERROR !!!! ${response.data}');
    try {
      var responseJson = json.decode(utf8.decode(response.data));
      if (responseJson['error_msg'] != null) {
        throw ExceptionWithMessage(message: responseJson['error_msg']);
      } else {
        _handleErrorStatus(response.statusCode);
      }
    } catch (e) {
      rethrow;
    }
  }

  _setDioHeaders() {
    _dio.options.headers['content-type'] = 'application/json';
    _dio.options.responseType = ResponseType.bytes;
    _dio.options.connectTimeout = Duration(seconds: timeDuration);
    _dio.options.receiveTimeout = Duration(seconds: timeDuration);
    _dio.options.sendTimeout = Duration(seconds: timeDuration);
  }
}
