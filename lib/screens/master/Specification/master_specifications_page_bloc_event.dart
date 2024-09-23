import 'package:equatable/equatable.dart';

abstract class MasterSpecificationsPageBlocEvent extends Equatable {
  const MasterSpecificationsPageBlocEvent();

  @override
  List<Object?> get props => [];
}

class MasterSpecificationsFetched extends MasterSpecificationsPageBlocEvent {}

class MasterSpecificationSelected extends MasterSpecificationsPageBlocEvent {
  final String specificationId;

  const MasterSpecificationSelected(this.specificationId);

  @override
  List<Object?> get props => [specificationId];
}
