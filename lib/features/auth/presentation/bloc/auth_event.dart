import '../../domain/usecases/auth_params.dart';

abstract class AuthEvent {}

class AuthRegisterRequested extends AuthEvent {
  final RegisterParams params;
  AuthRegisterRequested(this.params);
}

class AuthLoginRequested extends AuthEvent {
  final LoginParams params;
  AuthLoginRequested(this.params);
}

class AuthVerifyOtpRequested extends AuthEvent {
  final VerifyOtpParams params;
  AuthVerifyOtpRequested(this.params);
}

class AuthCheckStatusRequested extends AuthEvent {}