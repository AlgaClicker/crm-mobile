import 'package:equatable/equatable.dart';
import 'package:mobile_app/Domain/Crm/specification.dart';

abstract class SpecificationsState extends Equatable {
  const SpecificationsState();

  @override
  List<Object> get props => [];
}

class SpecificationsInitial extends SpecificationsState {}

class SpecificationsLoadInProgress extends SpecificationsState {}

class SpecificationsLoadSuccess extends SpecificationsState {
  final List<Specification> specifications;

  const SpecificationsLoadSuccess(this.specifications);

  @override
  List<Object> get props => [specifications];
}

class SpecificationsLoadFailure extends SpecificationsState {
  final String error;

  const SpecificationsLoadFailure(this.error);

  @override
  List<Object> get props => [error];
}
