import 'package:mobile_app/Domain/Account/Account.dart';

class AuthToken {
  final String accessToken;
  final String? tokenType; // Тип токена может быть null
  final int expiresIn;
  final Account account;

  AuthToken({
    required this.accessToken,
    this.tokenType, // Необязательное поле
    required this.expiresIn,
    required this.account,
  });

  factory AuthToken.fromJson(Map<String, dynamic> json) {
    return AuthToken(
      accessToken: json['token'] ??
          '', // Обработка null: если 'token' отсутствует, используем пустую строку
      tokenType: json[
          'type'], // Это поле может быть null, поэтому мы просто передаем его как есть
      expiresIn: json['expires_in'] ??
          0, // Обработка null: если 'expires_in' отсутствует, используем 0
      account: Account.fromJson(json['account'] ??
          {}), // Обработка null: если 'account' отсутствует, используем пустой объект
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': accessToken,
      'type': tokenType, // Если null, запишется как null
      'expires_in': expiresIn,
      'account': account.toJson(), // Преобразование объекта Account в JSON
    };
  }
}
