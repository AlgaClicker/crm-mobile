
import 'package:flutter_bloc/flutter_bloc.dart';

part 'crm_requestion_page_edit_event.dart';
part 'crm_requestion_page_edit_state.dart';

class CrmRequestionPageEditBloc extends Bloc<CrmRequestionPageEditEvent, CrmRequestionPageEditState> {
  CrmRequestionPageEditBloc() : super(CrmRequestionPageEditStateInitial()) {
    on<CrmRequestionPageEditEventinital>(_crmRequestionPageEditEventinital);
  }
  
  _crmRequestionPageEditEventinital(CrmRequestionPageEditEventinital event, Emitter<CrmRequestionPageEditState> emit) async {

  }
}
