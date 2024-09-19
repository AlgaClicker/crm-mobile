import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile_app/Models/auth_token.dart';
import 'dart:convert';

class AuthService {
  static const _tokenKey = 'auth_token';
  static const _tokenDataKey = 'auth_token_data';
  final Dio dio;

  AuthService({required this.dio});

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
    _setDioToken(token);
  }

  Future<void> saveTokenData(AuthToken authToken) async {
    final prefs = await SharedPreferences.getInstance();
    final tokenData = json.encode(authToken.toJson());
    await prefs.setString(_tokenDataKey, tokenData);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  Future<AuthToken?> getTokenData() async {
    final prefs = await SharedPreferences.getInstance();
    final tokenData = prefs.getString(_tokenDataKey);

    if (tokenData != null) {
      final Map<String, dynamic> jsonMap = json.decode(tokenData);
      return AuthToken.fromJson(jsonMap);
    }
    return null;
  }

  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_tokenDataKey);
    _clearDioToken();
  }

  void _setDioToken(String token) {
    dio.options.headers['Authorization'] = 'Bearer $token';
  }

  void _clearDioToken() {
    dio.options.headers.remove('Authorization');
  }

  Future<void> initialize() async {
    final token = await getToken();
    if (token != null) {
      _setDioToken(token);
    }
  }
}
