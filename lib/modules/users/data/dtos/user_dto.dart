import 'dart:convert';

import 'package:dashboard_manga_easy/modules/users/domain/entities/user.dart';

class UserDto {
  final String? id;
  final String name;
  final String registration;
  final bool status;
  final String email;
  final bool emailVerification;
  final String prefs;

  UserDto({
    this.id,
    required this.name,
    required this.registration,
    required this.status,
    required this.email,
    required this.emailVerification,
    required this.prefs,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': id,
      'name': name,
      'registration': registration,
      'status': status,
      'email': email,
      'emailVerification': emailVerification,
      'prefs': prefs,
    };
  }

  factory UserDto.fromMap(Map<String, dynamic> map) {
    return UserDto(
      id: map['uid'],
      name: map['name'],
      registration: map['registration'],
      status: map['status'],
      email: map['email'],
      emailVerification: map['emailverification'],
      prefs: map['prefs'],
    );
  }
  factory UserDto.fromEntity(User entity) {
    return UserDto(
      id: entity.id,
      name: entity.name,
      registration: entity.registration,
      status: entity.status,
      email: entity.email,
      emailVerification: entity.emailVerification,
      prefs: entity.prefs.toString(),
    );
  }

  User toEntity() {
    return User(
      id: id,
      name: name,
      registration: registration,
      status: status,
      passwordUpdate: '',
      email: email,
      emailVerification: emailVerification,
      prefs: Prefs.fromJson(json.decode(prefs)),
    );
  }
}
