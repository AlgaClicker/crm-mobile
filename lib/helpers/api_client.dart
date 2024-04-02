import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ApiClient{
  final Dio _api = Dio();
  //String _token;
  //Map<String,dynamic> _options={};

  ApiClient();

  Future<void> initClient(String baseUrl) async {
    _api.options = BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 60),
          receiveTimeout: const Duration(seconds: 60),
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
          headers: {
            'Access-Control-Allow-Origin':'true'
          }
      );
  }

  Future<void> setBearerToken(String token) async {
    if (token.isEmpty) {
      return;
    }
    debugPrint("-------setBearerToken: $token");
    //final Str_token = token;
   
    _api.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        options.headers['Authorization'] = "Bearer $token";
        //debugPrint("_api.interceptors.add SetToken: $token");
        return handler.next(options);
      },
      onError: (DioError e, handler) async {
          debugPrint("DioError:  Token: $token");
          debugPrint(handler.toString());
          debugPrint(e.requestOptions.path);
      }
    ));
    
  }

  Future<Map<String,dynamic>> getOnly(String endpoint, String id) async {
    try {
     final Response response = await _api.post("$endpoint/$id");
        if (response.statusCode == 200) {   
          if (response.data.containsKey('options') == true){
            //_options = response.data['options'];
          }
          return {
            'data':response.data,
          };
        } else {
          return {
            'error': response.statusCode.toString(),
            'message': response.statusMessage
          };        
        } 
        
    }  on DioException  catch (ex)  {
      //debugPrint(ex.message);
      debugPrint("DioException: ${ex.message}");
      return {
        'error': ex.response?.statusCode.toString(),
        'message': ex.response?.statusMessage
      };
    }

  }

  Future<Map<String,dynamic>> post(String endpoint, Map<String,dynamic>? data) async {
    try {
     final Response response = await _api.post(endpoint,data: data);
        if (response.statusCode == 200) {   
          if (response.data.containsKey('options') == true){
            //_options = response.data['options'];
          }
          return {
            'data':response.data['data'],
          };
        } else {
          return {
            'error': response.statusCode.toString(),
            'message': response.statusMessage
          };        
        } 
        
    }  on DioException  catch (ex)  {
      //debugPrint(ex.message);
      debugPrint("DioException: ${ex.message}");
      return {
        'error': ex.response?.statusCode.toString(),
        'message': ex.response?.statusMessage
      };
    }
  }

  void setOptionsReg(Map<String,dynamic> options) {
    //_options = options;
  }

}