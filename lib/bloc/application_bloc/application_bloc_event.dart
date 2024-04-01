
part of 'application_bloc.dart';
abstract class ApplicationBlocEvent {}
final class ApplicationBlocEventInit extends ApplicationBlocEvent {}

final class ApplicationBlocEventNoAuth extends ApplicationBlocEvent {}
final class ApplicationBlocEventAuth extends ApplicationBlocEvent {
  final Account account;
  ApplicationBlocEventAuth({required this.account});
}
