part of 'login_page_bloc.dart';

@immutable
sealed class LoginPageEvent {
    const LoginPageEvent();
}

class LoginPageEventInitial extends LoginPageEvent {}

class LoginPageEventSubmitted extends LoginPageEvent {}

class UsernameFieldChange extends LoginPageEvent {
  final String username ;
  const UsernameFieldChange(this.username);
}

class PasswordFieldChange extends LoginPageEvent {
  final String password ;
  const PasswordFieldChange(this.password);
}