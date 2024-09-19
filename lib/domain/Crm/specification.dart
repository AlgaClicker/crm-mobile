import 'package:flutter/widgets.dart';

class Specification {
  final String id;
  final String name;
  final String? description;

  Specification({
    required this.id,
    required this.name,
    this.description,
  });

  factory Specification.fromJson(Map<String, dynamic> json) {
    debugPrint("Specification.fromJson");
    debugPrint(json.toString());
    return Specification(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] ?? '' as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description ?? '',
    };
  }
}
