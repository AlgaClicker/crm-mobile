import 'package:flutter/material.dart';

class SpecificationMaterial {
  final String id;
  final String name;
  final String unit;
  final int quantity;

  SpecificationMaterial({
    required this.id,
    required this.name,
    required this.unit,
    required this.quantity,
  });

  factory SpecificationMaterial.fromJson(Map<String, dynamic> json) {
    debugPrint("SpecificationMaterial.fromJson");
    debugPrint(json.toString());
    return SpecificationMaterial(
      id: json['id'],
      name: json['name'],
      unit: json['unit'],
      quantity: json['quantity'],
    );
  }
}
