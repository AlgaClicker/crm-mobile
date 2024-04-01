part of 'authentication_bloc.dart';

sealed class AuthenticationState {}
final class AuthenticationInitial extends AuthenticationState {}
final class AuthenticationStateAuthTrue extends AuthenticationState {
  final Account account;
  AuthenticationStateAuthTrue({required this.account});
}
final class AuthenticationStateLogIn extends AuthenticationState {}
final class AuthenticationStateLogOut extends AuthenticationState {}


