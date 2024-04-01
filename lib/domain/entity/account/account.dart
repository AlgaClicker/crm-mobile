import 'package:mobile_alga_crm/domain/entity/account/roles.dart';
import 'package:mobile_alga_crm/domain/entity/directory/workpeople.dart';



class Account {
  final String id;
  final String username;
  final String? password='';
  final String email;
  final Roles? roles;
  final String? active='false';
  final Workpeople? workpeople;
  Account({
    required this.id,
    this.username ='guest',
    this.email='guest@local.local',
    this.roles,
    this.workpeople,
  });
 

  Account copyWith({
    String? id,
    String? username,
    String? email,
    Roles? roles,
    Workpeople? workpeople,
  }) {
    return Account(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      roles: roles ?? this.roles,
      workpeople: workpeople ?? this.workpeople,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'email': email,
      'roles': roles?.toMap(),
      'workpeople': workpeople?.toMap(),
    };
  }

  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      id: map['id'] as String,
      username: map['username'] as String,
      email: map['email']  as String,
      roles: map['roles'] != null ? Roles.fromMap(map['roles'] as Map<String,dynamic>) : null,
      workpeople: map['workpeople'] != null ? Workpeople.fromMap(map['workpeople'] as Map<String,dynamic>) : null,
    );
  }


  @override
  String toString() {
    return 'Account(id: $id, username: $username, email: $email, roles: $roles, workpeople: $workpeople)';
  }

  @override
  bool operator ==(covariant Account other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.username == username &&
      other.email == email &&
      other.roles == roles &&
      other.workpeople == workpeople;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      username.hashCode ^
      email.hashCode ^
      roles.hashCode ^
      workpeople.hashCode;
  }
}
