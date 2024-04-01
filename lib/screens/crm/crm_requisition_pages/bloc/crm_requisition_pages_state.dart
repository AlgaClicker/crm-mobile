part of 'crm_requisition_pages_bloc.dart';

abstract class CrmRequisitionPagesState {
  final List<Requisition> requisitions=[];
}

final class CrmRequisitionPagesInitial extends CrmRequisitionPagesState {}
final class CrmRequisitionPagesStateLoading extends CrmRequisitionPagesState {}

final class CrmRequisitionPagesStateLoadList extends CrmRequisitionPagesState {
  
  final List<Requisition> requisitions;
  CrmRequisitionPagesStateLoadList({required this.requisitions});
}
