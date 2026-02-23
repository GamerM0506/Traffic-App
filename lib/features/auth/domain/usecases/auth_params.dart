class LoginParams {
  final String email;
  final String password;

  LoginParams({required this.email, required this.password});
}

class RegisterParams {
  final String name;
  final String email;
  final String password;

  RegisterParams({
    required this.name,
    required this.email,
    required this.password,
  });
}

class VerifyOtpParams {
  final String email;
  final String code;

  VerifyOtpParams({required this.email, required this.code});
}
