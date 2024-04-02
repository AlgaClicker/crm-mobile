
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'crm_requestion_page_edit_event.dart';
part 'crm_requestion_page_edit_state.dart';

class CrmRequestionPageEditBloc extends Bloc<CrmRequestionPageEditEvent, CrmRequestionPageEditState> {
  CrmRequestionPageEditBloc() : super(CrmRequestionPageEditStateInitial()) {
    on<CrmRequestionPageEditEventinital>(_crmRequestionPageEditEventinital);
    on<CrmRequestionPageEditEventSelectEndDate>(_crmRequestionPageEditEventSelectEndDate);
  }
  
  _crmRequestionPageEditEventinital(CrmRequestionPageEditEventinital event, Emitter<CrmRequestionPageEditState> emit) async {

    return emit(CrmRequestionPageEditStateWorking(endAt: event.endAt));
  }

  _crmRequestionPageEditEventSelectEndDate(CrmRequestionPageEditEventSelectEndDate event, Emitter<CrmRequestionPageEditState> emit) async {
    debugPrint("_crmRequestionPageEditEventSelectEndDate ${event.endAt}");
    return emit(CrmRequestionPageEditStateWorking(endAt: event.endAt));
  }
}
