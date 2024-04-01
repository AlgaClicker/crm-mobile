part of 'crm_index_page_bloc.dart';

abstract class CrmIndexPageState {
  final List<Specification> specifications=[];
}

final class CrmIndexPageStateInitial extends CrmIndexPageState {}

final class CrmIndexPageStateRequestion extends CrmIndexPageState {}

final class CrmIndexPageStateSpecEmpty extends CrmIndexPageState {}


final class CrmIndexPageStateSpec extends CrmIndexPageState {
  final List<Specification> specifications;
  CrmIndexPageStateSpec({required this.specifications});
}

