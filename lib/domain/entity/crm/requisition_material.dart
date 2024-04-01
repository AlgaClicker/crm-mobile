// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:mobile_alga_crm/domain/entity/account/account.dart';
import 'package:mobile_alga_crm/domain/entity/crm/specification_material.dart';
import 'package:mobile_alga_crm/domain/entity/directory/material.dart';
import 'package:mobile_alga_crm/domain/entity/directory/unit.dart';

class RequisitionMaterial {
  final String id;
  final double quantity;
  final String? name;
  final SpecificationMaterial? specificationMaterial;
  final Material? directoryMaterial;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final Account? autor;
  final Unit? unit;
  RequisitionMaterial({
    required this.id,
    required this.quantity,
    this.name,
    this.specificationMaterial,
    this.directoryMaterial,
    required this.createdAt,
    this.updatedAt,
    this.autor,
    this.unit,
  });
  

  RequisitionMaterial copyWith({
    String? id,
    double? quantity,
    String? name,
    SpecificationMaterial? specificationMaterial,
    Material? directoryMaterial,
    DateTime? createdAt,
    DateTime? updatedAt,
    Account? autor,
    Unit? unit,
  }) {
    return RequisitionMaterial(
      id: id ?? this.id,
      quantity: quantity ?? this.quantity,
      name: name ?? this.name,
      specificationMaterial: specificationMaterial ?? this.specificationMaterial,
      directoryMaterial: directoryMaterial ?? this.directoryMaterial,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      autor: autor ?? this.autor,
      unit: unit ?? this.unit,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'quantity': quantity,
      'name': name,
      'specificationMaterial': specificationMaterial?.toMap(),
      'directoryMaterial': directoryMaterial?.toMap(),
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
      'autor': autor?.toMap(),
      'unit': unit?.toMap(),
    };
  }

  factory RequisitionMaterial.fromMap(Map<String, dynamic> map) {
    debugPrint("quantity type: ${map['quantity'].runtimeType}");
    return RequisitionMaterial(
      id: map['id'] as String,
      quantity: map['quantity'].toDouble() ,
      //quantity: map['quantity'].toDouble() ,
      name: map['name'] != null ? map['name'] as String : null,
      specificationMaterial: map['specification_material'] != null ? SpecificationMaterial.fromMap(map['specification_material'] as Map<String,dynamic>) : null,
      directoryMaterial: map['directory_material'] != null ? Material.fromMap(map['directory_material'] as Map<String,dynamic>) : null,
      createdAt: DateTime.parse(map['created_at']),
      //updatedAt: map['updatedAt'] != null ? DateTime.parse(map['updated_at']) : null,
      //autor: map['autor'] != null ? Account.fromMap(map['autor'] as Map<String,dynamic>) : null,
      //unit: map['unit'] != null ? Unit.fromMap(map['unit'] as Map<String,dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RequisitionMaterial.fromJson(String source) => RequisitionMaterial.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RequisitionMaterial(id: $id, quantity: $quantity, name: $name, specificationMaterial: $specificationMaterial, directoryMaterial: $directoryMaterial, createdAt: $createdAt, updatedAt: $updatedAt, autor: $autor, unit: $unit)';
  }

  @override
  bool operator ==(covariant RequisitionMaterial other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.quantity == quantity &&
      other.name == name &&
      other.specificationMaterial == specificationMaterial &&
      other.directoryMaterial == directoryMaterial &&
      other.createdAt == createdAt &&
      other.updatedAt == updatedAt &&
      other.autor == autor &&
      other.unit == unit;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      quantity.hashCode ^
      name.hashCode ^
      specificationMaterial.hashCode ^
      directoryMaterial.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      autor.hashCode ^
      unit.hashCode;
  }
}
