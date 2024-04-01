part of 'crm_index_page_bloc.dart';

sealed class CrmIndexPageEvent {}
final class CrmIndexPageEventInital extends CrmIndexPageEvent {}
final class CrmIndexPageEventListSpec extends CrmIndexPageEvent {}
final class CrmIndexPageEventListRequestions extends CrmIndexPageEvent {}