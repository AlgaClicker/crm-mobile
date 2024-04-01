part of 'specification_page_bloc.dart';

abstract class SpecificationPageBlocEvent {}
final class SpecificationPageBlocEventInital extends SpecificationPageBlocEvent {}
final class SpecificationPageBlocEventLoadingSpecifications extends SpecificationPageBlocEvent {}
final class SpecificationPageBlocEventLoadSpec extends SpecificationPageBlocEvent {
  final String id;
  SpecificationPageBlocEventLoadSpec({required this.id});
}
