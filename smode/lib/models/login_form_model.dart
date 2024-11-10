class LoginFormModel {
  final String? email;
  final String? password;

  const LoginFormModel({
    this.email, 
    this.password,
  });

  Map<String, dynamic> toJson() => {
      'email': email,
      'password': password,
  };
}