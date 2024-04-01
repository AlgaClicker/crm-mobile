
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_alga_crm/domain/entity/crm/requisition.dart';
import 'package:mobile_alga_crm/repository/crm/requisition_repository.dart';

part 'crm_requestion_page_only_event.dart';
part 'crm_requestion_page_only_state.dart';

class CrmRequestionPageOnlyBloc extends Bloc<CrmRequestionPageOnlyEvent, CrmRequestionPageOnlyState> {
  final RequisitionRepository _requisitionRepository;
  
  CrmRequestionPageOnlyBloc(RequisitionRepository requisitionRepository) : _requisitionRepository=requisitionRepository,super(CrmRequestionPageOnlyStateInitial()) {
    on<CrmRequestionPageOnlyEventInital>(_crmRequestionPageOnlyEventInital);
  }

  _crmRequestionPageOnlyEventInital(CrmRequestionPageOnlyEventInital event, Emitter<CrmRequestionPageOnlyState> emit) async {
      final Requisition? requisition = await _requisitionRepository.getRequisition(event.idRequestion);
        debugPrint("${requisition.toString()} ${event.idRequestion}");
      if (requisition != null) {
          emit(CrmRequestionPageOnlyStateLoaded(requisition: requisition));
      } else {
        return emit(CrmRequestionPageOnlyStateError(message: 'Не найдена заявка'));
      }

  }
}
