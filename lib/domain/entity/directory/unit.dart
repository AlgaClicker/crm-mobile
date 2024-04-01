// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Unit {
  final String code;
  final String name;
  final String title;
  Unit({
    required this.code,
    required this.name,
    required this.title,
  });

  Unit copyWith({
    String? code,
    String? name,
    String? title,
  }) {
    return Unit(
      code: code ?? this.code,
      name: name ?? this.name,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code': code,
      'name': name,
      'title': title,
    };
  }

  factory Unit.fromMap(Map<String, dynamic> map) {
    return Unit(
      code: map['code'] as String,
      name: map['name'] as String,
      title: map['title'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Unit.fromJson(String source) => Unit.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Unit(code: $code, name: $name, title: $title)';

  @override
  bool operator ==(covariant Unit other) {
    if (identical(this, other)) return true;
  
    return 
      other.code == code &&
      other.name == name &&
      other.title == title;
  }

  @override
  int get hashCode => code.hashCode ^ name.hashCode ^ title.hashCode;
}
