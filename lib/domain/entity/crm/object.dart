// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Object {
  final String id;
  final String name;
  final String? address;
  Object({
    required this.id,
    required this.name,
    this.address='',
  });
  

  Object copyWith({
    String? id,
    String? name,
    String? address,
  }) {
    return Object(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'address': address,
    };
  }

  factory Object.fromMap(Map<String, dynamic> map) {
    return Object(
      id: map['id'] as String,
      name: map['name'] as String,
      address: map['address'] != null ? map['address'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Object.fromJson(String source) => Object.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Object(id: $id, name: $name, address: $address)';

  @override
  bool operator ==(covariant Object other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.address == address;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ address.hashCode;
}
