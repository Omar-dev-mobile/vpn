import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../constants.dart';

class ApiResponse<T> {
  late T load;
  late bool ok;
  late int statusCode;
  String? errorMessage;

  ApiResponse(this.statusCode, this.load, [bool? isOk]) {
    this.ok = isOk ?? statusCode == 200;
  }

  ApiResponse.fromBC(APIResponse<T> bcresp) {
    if (bcresp.load != null) {
      load = bcresp.load as T;
    } else {
      errorMessage = bcresp.error?.message;
    }
    statusCode = bcresp.statusCode!;
    ok = bcresp.ok ?? statusCode == 200;
  }
}

class RequestResult {
  dynamic json;
  int? statusCode;

  RequestResult(this.json, this.statusCode);
}

abstract class ApiBase {
  late String endpoint;

  final Dio _dio = Dio();

  Future<RequestResult> request({
    required String method,
    required String path,
    required Map<String, String> headers,
    dynamic body,
    Map<String, String>? queryParameters,
    bool customPath = false,
    String contentType = 'application/json',
  }) async {
    path = customPath ? endpoint : BASE_URL + path;
    Response? resp;
    dynamic decodedJson;
    _dio.options.headers['Accept'] = 'application/json';
    print(path);
    try {
      switch (method) {
        case 'post':
          resp = await _dio.post(path,
              data: body,
              options: Options(
                contentType: contentType,
                headers: headers,
              ),
              queryParameters: queryParameters);
          break;
        case 'get':
          resp = await _dio.get(path,
              queryParameters: queryParameters,
              options: Options(
                headers: headers,
              ));
          break;
        case 'delete':
          resp = await _dio.delete(path,
              queryParameters: queryParameters,
              options: Options(
                headers: headers,
              ));
          break;
        case "put":
          resp = await _dio.put(path,
              data: body,
              queryParameters: queryParameters,
              options: Options(
                contentType: contentType,
                headers: headers,
              ));
          break;
        case "patch":
          resp = await _dio.patch(path,
              data: body,
              queryParameters: queryParameters,
              options: Options(
                contentType: contentType,
                headers: headers,
              ));
          break;
      }
      decodedJson = resp!.data;
    } catch (e, st) {
      log("""HTTP Request error: 
            statusCode: ${resp?.statusCode}
            body: ${resp?.data}
            exception: $e
            stackTrace: $st
            """);

      decodedJson = Map.from(<String, dynamic>{});
      rethrow;
    }
    return RequestResult(decodedJson, resp.statusCode);
  }

  Future<RequestResult> post(
    String path, {
    Map<String, String> headers = const {},
    dynamic body = '',
    bool customPath = false,
    String contentType = "application/json",
    Map<String, String>? queryParameters,
  }) async {
    headers = Map<String, String>.from(headers);

    return request(
      method: 'post',
      path: path,
      headers: headers,
      body: body,
      contentType: contentType,
      customPath: customPath,
      queryParameters: queryParameters,
    );
  }

  Future<RequestResult> delete(
    String path, {
    Map<String, String> headers = const {},
    bool customPath = false,
    Map<String, String>? queryParameters,
  }) async {
    headers = Map<String, String>.from(headers);

    return request(
      method: 'delete',
      path: path,
      headers: headers,
      customPath: customPath,
      queryParameters: queryParameters,
    );
  }

  Future<RequestResult> put(
    String path, {
    Map<String, String> headers = const {},
    dynamic body = '',
    bool customPath = false,
    Map<String, String>? queryParameters,
    String contentType = "",
  }) async {
    headers = Map<String, String>.from(headers);
    return request(
      method: 'put',
      path: path,
      headers: headers,
      body: body,
      customPath: customPath,
      contentType: contentType,
      queryParameters: queryParameters,
    );
  }

  Future<RequestResult> patch(
    String path, {
    Map<String, String> headers = const {},
    dynamic body = '',
    bool customPath = false,
    Map<String, String>? queryParameters,
    String contentType = "",
  }) async {
    headers = Map<String, String>.from(headers);
    return request(
      method: 'patch',
      path: path,
      headers: headers,
      body: body,
      customPath: customPath,
      contentType: contentType,
      queryParameters: queryParameters,
    );
  }

  Future<RequestResult> get(
    String path, {
    Map<String, String> headers = const {},
    bool customPath = false,
    Map<String, String>? queryParameters,
  }) async {
    return request(
      method: 'get',
      path: path,
      headers: headers,
      customPath: customPath,
      queryParameters: queryParameters,
    );
  }
}

enum APIStatus {
  success,
  connectionReady,
  transferError,
  authError,
  serverError,
  connectionError,
  serverConnectionError,
  unexpectedError,
  emptyAccount
}

Map<int, APIStatus> statusCodes = {
  200: APIStatus.success,
  401: APIStatus.authError,
  500: APIStatus.serverError,
  0: APIStatus.unexpectedError
};

class APIResponse<DataModel_T> {
  int? statusCode;
  DataModel_T? load;
  Error? error;
  bool? ok;

  APIResponse(this.statusCode, DataModel_T load) {
    ok = statusCode == 200;

    if (statusCode == 200) {
      this.load = load;
    } else {
      this.load = <String, dynamic>{} as DataModel_T;
      var load_ = load as Map;
      try {
        error = Error(
            code: statusCode,
            message: (load_['message'] as String?) != null
                ? load_['message']
                : load.toString());
      } catch (_) {}
    }
  }

  APIResponse.fromOther(APIResponse other) {
    statusCode = other.statusCode;
    load = other.load;
    error = other.error;
    ok = other.ok;
  }
}

class Error {
  int? code;
  String? message;

  Error({this.code, this.message});
}
