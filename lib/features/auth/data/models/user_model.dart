import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.email,
    required super.fullName,
    super.otpCode,
    super.accessToken,
    super.refreshToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final userData = json['user'] != null
        ? json['user'] as Map<String, dynamic>
        : json;

    return UserModel(
      id: userData['id'] as int,
      email: userData['email'] as String? ?? '',
      fullName: userData['fullName'] as String? ?? '',
      otpCode: json['otpCode']?.toString(),
      accessToken: json['accessToken'] as String?,
      refreshToken: json['refreshToken'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'user': {'id': id, 'email': email, 'fullName': fullName},
      'otpCode': otpCode,
    };
  }
}
