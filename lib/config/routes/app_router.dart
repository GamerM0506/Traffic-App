import 'package:flutter/material.dart';
import 'package:traffic_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:traffic_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:traffic_app/features/license/presentation/pages/license_selection_page.dart';
import '../../features/auth/presentation/pages/otp_page.dart';
import '../../features/exam/presentation/pages/exam_detail_page.dart';
import '../../features/exam/presentation/pages/exam_list_page.dart';
import '../../features/traffic_sign/presentation/pages/traffic_sign_page.dart';
import '../../injection_container.dart';
import 'app_routes.dart';
import '../../../features/splash/presentation/pages/splash_page.dart';
import '../../../features/home/presentation/pages/home_page.dart';
import '../../../features/auth/presentation/pages/login_page.dart';
import '../../../features/auth/presentation/pages/register_page.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashPage());

      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomePage());

      case AppRoutes.login:
        final authState = sl<AuthBloc>().state;
        if (authState is AuthAuthenticated) {
          return MaterialPageRoute(builder: (_) => const HomePage());
        }
        return MaterialPageRoute(builder: (_) => const LoginPage());

      case AppRoutes.register:
        return MaterialPageRoute(builder: (_) => const RegisterPage());

      case AppRoutes.otp:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) =>
              OtpPage(email: args['email'], otpCode: args['otpCode']),
        );

      case AppRoutes.license:
        return MaterialPageRoute(
          builder: (_) => const LicenseSelectionPage(),
          settings: settings,
        );

      case AppRoutes.examList:
        final args = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => ExamListPage(licenseType: args),
        );

      case AppRoutes.doExam:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => DoExamPage(
            examId: args['id'],
            licenseType: args['type'],
            isRandom: args['isRandom'] ?? false,
          ),
        );

      case AppRoutes.trafficSign:
        return MaterialPageRoute(builder: (_) => const TrafficSignPage());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('Không tìm thấy trang: ${settings.name}')),
          ),
        );
    }
  }
}
