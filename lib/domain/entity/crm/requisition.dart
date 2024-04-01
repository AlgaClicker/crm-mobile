// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'package:mobile_alga_crm/domain/entity/account/account.dart';
import 'package:mobile_alga_crm/domain/entity/crm/requisition_material.dart';
import 'package:mobile_alga_crm/domain/entity/crm/specification.dart';

class Requisition {
  final String id;
  final String number;
  final String status;
  final String? description;
  final DateTime endAt;
  final bool fixed;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final List<RequisitionMaterial>? materials;
  final Specification? specification;
  final Account? autor;
  final Account? manager;
  Requisition({
    required this.id,
    required this.number,
    required this.status,
    required this.endAt,
    required this.fixed,
    required this.createdAt,
    this.updatedAt,
    this.materials,
    this.specification,
    this.autor,
    this.manager,
    this.description
  });

  Requisition copyWith({
    String? id,
    String? number,
    String? status,
    DateTime? endAt,
    bool? fixed,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<RequisitionMaterial>? materials,
    Specification? specification,
    Account? autor,
    Account? manager,
    String? description
  }) {
    return Requisition(
      id: id ?? this.id,
      number: number ?? this.number,
      status: status ?? this.status,
      endAt: endAt ?? this.endAt,
      fixed: fixed ?? this.fixed,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      materials: materials ?? this.materials,
      specification: specification ?? this.specification,
      autor: autor ?? this.autor,
      manager: manager ?? this.manager,
      description:description ?? this.description
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'number': number,
      'status': status,
      'endAt': endAt.millisecondsSinceEpoch,
      'fixed': fixed,
      'description': description,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
      'materials': materials?.map((x) => x.toMap()).toList(),
      'specification': specification?.toMap(),
      'autor': autor?.toMap(),
      'manager': manager?.toMap(),
    };
  }

  factory Requisition.fromMap(Map<String, dynamic> map) {
    return Requisition(
      id: map['id'] as String,
      number: map['number'] as String,
      status: map['status'] as String,
      description: map['description'] != null ? map['description'] as String : null,
      endAt: DateTime.parse(map['end_at']),
      fixed: map['fixed'] as bool,
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: map['updated_at'] != null ? DateTime.parse(map['updated_at']) : null,
      materials: map['materials'] != null ? List<RequisitionMaterial>.from((map['materials'] as List<dynamic>).map<RequisitionMaterial?>((x) => RequisitionMaterial.fromMap(x as Map<String,dynamic>),),) : null,
      specification: map['specification'] != null ? Specification.fromMap(map['specification'] as Map<String,dynamic>) : null,
      autor: map['autor'] != null ? Account.fromMap(map['autor'] as Map<String,dynamic>) : null,
      manager: map['manager'] != null ? Account.fromMap(map['manager'] as Map<String,dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Requisition.fromJson(String source) => Requisition.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Requisition(id: $id, number: $number, status: $status, endAt: $endAt, fixed: $fixed, createdAt: $createdAt, updatedAt: $updatedAt, materials: $materials, specification: $specification, autor: $autor, manager: $manager)';
  }

  @override
  bool operator ==(covariant Requisition other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.number == number &&
      other.status == status &&
      other.endAt == endAt &&
      other.fixed == fixed &&
      other.createdAt == createdAt &&
      other.updatedAt == updatedAt &&
      listEquals(other.materials, materials) &&
      other.specification == specification &&
      other.autor == autor &&
      other.manager == manager;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      number.hashCode ^
      status.hashCode ^
      endAt.hashCode ^
      fixed.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      materials.hashCode ^
      specification.hashCode ^
      autor.hashCode ^
      manager.hashCode;
  }
}
