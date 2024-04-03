
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_alga_crm/domain/entity/crm/requisition.dart';
import 'package:mobile_alga_crm/repository/crm/requisition_repository.dart';

part 'crm_requisition_pages_event.dart';
part 'crm_requisition_pages_state.dart';

class CrmRequisitionPagesBloc extends Bloc<CrmRequisitionPageEvent, CrmRequisitionPagesState> {
  final RequisitionRepository _requisitionRepository;
  CrmRequisitionPagesBloc(RequisitionRepository requisitionRepository) : _requisitionRepository=requisitionRepository,super(CrmRequisitionPagesInitial()) {
    on<CrmRequisitionPageEventLoadRequisitions>(_crmRequisitionPageEventLoadReq);
    on<CrmRequisitionPageEventInital>(_crmRequisitionPageEventInital);
  }

  _crmRequisitionPageEventInital(CrmRequisitionPageEventInital event, Emitter<CrmRequisitionPagesState> emit) async {
    add(CrmRequisitionPageEventLoadRequisitions());
    return emit(CrmRequisitionPagesInitial());
    
  }


  _crmRequisitionPageEventLoadReq(CrmRequisitionPageEventLoadRequisitions event, Emitter<CrmRequisitionPagesState> emit) async {
    emit(CrmRequisitionPagesStateLoading());
    final List<Requisition> requisitions = await _requisitionRepository.getListRequisitions();
    if (requisitions.isNotEmpty) {
      emit(CrmRequisitionPagesStateLoadList(requisitions: requisitions));
    }
  }
}
