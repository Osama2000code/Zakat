import 'package:flutter/foundation.dart';

class UsersModel {
  late int? id;
  late String username;
  late String password;
  late Uint8List? image;
  late String email;
  late String phone;
  late String? role;
  UsersModel(
      {this.image,
      this.id,
      this.role,
      required this.username,
      required this.password,
      required this.email,
      required this.phone});

  factory UsersModel.fromMap(Map<String, dynamic> maps) => UsersModel(
        id: maps['id'],
        username: maps['username'],
        password: maps['password'],
        image: maps['image'],
        email: maps['email'],
        phone: maps['phone'],
        role: maps['role'],
      );
  Map<String, dynamic> toMAp() => {
        'id': id,
        'username': username,
        'password': password,
        'image': image,
        'email': email,
        'phone': phone,
        'role': role,
      };
}
