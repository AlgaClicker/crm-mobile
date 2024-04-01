part of 'application_bloc.dart';
abstract class ApplicationBlocState {
  final Account account=Account(id: '0');
}

final class ApplicationBlocInitial extends ApplicationBlocState {}

final class ApplicationBlocStateAuth extends ApplicationBlocState {
  late final Account account;
  ApplicationBlocStateAuth({required this.account});
}

final class ApplicationBlocStateNoAuth extends ApplicationBlocState {}

final class ApplicationBlocStateError extends ApplicationBlocState {}
