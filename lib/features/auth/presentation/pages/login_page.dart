import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/theme/app_colors.dart';
// import '../../../../injection_container.dart'; // Bỏ dòng này vì không dùng sl() ở đây nữa
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../../domain/usecases/auth_params.dart';
import '../../../../config/routes/app_routes.dart';
import '../widgets/auth_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.home,
              (route) => false,
            );
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(25.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Chào mừng trở lại!",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 40),
                  AuthField(
                    controller: emailController,
                    hintText: "Email",
                    icon: Icons.email_outlined,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Vui lòng nhập Email";
                      }
                      final emailRegex = RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      );
                      if (!emailRegex.hasMatch(val)) {
                        return "Email không hợp lệ";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  AuthField(
                    controller: passwordController,
                    hintText: "Mật khẩu",
                    icon: Icons.lock_outline,
                    isPassword: true,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Vui lòng nhập mật khẩu";
                      }
                      if (val.length < 6) return "Mật khẩu quá ngắn";
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: state is AuthLoading
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                context.read<AuthBloc>().add(
                                  AuthLoginRequested(
                                    LoginParams(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    ),
                                  ),
                                );
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                      ),
                      child: state is AuthLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              "ĐĂNG NHẬP",
                              style: TextStyle(color: Colors.white),
                            ),
                    ),
                  ),

                  TextButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, AppRoutes.register),
                    child: const Text("Chưa có tài khoản? Đăng ký ngay"),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
