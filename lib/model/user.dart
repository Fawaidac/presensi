class UserModel {
  final String? id;
  final String fullname;
  final String telp;
  final String email;
  final String password;

  const UserModel({
    this.id,
    required this.fullname,
    required this.email,
    required this.telp,
    required this.password,
  });

  toJson() {
    return {
      'fullname': fullname,
      'email': email,
      'password': password,
      'telp': telp
    };
  }
}
