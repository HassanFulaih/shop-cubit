import 'package:dio/dio.dart';

class DioHelper {
  static late Dio _dio;

  static init() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        // connectTimeout: 5000,
        // receiveTimeout: 3000,
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> get(
    String url, {
    Map<String, dynamic>? query,
    String lan = 'en',
    String? token,
  }) async {
    _dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lan,
      'Authorization': token,
    };
    return await _dio.get(url, queryParameters: query);
  }

  static Future<Response> post(
    String url, {
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String lan = 'en',
    String? token,
  }) async {
    _dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lan,
      'Authorization': token,
    };
    return await _dio.post(
      url,
      queryParameters: query,
      data: data,
    );
  }
}
