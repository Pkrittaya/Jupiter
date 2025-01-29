import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jupiter_api/config/api/api_config.dart';
import 'package:jupiter_api/data/data_models/request/log_crash_device_info_form.dart';
import 'package:jupiter_api/jupiter_api.dart';
import '../data_sources/helper/exception.dart';

class DioUtil {
  static String domain = JupiterApi.getBaseUrl(ApiConfig.env);
  static String orgCodeFromRoot = 'N/A';
  static String usernameFromRoot = 'N/A';
  static String tokenFromRoot = 'N/A';
  static String deviceCodeFromRoot = 'N/A';
  static String platformFromRoot = 'N/A';
  static String modelFromRoot = 'N/A';
  static String osVersionFromRoot = 'N/A';
  static String appVersionFromRoot = 'N/A';
  static dynamic toJwt(dynamic jsonPayload) {
    try {
      final jwt = JWT(jsonPayload);
      String jwtToken = jwt.sign(
        SecretKey('dqlvMQPhgMMaXCcbx97KpRmFLeGqbAHT'),
        expiresIn: const Duration(minutes: 5),
      );
      return {'payload': jwtToken};
    } catch (e) {
      return {'payload': ''};
    }
  }

  static Dio createDioInstance(String baseUrl) {
    dynamic requestData = {};
    DateTime startTime = DateTime.now();
    var dio = Dio(BaseOptions(baseUrl: baseUrl));
    // adding interceptor
    // dio.interceptors.clear();
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // USE SEND DATA JWT FORM
          debugPrint('Called Url ${options.uri.toString()}');
          debugPrint('Called Url Data ${options.data}');
          debugPrint('------------ JWT PAYLOAD -------------');
          debugPrint('${toJwt(options.data ?? '')}');
          requestData = options.data ?? 'N/A';
          try {
            if (options.path != ApiPath.verifyImageOcr &&
                options.path != ApiPath.updateProfileImage) {
              options.data = toJwt(options.data ?? '');
            }
          } catch (e) {
            debugPrint('ERROR FROM TOJWT : ${e}');
          }
          startTime = DateTime.now();
          tokenFromRoot =
              getHeaderFromOption(options.headers['Authorization'].toString());
          return handler.next(options); //modify your request
        },
        onResponse: (response, handler) {
          debugPrint('onResponse ${response.statusCode}');
          debugPrint('onResponse $response');
          return handler.next(response);
        },
        onError: (e, handler) async {
          debugPrint('onError $e');
          if (e.response != null) {
            if (e.response?.statusCode != 200) {
              sendErrorToService(
                path: getPathFromEvent(e),
                method: getMethodFromEvent(e),
                statusResponse: int.parse('${e.response?.statusCode}'),
                responseTime: calculateResponseTime(startTime, DateTime.now()),
                request: requestData,
                response: getResponseMessage(e),
              );
            }
            if (e.response?.statusCode == 401) {
              debugPrint('UnAuthorized 401');
              handler.next(UnAuthorizedException());
            } else {
              handler.next(e);
            }
          } else {
            handler.next(e);
          }
        },
      ),
    );
    return dio;
  }

  static getPathFromEvent(dynamic event) {
    try {
      return '${event.requestOptions.path}';
    } catch (e) {
      return 'N/A';
    }
  }

  static getMethodFromEvent(dynamic event) {
    try {
      return '${event.requestOptions.method}';
    } catch (e) {
      return 'N/A';
    }
  }

  static String getResponseMessage(dynamic data) {
    try {
      return '${data.response?.data['message'] ?? 'N/A'}';
    } catch (e) {
      return '${data.message}';
    }
  }

  static String getHeaderFromOption(String header) {
    try {
      if (header != 'null' && header != '') {
        return header.replaceAll('Bearer', '').trim();
      }
      return 'N/A';
    } catch (e) {
      return 'N/A';
    }
  }

  static void configDefaultParam({
    required String username,
    required String orgCode,
    String? deviceCode,
    String? platform,
    String? model,
    String? osVersion,
    String? appVersion,
  }) {
    orgCodeFromRoot = orgCode;
    usernameFromRoot = username;
    deviceCodeFromRoot = deviceCode ?? 'N/A';
    platformFromRoot = platform ?? 'N/A';
    modelFromRoot = model ?? 'N/A';
    osVersionFromRoot = osVersion ?? 'N/A';
    appVersionFromRoot = appVersion ?? 'N/A';
  }

  static int calculateResponseTime(DateTime start, DateTime end) {
    try {
      Duration difference = end.difference(start);
      debugPrint('START CALL : ${start.toIso8601String()}');
      debugPrint('END CALL : ${end.toIso8601String()}');
      debugPrint('DIFFERNCE : ${difference.inMilliseconds}');
      int responseTime = difference.inMilliseconds;
      return responseTime;
    } catch (e) {
      return 0;
    }
  }

  static sendErrorToService({
    required String path,
    required String method,
    required int statusResponse,
    required int responseTime,
    required dynamic request,
    required dynamic response,
  }) async {
    dynamic body;
    debugPrint('************** sendErrorToService **************');
    // debugPrint('orgCode : ${orgCodeFromRoot}');
    // debugPrint('requestUrl : ${requestUrl}');
    // debugPrint('username : ${usernameFromRoot}');
    // debugPrint('statusResponse : ${statusResponse}');
    // debugPrint('token : ${tokenFromRoot}');
    // debugPrint('method : ${method}');
    // debugPrint('responseTime : ${responseTime}');
    // debugPrint('request : ${request}');
    // debugPrint('response : ${response}');
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json'
    };
    Map<String, dynamic> jsonMap = {
      'org_code': orgCodeFromRoot,
      'domain': domain,
      'path': path,
      'username': usernameFromRoot,
      'status_response': statusResponse,
      'token': tokenFromRoot,
      'method': method,
      'response_time': responseTime,
      'request': request,
      'response': response,
      'device_info': LogCrashDeviceInfoForm(
        deviceCode: deviceCodeFromRoot,
        platform: platformFromRoot,
        model: modelFromRoot,
        osVersion: osVersionFromRoot,
        appVersion: appVersionFromRoot,
      ).toJson(),
    };
    debugPrint('Json Map : ${jsonMap}');
    try {
      body = jsonEncode(toJwt(jsonMap));
    } catch (e) {
      body = jsonEncode(toJwt(''));
    }
    debugPrint('************************************************');
    final responseService = await http.post(
      Uri.parse(JupiterApi.getBaseUrl(ApiConfig.env) + ApiPath.addLogApi),
      headers: headers,
      body: body,
    );
    dynamic resDecode = jsonDecode(responseService.body);
    String responseMessage = '${resDecode['message'] ?? 'Error'}';
    debugPrint('RESPONSE MESSAGE : $responseMessage');
    if (responseService.statusCode == 200) {
      debugPrint('Create Error Log Service Result : SUCCESS !!!');
    } else {
      debugPrint('Create Error Log Service Result : ERROR !!!');
    }
  }
}
