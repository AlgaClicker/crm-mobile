part of 'login_page_bloc.dart';


final  class LoginPageState {
  final String username;
  final String password;
  final bool isValid;
  const LoginPageState({
    this.username='',
    this.password='',
    this.isValid = false
  });


    LoginPageState copyWith({
       String? username,
       String? password,
       bool? isValid,

    }) {
      return LoginPageState(
        username: username ?? this.username,
        password: password ?? this.password,
        isValid: isValid ?? this.isValid,
      );
    }

}

final class LoginPageStateInitial extends LoginPageState {}

final class LoginPageStateLoginButton extends LoginPageState {}

final class LoginPageStateCountUp extends LoginPageState {}

final class LoginPageStateTextUsername extends LoginPageState {}

final class LoginPageStateTextPassword extends LoginPageState {}
