class Objects {
  final String id;
  final String name;
  final String address;

  Objects({
    required this.id,
    required this.name,
    required this.address,
  });

  factory Objects.fromJson(Map<String, dynamic> json) {
    return Objects(
      id: json['id'],
      name: json['name'],
      address: json['address'],
    );
  }
}
