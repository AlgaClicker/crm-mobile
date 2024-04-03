
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_alga_crm/domain/entity/crm/specification.dart';
import 'package:mobile_alga_crm/domain/entity/crm/specification_material.dart';
import 'package:mobile_alga_crm/repository/crm/requisition_repository.dart';
import 'package:mobile_alga_crm/repository/crm/specification_repository.dart';

part 'crm_requestion_page_edit_event.dart';
part 'crm_requestion_page_edit_state.dart';

class CrmRequestionPageEditBloc extends Bloc<CrmRequestionPageEditEvent, CrmRequestionPageEditState> {
  final RequisitionRepository _requisitionRepository;
  final SpecificationRepository _specificationRepository;
  CrmRequestionPageEditBloc(
    RequisitionRepository requisitionRepository,
    SpecificationRepository specificationRepository) : 
    _requisitionRepository=requisitionRepository,
    _specificationRepository=specificationRepository,
    super(CrmRequestionPageEditStateInitial()) {
    on<CrmRequestionPageEditEventinital>(_crmRequestionPageEditEventinital);
    on<CrmRequestionPageEditEventSelectEndDate>(_crmRequestionPageEditEventSelectEndDate);
    on<CrmRequestionPageEditEventLoadListSpecifications>(_crmRequestionPageEditEventLoadListSpecifications);
    on<CrmRequestionPageEditEventSelectedSpecification>(_crmRequestionPageEditEventSelectedSpecification);
    on<CrmRequestionPageEditEventMaterialSpec>(_crmRequestionPageEditEventMaterialSpec);
  }

  _crmRequestionPageEditEventMaterialSpec(CrmRequestionPageEditEventMaterialSpec event, Emitter<CrmRequestionPageEditState> emit) async {

  }

  _crmRequestionPageEditEventSelectedSpecification(CrmRequestionPageEditEventSelectedSpecification event, Emitter<CrmRequestionPageEditState> emit) async {
      final String specificationId = event.specificationId;
      if (specificationId == '00000000-0000-0000-0000-000000000000') {
        return emit(CrmRequestionPageEditStateWorking(
          [],
          endAt: state.endAt
        ));
      } else {
          final List<SpecificationMaterial> specificationMaterials = await _specificationRepository.getMySpecificationMaterials(specificationId);

          if (specificationMaterials.isNotEmpty) {
            return emit(CrmRequestionPageEditStateWorking(
          state.specifications,
          endAt: state.endAt,
          tableMateralType: 'spec',
          specificationId: specificationId,
          specificationMaterials: specificationMaterials
        ));
          }

      }
  }

  _crmRequestionPageEditEventLoadListSpecifications(CrmRequestionPageEditEventLoadListSpecifications event, Emitter<CrmRequestionPageEditState> emit) async {
    final List<Specification> specifications = await _specificationRepository.getMySpecification();
    return emit(CrmRequestionPageEditStateWorking(
      specifications,
      endAt: state.endAt,
      tableMateralType: 'spec'
    ));
  }

  _crmRequestionPageEditEventinital(CrmRequestionPageEditEventinital event, Emitter<CrmRequestionPageEditState> emit) async {
    return emit(CrmRequestionPageEditStateWorking(state.specifications,endAt: event.endAt));
  }

  _crmRequestionPageEditEventSelectEndDate(CrmRequestionPageEditEventSelectEndDate event, Emitter<CrmRequestionPageEditState> emit) async {
    debugPrint("_crmRequestionPageEditEventSelectEndDate ${event.endAt}");
    return emit(CrmRequestionPageEditStateWorking(state.specifications,endAt: event.endAt));
  }
}
