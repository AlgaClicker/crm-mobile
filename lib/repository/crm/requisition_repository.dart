import 'package:mobile_alga_crm/domain/entity/crm/requisition.dart';
import 'package:mobile_alga_crm/helpers/api_client.dart';
import 'package:mobile_alga_crm/domain/entity/crm/object.dart';

class RequisitionRepository {
  final ApiClient _api;
  final List<Requisition> _requisitions=[];
  
  RequisitionRepository({required ApiClient api}):_api=api;

  Future<Object> getObjectById(String id) async {

    return Object(id: '', name: '');
  }

  Future<Requisition?> getRequisition(String id) async {
      final Map<String,dynamic> response = await _api.post('/api/v1/crm/master/requisition/$id/',{});
      return Requisition.fromMap(response['data']);
  }

  Future<List<Requisition>> getListRequisitions() async {
    final Map<String,dynamic> response = await _api.post('/api/v1/crm/master/requisition',{});

    if (response.toString() != 'empty') {
        _requisitions.clear();
        response['data'].forEach((element) async {
          _requisitions.add(Requisition.fromMap(element));
        });
    } else {
      _requisitions.clear();
    }
    return _requisitions;
  }
}
