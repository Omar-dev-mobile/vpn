class AuthModel {
  final String login;
  final String email;
  final bool isGoogleLogin;

  const AuthModel({
    required this.login,
    required this.email,
    required this.isGoogleLogin,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      login: json['login'] ?? '',
      email: json['email'] ?? '',
      isGoogleLogin: json['isGoogleLogin'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'login': login,
      'email': email,
    };
  }
}
