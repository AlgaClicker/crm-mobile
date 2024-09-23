import 'package:equatable/equatable.dart';
import 'package:mobile_app/Domain/Crm/requisition_materials.dart';

class RequisitionState extends Equatable {
  final DateTime endAt;
  final String? specification;
  final String comment;
  final List<RequisitionMaterials> materials;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  const RequisitionState({
    required this.endAt,
    this.specification,
    required this.comment,
    required this.materials,
    this.isSubmitting = false,
    this.isSuccess = false,
    this.isFailure = false,
  });

  factory RequisitionState.initial() {
    return RequisitionState(
      endAt: DateTime.now().add(Duration(days: 7)),
      comment: '',
      materials: [],
    );
  }

  RequisitionState copyWith({
    DateTime? endAt,
    String? specification,
    String? comment,
    List<RequisitionMaterials>? materials,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
  }) {
    return RequisitionState(
      endAt: endAt ?? this.endAt,
      specification: specification ?? this.specification,
      comment: comment ?? this.comment,
      materials: materials ?? this.materials,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  @override
  List<Object?> get props => [endAt, specification, comment, materials, isSubmitting, isSuccess, isFailure];
}
