import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_app/Models/auth_token.dart';
import 'package:mobile_app/Utils/dio_client.dart';
import 'package:mobile_app/Services/auth_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final DioClient dioClient;
  final AuthService authService;

  AuthBloc({required this.dioClient, required this.authService})
      : super(AuthInitial()) {
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
    on<AuthCheckStatus>(_onCheckStatus);
    on<AuthLoginOff>(_onLoginOut);

    // Проверка токена при запуске приложения
    add(AuthCheckStatus());
  }

  void _onLoginRequested(
      AuthLoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final response = await dioClient.post('/auth/login', data: {
        "username": event.username,
        "password": event.password,
      });

      // Создаем AuthToken из ответа
      final authToken = AuthToken.fromJson(response.data['data']);

      // Сохраняем токен через AuthService
      await authService.saveToken(authToken.accessToken);
      await authService.saveTokenData(authToken);

      // Устанавливаем токен в dioClient для будущих запросов
      dioClient.setAuthToken(authToken.accessToken);

      emit(AuthSuccess(authToken));
    } catch (e) {
      emit(AuthFailure("Login failed: $e"));
    }
  }

  void _onLogoutRequested(
      AuthLogoutRequested event, Emitter<AuthState> emit) async {
    // Очищаем токен через AuthService
    await authService.clearToken();
    dioClient.setAuthToken(''); // Очищаем токен в dioClient
    emit(AuthInitial()); // Возвращаемся к начальному состоянию
  }

  void _onCheckStatus(AuthCheckStatus event, Emitter<AuthState> emit) async {
    final storedToken = await authService.getTokenData();
    if (storedToken != null) {
      dioClient.setAuthToken(storedToken.accessToken);
      emit(AuthSuccess(storedToken));
    } else {
      emit(AuthInitial());
    }
  }

  void _onLoginOut(AuthLoginOff event, Emitter<AuthState> emit) {
    // Обработка выхода из системы
    emit(AuthInitial());
  }
}
