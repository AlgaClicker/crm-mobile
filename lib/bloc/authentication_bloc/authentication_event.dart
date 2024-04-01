part of 'authentication_bloc.dart';


abstract class AuthenticationEvent {}

class AuthenticationEventLogIn extends AuthenticationEvent {
  final String usrname;
  final String password;
  AuthenticationEventLogIn({required this.usrname,required this.password,});
}

class AuthenticationEventLogOut extends AuthenticationEvent {}
class AuthenticationEventGetMe extends AuthenticationEvent {}

class AuthenticationEventInital extends AuthenticationEvent {}


class AuthenticationEventCheckToken extends AuthenticationEvent {
  final String token;
  AuthenticationEventCheckToken({required this.token});
}