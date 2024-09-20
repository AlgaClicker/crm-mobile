import 'package:flutter/material.dart';
import 'package:mobile_app/Domain/Account/Roles.dart';

import '../Company/workpeople.dart'; // Импортируем Workpeople

class Account {
  final String id;
  final String username;
  final String email;
  final Role role;
  final bool active;
  final String? createdAt;
  final Workpeople? workpeople;

  Account({
    required this.id,
    required this.username,
    required this.email,
    required this.role,
    required this.active,
    this.createdAt,
    this.workpeople,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    debugPrint("Account.fromJson");
    debugPrint(json.toString());
    
    return Account(
      id: json['id'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      role: Role.fromJson(json['roles'] as Map<String, dynamic>),
      active: json['active'] as bool,
      createdAt: json['created_at'] as String?,
      workpeople: json['workpeople'] != null
          ? Workpeople.fromMap(json['workpeople'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'roles': role.toJson(),
      'active': active,
      'created_at': createdAt,
      'workpeople': workpeople?.toMap(),
    };
  }
}
