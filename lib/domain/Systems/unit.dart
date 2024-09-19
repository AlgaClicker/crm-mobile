class Unit {
  final String code;
  final String name;
  final String? title;
  final double? factor;

  Unit({
    required this.code,
    required this.name,
    this.title,
    this.factor,
  });

  factory Unit.fromJson(Map<String, dynamic> json) {
    return Unit(
      code: json['code'] as String,
      name: json['name'] as String,
      title: json['title'] as String?,
      factor:
          json['factor'] != null ? (json['factor'] as num).toDouble() : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'name': name,
      'title': title,
      'factor': factor,
    };
  }

  @override
  String toString() {
    return 'Unit(code: $code, name: $name, title: $title, factor: $factor)';
  }
}
