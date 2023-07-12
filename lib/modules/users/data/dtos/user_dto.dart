import 'dart:convert';

import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class UserDto {
  final String? id;
  final String name;
  final String registration;
  final bool status;
  final String passwordUpdate;
  final String email;
  final bool emailVerification;
  final String prefs;

  UserDto({
    this.id,
    required this.name,
    required this.registration,
    required this.status,
    required this.passwordUpdate,
    required this.email,
    required this.emailVerification,
    required this.prefs,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'registration': registration,
      'status': status,
      'passwordUpdate': passwordUpdate,
      'email': email,
      'emailVerification': emailVerification,
      'prefs': prefs,
    };
  }

  factory UserDto.fromMap(Map<String, dynamic> map) {
    return UserDto(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] as String,
      registration: map['registration'] as String,
      status: map['status'] as bool,
      passwordUpdate: map['passwordUpdate'] as String,
      email: map['email'] as String,
      emailVerification: map['emailVerification'] as bool,
      prefs: map['prefs'] as String,
    );
  }
  factory UserDto.fromEntity(User entity) {
    return UserDto(
      name: entity.name,
      registration: entity.registration,
      status: entity.status,
      passwordUpdate: entity.passwordUpdate,
      email: entity.email,
      emailVerification: entity.emailVerification,
      prefs: entity.prefs.toString(),
    );
  }

  User toEntity() {
    return User(
      name: name,
      registration: registration,
      status: status,
      passwordUpdate: passwordUpdate,
      email: email,
      emailVerification: emailVerification,
      prefs: json.decode(prefs),
    );
  }
}
