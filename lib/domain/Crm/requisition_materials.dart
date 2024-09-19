import 'package:flutter/material.dart';
import 'package:mobile_app/Domain/Systems/unit.dart';
import 'package:mobile_app/Domain/Directory/directory_material.dart';

class RequisitionMaterials {
  final String id;
  final String? materialName; // Обновленное поле
  final DirectoryMaterial?
      material; // Связь с DirectoryMaterial, может быть null
  final double? quantity;
  final Unit? unit;
  final String? description;

  RequisitionMaterials({
    required this.id,
    this.material, // Поле необязательно
    this.quantity,
    this.materialName,
    this.unit,
    this.description,
  });

  factory RequisitionMaterials.fromJson(Map<String, dynamic> json) {
    //debugPrint("RequisitionMaterials.fromJson");
    //debugPrint(json['directory_material'].toString());
    return RequisitionMaterials(
      id: json['id'] as String,
      materialName: json['materialName'] ?? '' as String?,
      material: json['directory_material'] != null
          ? DirectoryMaterial.fromJson(
              json['directory_material'] as Map<String, dynamic>)
          : null, // Преобразование к DirectoryMaterial, если присутствует
      quantity: json['quantity'] != null
          ? json['quantity'] ?? 0 as double
          : null, // Приведение к int
      unit: json['unit'] != null
          ? Unit.fromJson(json['unit'] as Map<String, dynamic>)
          : null, // Преобразование к Unit, если присутствует
      description: json['description'] ?? "" as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'materialName': materialName,
      'directory_material':
          material?.toJson(), // Сериализация DirectoryMaterial
      'quantity': quantity,
      'unit': unit?.toJson(), // Убедитесь, что unit сериализован корректно
      'description': description,
    };
  }

  @override
  String toString() {
    return 'RequisitionMaterials(id: $id, material: $material, quantity: $quantity, unit: $unit, description: $description)';
  }
}
