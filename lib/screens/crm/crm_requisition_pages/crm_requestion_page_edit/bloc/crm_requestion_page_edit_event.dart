part of 'crm_requestion_page_edit_bloc.dart';

abstract class CrmRequestionPageEditEvent {
  final DateTime endAt = DateTime.now().add(const Duration(days: 14));
}

final class CrmRequestionPageEditEventinital extends CrmRequestionPageEditEvent{}

final class CrmRequestionPageEditEventLoadListSpecifications extends CrmRequestionPageEditEvent{}

final class CrmRequestionPageEditEventMaterialSpec extends CrmRequestionPageEditEvent{}


final class CrmRequestionPageEditEventSelectedSpecification extends CrmRequestionPageEditEvent{
  final String specificationId;
  CrmRequestionPageEditEventSelectedSpecification({required this.specificationId});
}
final class CrmRequestionPageEditEventSelectEndDate extends CrmRequestionPageEditEvent{
final DateTime endAt;
  CrmRequestionPageEditEventSelectEndDate({required this.endAt});
}