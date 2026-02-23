import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/check_auth_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import '../../domain/usecases/verify_otp_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RegisterUseCase _registerUseCase;
  final LoginUseCase _loginUseCase;
  final VerifyOtpUseCase _verifyOtpUseCase;
  final CheckAuthUseCase _checkAuthUseCase;

  AuthBloc({
    required RegisterUseCase registerUseCase,
    required LoginUseCase loginUseCase,
    required VerifyOtpUseCase verifyOtpUseCase,
    required CheckAuthUseCase checkAuthUseCase,
  }) : _registerUseCase = registerUseCase,
       _loginUseCase = loginUseCase,
       _verifyOtpUseCase = verifyOtpUseCase,
       _checkAuthUseCase = checkAuthUseCase,
       super(AuthInitial()) {
    on<AuthRegisterRequested>((event, emit) async {
      emit(AuthLoading());
      final result = await _registerUseCase(event.params);
      result.fold(
        (failure) => emit(AuthFailure(failure.message)),
        (user) => emit(AuthSuccess(user)),
      );
    });

    on<AuthLoginRequested>((event, emit) async {
      emit(AuthLoading());
      final result = await _loginUseCase(event.params);
      result.fold(
        (failure) => emit(AuthFailure(failure.message)),
        (user) => emit(AuthAuthenticated(user)),
      );
    });

    on<AuthVerifyOtpRequested>((event, emit) async {
      emit(AuthLoading());
      final result = await _verifyOtpUseCase(event.params);
      result.fold(
        (failure) => emit(AuthFailure(failure.message)),
        (isSuccess) => emit(AuthInitial()),
      );
    });

    on<AuthCheckStatusRequested>((event, emit) async {
      final result = await _checkAuthUseCase(NoParams());

      result.fold(
        (failure) {
          emit(AuthUnauthenticated());
        },
        (token) {
          if (token != null) {
            try {
              if (JwtDecoder.isExpired(token)) {
                emit(AuthUnauthenticated());
                return;
              }

              Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
              final user = UserEntity(
                id: decodedToken['sub'] ?? decodedToken['id'] ?? 0,
                email: decodedToken['email'] ?? '',
                fullName: decodedToken['fullName'] ?? 'Người dùng',
                accessToken: token,
                refreshToken: null,
              );
              emit(AuthAuthenticated(user));
            } catch (e) {
              emit(AuthUnauthenticated());
            }
          } else {
            emit(AuthUnauthenticated());
          }
        },
      );
    });
  }
}
