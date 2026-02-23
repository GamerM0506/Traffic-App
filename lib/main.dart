import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'config/routes/app_router.dart';
import 'config/routes/app_routes.dart';
import 'config/theme/app_theme.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/bloc/auth_event.dart';
import 'features/splash/presentation/pages/splash_page.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const TrafficApp());
}

class TrafficApp extends StatelessWidget {
  const TrafficApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.sl<AuthBloc>()..add(AuthCheckStatusRequested()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Traffic Exam',
        theme: AppTheme.lightTheme,
        initialRoute: AppRoutes.splash,
        onGenerateRoute: AppRouter.onGenerateRoute,
        home: const SplashPage(),
      ),
    );
  }
}
