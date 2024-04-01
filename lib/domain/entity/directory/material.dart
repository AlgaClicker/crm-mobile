// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Material {
  final String id;
  final String name;
  final String code='';
  final String vendor='';
  final bool? isGroup;
  final String? description;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final Material? parent;
  Material({
    required this.id,
    required this.name,
    this.isGroup,
    this.description,
    required this.createdAt,
    this.updatedAt,
    this.parent,
  });

  Material copyWith({
    String? id,
    String? name,
    bool? isGroup,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
    Material? parent,
  }) {
    return Material(
      id: id ?? this.id,
      name: name ?? this.name,
      isGroup: isGroup ?? this.isGroup,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      parent: parent ?? this.parent,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'isGroup': isGroup,
      'description': description,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
      'parent': parent?.toMap(),
    };
  }

  factory Material.fromMap(Map<String, dynamic> map) {
    return Material(
      id: map['id'] as String,
      name: map['name'] as String,
      isGroup: map['is_group'] != null ? map['is_group'] as bool : null,
      description: map['description'] != null ? map['description'] as String : null,
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: map['updated_at'] != null ? DateTime.parse(map['updated_at']) : null,
      parent: map['parent'] != null ? Material.fromMap(map['parent'] as Map<String,dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Material.fromJson(String source) => Material.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Material(id: $id, name: $name, isGroup: $isGroup, description: $description, createdAt: $createdAt, updatedAt: $updatedAt, parent: $parent)';
  }

  @override
  bool operator ==(covariant Material other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.isGroup == isGroup &&
      other.description == description &&
      other.createdAt == createdAt &&
      other.updatedAt == updatedAt &&
      other.parent == parent;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      isGroup.hashCode ^
      description.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      parent.hashCode;
  }
}
