import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/Repositories/master_specifications_repository.dart';

import 'specifications_event.dart';
import 'specifications_state.dart';

class SpecificationsBloc extends Bloc<SpecificationsEvent, SpecificationsState> {
  final MasterSpecificationsRepository repository;

  SpecificationsBloc({required this.repository}) : super(SpecificationsInitial()) {
    on<LoadSpecifications>(_onLoadSpecifications);
  }

  void _onLoadSpecifications(
      LoadSpecifications event, Emitter<SpecificationsState> emit) async {
    emit(SpecificationsLoadInProgress());

    try {
      final specifications = await repository.fetchSpecifications();
      emit(SpecificationsLoadSuccess(specifications));
    } catch (error) {
      emit(SpecificationsLoadFailure(error.toString()));
    }
  }
}
