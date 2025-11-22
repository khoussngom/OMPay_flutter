class AuthDto {
  final String telephone;
  final String password;

  AuthDto({
    required this.telephone,
    required this.password,
  });

  Map<String, String> toJson() {
    return {
      'telephone': telephone,
      'password': password,
    };
  }
}