import 'package:dio/dio.dart';
import 'package:mobile_app/Domain/Systems/unit.dart';

class UnitsRepository {
  final Dio _dio;

  UnitsRepository(this._dio);

  Future<List<Unit>> fetchUnits() async {
    try {
      final response = await _dio.get('/api/v1/directory/material/units');

      if (response.statusCode == 200) {
        List<Unit> units = (response.data['data'] as List)
            .map((item) => Unit.fromJson(item as Map<String, dynamic>))
            .toList();
        return units;
      } else {
        throw Exception('Ошибка при получении единиц измерения: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Ошибка при получении единиц измерения: $e');
    }
  }
}
