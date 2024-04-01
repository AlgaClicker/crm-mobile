// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:mobile_alga_crm/domain/entity/account/account.dart';

class Specification {
  final String id;
  final String name;
  final DateTime? createdAt;
  final String? objectId;
  final String? objectName;
  final String? description;
  final List<Account>? responsibles;
  Specification({
    required this.id,
    required this.name,
    this.createdAt,
    this.objectId,
    this.objectName,
    this.description,
    this.responsibles,
  });
  

  Specification copyWith({
    String? id,
    String? name,
    DateTime? createdAt,
    String? objectId,
    String? objectName,
    String? description,
    List<Account>? responsibles,
  }) {
    return Specification(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      objectId: objectId ?? this.objectId,
      objectName: objectName ?? this.objectName,
      description: description ?? this.description,
      responsibles: responsibles ?? this.responsibles,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'objectId': objectId,
      'objectName': objectName,
      'description': description,
      'responsibles': responsibles?.map((x) => x.toMap()).toList(),
    };
  }

  factory Specification.fromMap(Map<String, dynamic> map) {
    return Specification(
      id: map['id'] as String,
      name: map['name'] as String,
      createdAt: map['created_at'] != null ? DateTime.parse(map['created_at']) : null,
      objectId: map['objectId'] != null ? map['objectId'] as String : null,
      objectName: map['objectName'] != null ? map['objectName'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
      responsibles: map['responsibles'] != [] ? List<Account>.from((map['responsibles'] as List<dynamic>).map<Account?>((x) => Account.fromMap(x as Map<String,dynamic>),),) : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory Specification.fromJson(String source) => Specification.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Specification(id: $id, name: $name, createdAt: $createdAt, objectId: $objectId, objectName: $objectName, description: $description, responsibles: $responsibles)';
  }

  @override
  bool operator ==(covariant Specification other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.createdAt == createdAt &&
      other.objectId == objectId &&
      other.objectName == objectName &&
      other.description == description &&
      listEquals(other.responsibles, responsibles);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      createdAt.hashCode ^
      objectId.hashCode ^
      objectName.hashCode ^
      description.hashCode ^
      responsibles.hashCode;
  }
}
