part of 'crm_requestion_page_only_bloc.dart';

abstract class CrmRequestionPageOnlyEvent {}
class CrmRequestionPageOnlyEventInital extends CrmRequestionPageOnlyEvent{
  final String idRequestion;
  CrmRequestionPageOnlyEventInital({required this.idRequestion});
}
 
class CrmRequestionPageOnlyEventLoad extends CrmRequestionPageOnlyEvent{
  
}