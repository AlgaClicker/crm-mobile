import 'package:dio/dio.dart';

class DioClient {
  final Dio _dio = Dio();

  Dio get dio => _dio;
  DioClient() {
    _dio.options.baseUrl = "https://cms.alga-corp.ru/";
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
