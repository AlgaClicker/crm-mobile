
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/Repositories/master_specifications_repository.dart';
import 'package:mobile_app/Domain/Crm/specification.dart';
import 'master_specifications_page_bloc_event.dart';
import 'master_specifications_page_bloc_state.dart';

class MasterSpecificationsPageBloc extends Bloc<MasterSpecificationsPageBlocEvent, MasterSpecificationsPageBlocState> {
  final MasterSpecificationsRepository masterSpecificationsRepository;

  MasterSpecificationsPageBloc({required this.masterSpecificationsRepository})
      : super(const MasterSpecificationsPageBlocState()) {
    on<MasterSpecificationsFetched>(_onSpecificationsFetched);
    on<MasterSpecificationSelected>(_onSpecificationSelected);
  }

  Future<void> _onSpecificationsFetched(MasterSpecificationsFetched event, Emitter<MasterSpecificationsPageBlocState> emit) async {
    debugPrint(state.toString());
    if (state.hasReachedMax) return;

    try {
      if (state.status == SpecificationsPageStatus.initial) {
        final specifications = await masterSpecificationsRepository.fetchSpecifications(page: 1);
        return emit(state.copyWith(
          status: SpecificationsPageStatus.success,
          specifications: specifications,
          hasReachedMax: false,
        ));
      }

      final specifications = await masterSpecificationsRepository.fetchSpecifications(page: state.specifications.length ~/ 20 + 1);
      specifications.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(state.copyWith(
              status: SpecificationsPageStatus.success,
              specifications: List.of(state.specifications)..addAll(specifications),
              hasReachedMax: false,
            ));
    } catch (_) {
      emit(state.copyWith(status: SpecificationsPageStatus.failure));
    }
  }

  void _onSpecificationSelected(
      MasterSpecificationSelected event, Emitter<MasterSpecificationsPageBlocState> emit) {
    // Логика для обработки выбора спецификации
    
  }
}
