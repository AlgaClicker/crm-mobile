import 'package:bloc/bloc.dart';
import 'package:mobile_app/Repositories/master_requisitions_repository.dart';
import 'package:mobile_app/Domain/Crm/requisition.dart';
import 'package:mobile_app/domain/Crm/requisition_materials.dart';
import 'create_page_requisition_event.dart';
import 'create_page_requisition_state.dart';

class MasterPageRequisitionBloc extends Bloc<RequisitionEvent, RequisitionState> {
  final MasterRequisitionsRepository requisitionRepository;

  MasterPageRequisitionBloc({required this.requisitionRepository})
      : super(RequisitionState.initial()) {
    on<RequisitionEndAtChanged>(_onEndAtChanged);
    on<RequisitionSpecificationChanged>(_onSpecificationChanged);
    on<RequisitionCommentChanged>(_onCommentChanged);
    on<RequisitionMaterialAdded>(_onMaterialAdded);
    on<RequisitionSubmitted>(_onSubmitted);
  }

  void _onEndAtChanged(RequisitionEndAtChanged event, Emitter<RequisitionState> emit) {
    emit(state.copyWith(endAt: event.endAt));
  }

  void _onSpecificationChanged(RequisitionSpecificationChanged event, Emitter<RequisitionState> emit) {
    emit(state.copyWith(specification: event.specification));
  }

  void _onCommentChanged(RequisitionCommentChanged event, Emitter<RequisitionState> emit) {
    emit(state.copyWith(comment: event.comment));
  }

  void _onMaterialAdded(RequisitionMaterialAdded event, Emitter<RequisitionState> emit) {
    // final updatedMaterials = List<RequisitionMaterials>.from(state.materials)..add(event.material);
   // emit(state.copyWith(materials: updatedMaterials));
  }

  Future<void> _onSubmitted(RequisitionSubmitted event, Emitter<RequisitionState> emit) async {
    emit(state.copyWith(isSubmitting: true));
    /*
    try {
      final newRequisition = Requisition(
        id: '', // ID будет назначен на сервере
        number: '', // Генерируемый номер
        status: 'new',
        type: 'default',
        fixed: true, // Можно сделать динамическим, если требуется
        createdAt: DateTime.now(),
        endAt: state.endAt,
        description: state.comment,
        materials: state.materials,
        specification: state.specification,
        manager: null,
        author: null,
      );
      */
      //await requisitionRepository.createRequisition(newRequisition);
      //emit(state.copyWith(isSubmitting: false, isSuccess: true));
      //emit(state.copyWith(isSubmitting: false, isFailure: true));


  }
}
