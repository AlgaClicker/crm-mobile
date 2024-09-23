import 'package:equatable/equatable.dart';
import 'package:mobile_app/Domain/Crm/requisition_materials.dart';

abstract class RequisitionEvent extends Equatable {
  const RequisitionEvent();

  @override
  List<Object?> get props => [];
}

class RequisitionEndAtChanged extends RequisitionEvent {
  final DateTime endAt;

  const RequisitionEndAtChanged(this.endAt);

  @override
  List<Object?> get props => [endAt];
}

class RequisitionSpecificationChanged extends RequisitionEvent {
  final String? specification;

  const RequisitionSpecificationChanged(this.specification);

  @override
  List<Object?> get props => [specification];
}

class RequisitionCommentChanged extends RequisitionEvent {
  final String comment;

  const RequisitionCommentChanged(this.comment);

  @override
  List<Object?> get props => [comment];
}

class RequisitionMaterialAdded extends RequisitionEvent {
  final RequisitionMaterials material;

  const RequisitionMaterialAdded(this.material);

  @override
  List<Object?> get props => [material];
}

class RequisitionSubmitted extends RequisitionEvent {}
