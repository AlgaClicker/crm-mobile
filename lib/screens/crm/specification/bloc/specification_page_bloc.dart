
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_alga_crm/domain/entity/crm/specification.dart';
import 'package:mobile_alga_crm/repository/crm/specification_repository.dart';

part 'specification_page_event.dart';
part 'specification_page_state.dart';

class SpecificationPageBloc extends Bloc<SpecificationPageBlocEvent, SpecificationPageBlocState> {
  final SpecificationRepository _specificationRepository;
  SpecificationPageBloc(SpecificationRepository specificationRepository) : _specificationRepository = specificationRepository, super(SpecificationPageBlocStateInitial()) {
    on<SpecificationPageBlocEventInital>(_specificationPageEventInital);
    on<SpecificationPageBlocEventLoadingSpecifications>(_specificationPageBlocEventLoadingSpecifications);

  }

  _specificationPageBlocEventLoadingSpecifications(SpecificationPageBlocEventLoadingSpecifications event, Emitter<SpecificationPageBlocState> emit) async {
    emit(SpecificationPageBlocStateLoadSpec());
    final List<Specification> specifoctions = await _specificationRepository.getMySpecification();
     if (specifoctions.isNotEmpty) {
      emit(SpecificationPageBlocStateLoadedSpecifictionList(specifications: specifoctions));
     }

  }
  
  _specificationPageEventInital(SpecificationPageBlocEventInital event, Emitter<SpecificationPageBlocState> emit) async {
    add(SpecificationPageBlocEventLoadingSpecifications());
  }
}
