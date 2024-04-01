

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_alga_crm/domain/entity/crm/specification.dart';
import 'package:mobile_alga_crm/repository/crm/specification_repository.dart';

part 'crm_index_page_event.dart';
part 'crm_index_page_state.dart';

class CrmIndexPageBloc extends Bloc<CrmIndexPageEvent, CrmIndexPageState> {
  final SpecificationRepository _specificationRepository;
  

  CrmIndexPageBloc({required SpecificationRepository specificationRepository}) : _specificationRepository=specificationRepository,super(CrmIndexPageStateInitial()) {
    on<CrmIndexPageEventInital>(_crmIndexPageEventInital);
    on<CrmIndexPageEventListSpec>(_crmIndexPageEventListSpec);
    on<CrmIndexPageEventListRequestions>(_crmIndexPageEventListRequestions);
  
  }
  _crmIndexPageEventListRequestions(CrmIndexPageEventListRequestions event, Emitter<CrmIndexPageState> emit) async {
      emit(CrmIndexPageStateRequestion());
  }

  _crmIndexPageEventListSpec(CrmIndexPageEventListSpec event, Emitter<CrmIndexPageState> emit) async {
    final List<Specification> _specifications = await _specificationRepository.getMySpecification();
      if (_specifications.isEmpty) {
        debugPrint("_crmIndexPageEventListSpec isEmpty: ${_specifications.toString()}");
        emit(CrmIndexPageStateSpecEmpty());
      } else {
      debugPrint("_crmIndexPageEventListSpec : ${_specifications.toString()}");
      emit(CrmIndexPageStateSpec(specifications: _specifications));
    }
  }

  _crmIndexPageEventInital(CrmIndexPageEventInital event, Emitter<CrmIndexPageState> emit) {
  emit(CrmIndexPageStateInitial());
  }

}
