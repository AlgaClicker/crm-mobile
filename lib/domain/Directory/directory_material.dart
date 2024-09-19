import 'package:flutter/material.dart';

class DirectoryMaterial {
  final String id;
  final String name;
  final String? description;
  final String? code;
  final String? vendor;
  final bool isGroup;
  final bool active;
  final DirectoryMaterial? parent;

  DirectoryMaterial({
    required this.id,
    required this.name,
    this.description,
    this.code,
    this.vendor,
    required this.isGroup,
    required this.active,
    this.parent,
  });

  factory DirectoryMaterial.fromJson(Map<String, dynamic> json) {
    debugPrint("DirectoryMaterial.fromJson");
    debugPrint(json.toString());
    return DirectoryMaterial(
      id: json['id'] as String,
      name: json['name'] ?? "" as String?,
      description: json['description'] ?? "" as String?,
      code: json['code'] ?? "" as String?,
      vendor: json['vendor'] ?? "" as String?,
      isGroup: json['isGroup'] ?? "" as bool,
      active: json['active'] as bool,
      parent: json['parent'] != null
          ? DirectoryMaterial.fromJson(json['parent'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'code': code,
      'vendor': vendor,
      'isGroup': isGroup,
      'active': active,
      'parent': parent?.toJson(),
    };
  }

  @override
  String toString() {
    return 'DirectoryMaterial(id: $id, name: $name, description: $description, code: $code, vendor: $vendor, isGroup: $isGroup, active: $active, parent: $parent)';
  }
}
