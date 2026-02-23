class UserEntity {
  final int id;
  final String email;
  final String fullName;
  final String? otpCode;
  final String? accessToken;
  final String? refreshToken;

  const UserEntity({
    required this.id,
    required this.email,
    required this.fullName,
    this.otpCode,
    this.accessToken,
    this.refreshToken,
  });
}
