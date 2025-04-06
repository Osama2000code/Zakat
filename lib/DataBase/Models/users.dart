class Users {
  final int id;
  final String username;
  final String password;
  final String email;
  final int phonenumber;
  final String roles;

  Users({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.phonenumber,
    required this.roles,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'usernam': username,
      'password': password,
      'email': email,
      'phonenumber': phonenumber,
      'roles': roles,
    };
  }
}
