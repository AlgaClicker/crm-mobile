// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:mobile_alga_crm/domain/entity/directory/unit.dart';

class SpecificationMaterial {
  final String id;
  final String fullname;
  final String? position;
  final String? description;
  final double? quantity;
  final String? vendor;
  final String? code;
  final DateTime? createdAt;
  final Unit? unit;
  SpecificationMaterial({
    required this.id,
    required this.fullname,
    this.position,
    this.description,
    this.quantity,
    this.vendor,
    this.code,
    this.createdAt,
    this.unit,
  });


  SpecificationMaterial copyWith({
    String? id,
    String? fullname,
    String? position,
    String? description,
    double? quantity,
    String? vendor,
    String? code,
    DateTime? createdAt,
    Unit? unit,
  }) {
    return SpecificationMaterial(
      id: id ?? this.id,
      fullname: fullname ?? this.fullname,
      position: position ?? this.position,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      vendor: vendor ?? this.vendor,
      code: code ?? this.code,
      createdAt: createdAt ?? this.createdAt,
      unit: unit ?? this.unit,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fullname': fullname,
      'position': position,
      'description': description,
      'quantity': quantity,
      'vendor': vendor,
      'code': code,
      'created_at': createdAt?.millisecondsSinceEpoch,
      'unit': unit?.toMap(),
    };
  }

  factory SpecificationMaterial.fromMap(Map<String, dynamic> map) {
    return SpecificationMaterial(
      id: map['id'] as String,
      fullname: map['fullname'] as String,
      position: map['position'] != null ? map['position'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
      quantity: map['quantity'].toDouble(),
      vendor: map['vendor'] != null ? map['vendor'] as String : null,
      code: map['code'] != null ? map['code'] as String : null,
      createdAt: map['createdAt'] != null ? DateTime.parse(map['created_at']) : null,
      unit: map['unit'] != null ? Unit.fromMap(map['unit'] as Map<String,dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SpecificationMaterial.fromJson(String source) => SpecificationMaterial.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SpecificationMaterial(id: $id, fullname: $fullname, position: $position, description: $description, quantity: $quantity, vendor: $vendor, code: $code, createdAt: $createdAt, unit: $unit)';
  }

  @override
  bool operator ==(covariant SpecificationMaterial other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.fullname == fullname &&
      other.position == position &&
      other.description == description &&
      other.quantity == quantity &&
      other.vendor == vendor &&
      other.code == code &&
      other.createdAt == createdAt &&
      other.unit == unit;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      fullname.hashCode ^
      position.hashCode ^
      description.hashCode ^
      quantity.hashCode ^
      vendor.hashCode ^
      code.hashCode ^
      createdAt.hashCode ^
      unit.hashCode;
  }
}
