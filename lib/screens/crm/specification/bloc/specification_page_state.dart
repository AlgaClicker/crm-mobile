part of 'specification_page_bloc.dart';

abstract class SpecificationPageBlocState {
  final List<Specification> specifications=[];
}
final class SpecificationPageBlocStateInitial extends SpecificationPageBlocState {}
final class SpecificationPageBlocStateShowSpec extends SpecificationPageBlocState {}
final class SpecificationPageBlocStateLoadSpec extends SpecificationPageBlocState {}
final class SpecificationPageBlocStateLoadedSpecifictionList extends SpecificationPageBlocState {
  final List<Specification> specifications;
  SpecificationPageBlocStateLoadedSpecifictionList({required this.specifications}); 
}
