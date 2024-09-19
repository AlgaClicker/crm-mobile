class Role {
  final String name;
  final String service;

  Role({
    required this.name,
    required this.service,
  });

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      name: json['name'] as String,
      service: json['service'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'service': service,
    };
  }
}
