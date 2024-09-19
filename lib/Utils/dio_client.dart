import 'package:dio/dio.dart';

class DioClient {
  final Dio _dio = Dio();

  Dio get dio => _dio;
  DioClient() {
    _dio.options.baseUrl = "http://192.168.0.210:8888";
    _dio.options.headers = {
      "Content-Type": "application/json",
    };

    // Включение логирования
    //_dio.interceptors.add(LogInterceptor(responseBody: true));
  }

  Future<Response> post(String path, {dynamic data}) async {
    return await _dio.post(path, data: data);
  }

  void setAuthToken(String token) {
    _dio.options.headers["Authorization"] = "Bearer $token";
  }
}
