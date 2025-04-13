class UsersModel {
  late int? id;
  final String username;
  final String password;
  final String email;
  final String phone;
  final String role;
  UsersModel({
    required this.username,
    required this.password,
    required this.email,
    required this.phone,
    this.id,
    required this.role,
  });

  factory UsersModel.fromMap(Map<String, dynamic> maps) => UsersModel(
        id: maps['id'],
        username: maps['username'],
        password: maps['password'],
        email: maps['email'],
        phone: maps['phone'],
        role: maps['role'],
      );
  Map<String, dynamic> toMAp() => {
        'id': id,
        'username': username,
        'password': password,
        'email': email,
        'phone': phone,
        'role': role,
      };
}
