part of 'crm_requestion_page_edit_bloc.dart';

sealed class CrmRequestionPageEditState {
  DateTime endAt=DateTime.now().add(const Duration(days: 5));
}

final class CrmRequestionPageEditStateInitial extends CrmRequestionPageEditState {}
final class CrmRequestionPageEditStateWorking extends CrmRequestionPageEditState {
  final DateTime endAt;
  CrmRequestionPageEditStateWorking({required this.endAt});
}

