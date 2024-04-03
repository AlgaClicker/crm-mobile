part of 'crm_requestion_page_edit_bloc.dart';

sealed class CrmRequestionPageEditState {
  DateTime endAt=DateTime.now().add(const Duration(days: 5));
  List<Specification> specifications=[];
  final String? specificationId='';
  final Map<String,dynamic>? tableMateral={};
  final String? tableMateralType='';
  final List<SpecificationMaterial>? specificationMaterials=[];
}

final class CrmRequestionPageEditStateInitial extends CrmRequestionPageEditState {}
final class CrmRequestionPageEditStateWorking extends CrmRequestionPageEditState {
  final DateTime endAt;
  final List<Specification> specifications;
  final String? specificationId;
  final Map<String,dynamic>? tableMateral;
  final String? tableMateralType;
  final List<SpecificationMaterial>? specificationMaterials;
  CrmRequestionPageEditStateWorking(
    List<Specification> specifications,
    {required this.endAt,this.specificationId, this.tableMateral,this.tableMateralType, this.specificationMaterials}
  ) : specifications=specifications {
    debugPrint("CrmRequestionPageEditStateWorking SpecCount:${specifications.length.toString()}");
    if (specifications.isNotEmpty == true) {
      this.specifications = specifications;
    } 
  }
}

