part of 'crm_requestion_page_only_bloc.dart';

sealed class CrmRequestionPageOnlyState {
  Requisition? requisition;
  String? message;
  
}

final class CrmRequestionPageOnlyStateInitial extends CrmRequestionPageOnlyState {}
final class CrmRequestionPageOnlyStateLoading extends CrmRequestionPageOnlyState {}
final class CrmRequestionPageOnlyStateLoaded extends CrmRequestionPageOnlyState {
  final Requisition requisition;
  CrmRequestionPageOnlyStateLoaded({required this.requisition});
}


final class CrmRequestionPageOnlyStateError extends CrmRequestionPageOnlyState {
  final String message;
  CrmRequestionPageOnlyStateError({required this.message});
}