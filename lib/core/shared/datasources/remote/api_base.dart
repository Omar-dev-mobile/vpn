import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:cupertino_http/cupertino_http.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:http/io_client.dart';
import 'package:vpn/core/constants.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:vpn/translations/locate_keys.g.dart';

class RequestResult {
  dynamic json;
  int? statusCode;

  RequestResult(this.json, this.statusCode);
}

abstract class ApiBase {
  late String endpoint;
  late http.Client httpClient; // Change: Declare httpClient here

  ApiBase() {
    initCer();
  }

  initCer() async {
    http.Client client;
    if (Platform.isIOS || Platform.isMacOS) {
      final config = URLSessionConfiguration.ephemeralSessionConfiguration()
        ..allowsCellularAccess = true
        ..allowsExpensiveNetworkAccess = true
        ..cache = URLCache.withCapacity(memoryCapacity: 2 * 1024 * 1024);
      client = CupertinoClient.fromSessionConfiguration(config);
    } else {
      client = IOClient();
    }
    httpClient = InterceptedClient.build(
        interceptors: [LoggerInterceptor()], client: client);
  }

  Future<RequestResult> request({
    required String method,
    required String path,
    required Map<String, String> headers,
    dynamic body,
    Map<String, String>? queryParameters,
    bool customPath = false,
    String contentType = 'application/x-www-form-urlencoded',
  }) async {
    path = customPath ? endpoint : path;
    dynamic decodedJson;
    headers.addAll({"lang": getlocaleName()});
    headers["Content-Type"] = "application/x-www-form-urlencoded";
    final Uri uri = Uri.parse(path);
    var timeout = const Duration(seconds: 5);
    log('🚀🚀🚀---------------------------------🚀🚀🚀');
    log('|  SENT $method:');
    log('|    🟡 BODY: $body');
    log('🚀🚀🚀---------------------------------🚀🚀🚀');
    log('\n');
    try {
      late http.Response response;
      switch (method) {
        case 'post':
          response = await httpClient
              .post(uri, headers: headers, body: body)
              .timeout(timeout);
          {}
          break;
        case 'get':
          response =
              await httpClient.get(uri, headers: headers).timeout(timeout);
          {}
          break;
        case 'delete':
          response =
              await httpClient.delete(uri, headers: headers).timeout(timeout);
          {}
          break;
        case 'put':
          response = await httpClient
              .put(uri, headers: headers, body: body)
              .timeout(timeout);
          {}
          break;
        case 'patch':
          response = await httpClient
              .patch(uri, headers: headers, body: body)
              .timeout(timeout);
          {}
          break;
        default:
          throw Exception(LocaleKeys.anUnexpectedErrorOccurred.tr());
      }
      decodedJson = json.decode(response.body);
      return RequestResult(decodedJson, response.statusCode);
    } catch (e, st) {
      print("""HTTP Request error: 
            exception: $e
            stackTrace: $st
            """);
      decodedJson = <String, dynamic>{};
      rethrow;
    }
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

class LoggerInterceptor extends InterceptorContract {
  @override
  Future<BaseRequest> interceptRequest({
    required BaseRequest request,
  }) async {
    log('🚀🚀🚀---------------------------------🚀🚀🚀');
    log('| REQUEST SENT:');
    log('|    🟡 FULL URL: ${request.url.toString()}');
    log('|    🟡 request: ${request.toString()}');
    log('|    🟡 HEADERS: ${request.headers.toString()}');
    log('🚀🚀🚀---------------------------------🚀🚀🚀');
    log('\n');
    return request;
  }

  @override
  Future<BaseResponse> interceptResponse({
    required BaseResponse response,
  }) async {
    log('-----------------✅✅✅✅✅-----------------');
    log('| RESPONSE RECEIVED:');
    log('|    🟢 REQUEST: ${response.request?.url.toString()}');
    if (response is Response) {
      log('|    🟢 DATA: ${(response).body}');
    }
    log('-----------------✅✅✅✅✅-----------------');
    log('\n');
    return response;
  }
}
