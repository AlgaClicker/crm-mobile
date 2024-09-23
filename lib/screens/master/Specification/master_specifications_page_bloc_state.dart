import 'package:equatable/equatable.dart';
import 'package:mobile_app/Domain/Crm/specification.dart';

enum SpecificationsPageStatus { initial, success, failure }

class MasterSpecificationsPageBlocState extends Equatable {
  final SpecificationsPageStatus status;
  final List<Specification> specifications;
  final bool hasReachedMax;

  const MasterSpecificationsPageBlocState({
    this.status = SpecificationsPageStatus.initial,
    this.specifications = const <Specification>[],
    this.hasReachedMax = false,
  });

  MasterSpecificationsPageBlocState copyWith({
    SpecificationsPageStatus? status,
    List<Specification>? specifications,
    bool? hasReachedMax,
  }) {
    return MasterSpecificationsPageBlocState(
      status: status ?? this.status,
      specifications: specifications ?? this.specifications,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [status, specifications, hasReachedMax];
}
