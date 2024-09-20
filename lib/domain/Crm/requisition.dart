import 'package:flutter/material.dart';
import 'package:mobile_app/Domain/Account/Account.dart';
import 'requisition_materials.dart';
import 'specification.dart';

class Requisition {
  final String id;
  final String number;
  final String status;
  final String type;
  final bool fixed;
  final Account author;
  final DateTime createdAt;
  final DateTime endAt;
  final String? description;
  final List<RequisitionMaterials>? materials; // Поле может быть null
  final Specification? specification; // Поле может быть null
  final Account? manager; // Поле может быть null

  Requisition({
    required this.id,
    required this.number,
    required this.status,
    required this.type,
    required this.fixed,
    required this.author,
    required this.createdAt,
    required this.endAt,
    this.description,
    this.materials,
    this.specification,
    this.manager,
  });

  factory Requisition.fromJson(Map<String, dynamic> json) {
    debugPrint("Requisition.fromJson");
    debugPrint(json['number']);
    return Requisition(
      id: json['id'] as String,
      number: json['number'] as String,
      status: json['status'] as String,
      type: json['type'] as String,
      fixed: json['fixed']  as bool,
      author: Account.fromJson(json['autor'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['created_at'] as String),
      endAt: DateTime.parse(json['end_at'] as String),
      description: json['description'] as String?,
      materials: json['materials'] != null
          ? (json['materials'] as List)
              .map((item) =>
                  RequisitionMaterials.fromJson(item as Map<String, dynamic>))
              .toList()
          : null,
      specification: json['specification'] != null
          ? Specification.fromJson(
              json['specification'] as Map<String, dynamic>)
          : null,
      manager: json['manager'] != null
          ? Account.fromJson(
              json['manager'] as Map<String, dynamic>)
          : null,

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'number': number,
      'status': status,
      'type': type,
      'fixed': fixed,
      'autor': author.toJson(),
      'created_at': createdAt.toIso8601String(),
      'end_at': endAt.toIso8601String(),
      'description': description,
      'materials': materials?.map((item) => item.toJson()).toList(),
      'specification': specification?.toJson(),
      'manager': specification?.toJson(),
    };
  }
}
