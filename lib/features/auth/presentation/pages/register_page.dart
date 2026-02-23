import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../auth/domain/usecases/auth_params.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../../../../config/theme/app_colors.dart';
import '../widgets/auth_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isAccepted = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.pushNamed(
              context,
              AppRoutes.otp,
              arguments: {
                'email': state.user.email,
                'otpCode': state.user.otpCode,
              },
            );
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25.0,
                  vertical: 10.0,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Tạo tài khoản mới",
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                      ),
                      const SizedBox(height: 40),
                      AuthField(
                        controller: nameController,
                        hintText: "Họ và tên thật",
                        icon: Icons.person_outline,
                        validator: (val) {
                          if (val == null || val.isEmpty)
                            return "Vui lòng nhập họ tên";
                          if (val.length < 2) return "Tên quá ngắn";
                          return null;
                        },
                      ),
                      const SizedBox(height: 18),
                      AuthField(
                        controller: emailController,
                        hintText: "Địa chỉ Email",
                        icon: Icons.email_outlined,
                        validator: (val) {
                          if (val == null || val.isEmpty)
                            return "Vui lòng nhập Email";
                          final emailRegex = RegExp(
                            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                          );
                          if (!emailRegex.hasMatch(val))
                            return "Email không hợp lệ";
                          return null;
                        },
                      ),
                      const SizedBox(height: 18),
                      AuthField(
                        controller: passwordController,
                        hintText: "Mật khẩu",
                        icon: Icons.lock_outline,
                        isPassword: true,
                        validator: (val) {
                          if (val == null || val.isEmpty)
                            return "Vui lòng nhập mật khẩu";
                          if (val.length < 6)
                            return "Mật khẩu phải trên 6 ký tự";
                          return null;
                        },
                      ),
                      const SizedBox(height: 18),
                      AuthField(
                        controller: confirmPasswordController,
                        hintText: "Xác nhận mật khẩu",
                        icon: Icons.lock_reset,
                        isPassword: true,
                        validator: (val) {
                          if (val == null || val.isEmpty)
                            return "Vui lòng nhập lại mật khẩu";
                          if (val != passwordController.text) {
                            return "Mật khẩu không khớp";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Checkbox(
                            value: isAccepted,
                            activeColor: AppColors.primary,
                            onChanged: (val) =>
                                setState(() => isAccepted = val!),
                          ),
                          const Expanded(
                            child: Text(
                              "Tôi đồng ý với Điều khoản & Chính sách",
                              style: TextStyle(fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 35),
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: (isAccepted && state is! AuthLoading)
                              ? () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<AuthBloc>().add(
                                      AuthRegisterRequested(
                                        RegisterParams(
                                          name: nameController.text,
                                          email: emailController.text,
                                          password: passwordController.text,
                                        ),
                                      ),
                                    );
                                  }
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: state is AuthLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  "ĐĂNG KÝ NGAY",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
