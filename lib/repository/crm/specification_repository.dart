

import 'package:flutter/rendering.dart';
import 'package:mobile_alga_crm/domain/entity/crm/specification.dart';
import 'package:mobile_alga_crm/helpers/api_client.dart';
import 'package:mobile_alga_crm/domain/entity/crm/object.dart';

class SpecificationRepository {
  final ApiClient _api;
  final List<Specification> _specifications=[];
  SpecificationRepository({required ApiClient api}):_api=api;

  Future<Object> getObjectById(String id) async {

    return Object(id: '', name: '');
  }

  Future<List<Specification>> getMySpecification() async {
    final Map<String,dynamic> response = await _api.post('/api/v1/crm/master/specifications',{});
    debugPrint(response['data'].toString());
    if (response['data'] == null ) {
        debugPrint("data NULL Specification");
        return [];
    } else {
      _specifications.clear();
      response['data'].forEach((element) async {
        _specifications.add(Specification.fromMap(element));
      });
      return _specifications;  
    }
  }      
}
