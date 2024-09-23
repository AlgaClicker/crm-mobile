import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/Domain/Crm/specification.dart';

class MasterSpecificationsRepository {
  final Dio dio;

  MasterSpecificationsRepository(this.dio);

  Future<List<Specification>> fetchSpecifications({int page = 1}) async {
    debugPrint("fetchSpecifications");
    try {
      final response = await dio.post('/api/v1/crm/master/specifications', queryParameters: {
        'page': page,
      });
      
      debugPrint(response.toString());
      final data = response.data['data'] as List;
      
      return data.map((json) => Specification.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Ошибка при загрузке спецификаций: $e');
    }
  }


}
