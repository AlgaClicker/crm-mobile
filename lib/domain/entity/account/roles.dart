import 'dart:convert';

class Roles {
  final String name;
  final String service;
  Roles({
    required this.name,
    required this.service,
  });


  Roles empty() {
    return Roles(name: 'guest', service: 'guest');
  }

  Roles copyWith({
    String? name,
    String? service,
  }) {
    return Roles(
      name: name ?? this.name,
      service: service ?? this.service,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'service': service,
    };
  }

  factory Roles.fromMap(Map<String, dynamic> map) {
    return Roles(
      name: map['name'] as String,
      service: map['service'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Roles.fromJson(String source) => Roles.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'roles(name: $name, service: $service)';

  @override
  bool operator ==(covariant Roles other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.service == service;
  }

  @override
  int get hashCode => name.hashCode ^ service.hashCode;
}
