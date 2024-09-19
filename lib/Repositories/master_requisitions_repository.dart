import 'package:dio/dio.dart';
import 'package:mobile_app/Domain/Crm/requisition.dart';

class MasterRequisitionsRepository {
  final Dio _dio;

  MasterRequisitionsRepository(this._dio);

  Future<List<Requisition>> fetchRequisitions({
    Map<String, dynamic>? orderBy,
    Map<String, dynamic>? filter,
    int page = 1, // Установка значения по умолчанию для страницы
    int limit = 10, // Установка значения по умолчанию для лимита
  }) async {
    try {
      final data = {
        "options": {
          if (orderBy != null) "orderBy": orderBy,
          if (filter != null) "filter": filter,
          "pagginate": {
            "page": page,
            "limit": limit,
          }
        }
      };

      final response = await _dio.post(
        '/api/v1/crm/master/requisition',
        data: data,
      );

      // Проверяем, что data не равно null и является списком
      if (response.data['data'] != null && response.data['data'] is List) {
        // Преобразуем динамический список в список объектов Requisition
        List<Requisition> requisitions = (response.data['data'] as List)
            .map((item) => Requisition.fromJson(item))
            .toList();
        return requisitions;
      } else {
        return []; // Возвращаем пустой список, если data == null
      }
    } catch (e) {
      throw Exception('Failed to load requisitions: $e');
    }
  }
}
