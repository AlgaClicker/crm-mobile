// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Profession {
  final String id;
  final String name;
  final String? fullname;
  final String? createdAt;
  Profession({
    required this.id,
    required this.name,
    this.fullname,
    this.createdAt,
  });

  Profession copyWith({
    String? id,
    String? name,
    String? fullname,
    String? createdAt,
  }) {
    return Profession(
      id: id ?? this.id,
      name: name ?? this.name,
      fullname: fullname ?? this.fullname,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'fullname': fullname,
      'created_at': createdAt,
    };
  }

  factory Profession.fromMap(Map<String, dynamic> map) {
    return Profession(
      id: map['id'] as String,
      name: map['name'] as String,
      fullname: map['fullname'] != null ? map['fullname'] as String : null,
      createdAt:
          map['created_at'] != null ? map['created_at'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Profession.fromJson(String source) =>
      Profession.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Profession(id: $id, name: $name, fullname: $fullname, created_at: $createdAt)';
  }

  @override
  bool operator ==(covariant Profession other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.fullname == fullname &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        fullname.hashCode ^
        createdAt.hashCode;
  }
}
