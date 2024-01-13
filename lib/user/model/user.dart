import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class DatabaseUser {
  final String id;
  final String name;
  final String surname;
  final String email;
  final String hashedPassword;
  final String phone;
  final String tckn;
  final String birthday;
  final String serial;
  final String validUntil;
  final int passwordTry;
  final int type;
  DatabaseUser({
    required this.id,
    required this.name,
    required this.surname,
    required this.email,
    required this.hashedPassword,
    required this.phone,
    required this.tckn,
    required this.birthday,
    required this.serial,
    required this.validUntil,
    required this.passwordTry,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'surname': surname,
      'email': email,
      'hashedPassword': hashedPassword,
      'phone': phone,
      'tckn': tckn,
      'birthday': birthday,
      'serial': serial,
      'validUntil': validUntil,
      'passwordTry': passwordTry,
      'type': type,
    };
  }

  factory DatabaseUser.fromMap(Map<String, dynamic> map) {
    return DatabaseUser(
      id: map['id'] as String,
      name: map['name'] as String,
      surname: map['surname'] as String,
      email: map['email'] as String,
      hashedPassword: map['password'] as String,
      phone: map['phone'] as String,
      tckn: map['tckn'] as String,
      birthday: map['birthday'] as String,
      serial: map['serial'] as String,
      validUntil: map['validuntil'] as String,
      passwordTry: map['passwordtry'] as int,
      type: map['type'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory DatabaseUser.fromJson(String source) => DatabaseUser.fromMap(json.decode(source) as Map<String, dynamic>);
}
