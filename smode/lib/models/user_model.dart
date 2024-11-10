class UserModel {
  final String? email;
  final String? password;
  final String? token;

  const UserModel({
    this.email,
    this.password,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      UserModel(email: json['email'], token: json['token']);

  UserModel copyWith({
    String? password,
  }) =>
      UserModel(
        email: email,
        password: password ?? this.password,
        token: token,
      );
}
