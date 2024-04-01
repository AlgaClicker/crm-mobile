import 'dart:convert';
import 'package:mobile_alga_crm/domain/entity/directory/profession.dart';

class Workpeople {
  final String id;
  final String name;
  final String surname;
  final String? patronymic;
  final String? phoneNumber;
  final String? tabelNumber;
  final Profession? profession;
  Workpeople({
    required this.id,
    required this.name,
    required this.surname,
    this.patronymic,
    this.phoneNumber,
    this.tabelNumber,
    this.profession,
  });

  Workpeople copyWith({
    String? id,
    String? name,
    String? surname,
    String? patronymic,
    String? phoneNumber,
    String? tabelNumber,
    Profession? profession,
  }) {
    return Workpeople(
      id: id ?? this.id,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      patronymic: patronymic ?? this.patronymic,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      tabelNumber: tabelNumber ?? this.tabelNumber,
      profession: profession ?? this.profession,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'surname': surname,
      'patronymic': patronymic,
      'phone_number': phoneNumber,
      'tabel_number': tabelNumber,
      'profession': profession?.toMap(),
    };
  }

  factory Workpeople.fromMap(Map<String, dynamic> map) {
    return Workpeople(
      id: map['id'] as String,
      name: map['name'] as String,
      surname: map['surname'] as String,
      patronymic: map['patronymic'] != null ? map['patronymic'] as String : null,
      phoneNumber: map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      tabelNumber: map['tabelNumber'] != null ? map['tabelNumber'] as String : null,
      profession: map['profession'] != null ? Profession.fromMap(map['profession'] as Map<String,dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Workpeople.fromJson(String source) => Workpeople.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Workpeople(id: $id, name: $name, surname: $surname, patronymic: $patronymic, phoneNumber: $phoneNumber, tabelNumber: $tabelNumber, profession: $profession)';
  }

  @override
  bool operator ==(covariant Workpeople other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.surname == surname &&
      other.patronymic == patronymic &&
      other.phoneNumber == phoneNumber &&
      other.tabelNumber == tabelNumber &&
      other.profession == profession;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      surname.hashCode ^
      patronymic.hashCode ^
      phoneNumber.hashCode ^
      tabelNumber.hashCode ^
      profession.hashCode;
  }
}
