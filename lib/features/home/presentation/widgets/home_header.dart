import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../auth/domain/entities/user_entity.dart';

class HomeHeader extends StatelessWidget {
  final VoidCallback onDonateTap;
  final VoidCallback onLoginTap;
  final UserEntity? user;

  const HomeHeader({
    super.key,
    required this.onDonateTap,
    required this.onLoginTap,
    this.user,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black.withValues(alpha: 0.4), Colors.transparent],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: onDonateTap,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white54, width: 1),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.favorite, color: Colors.redAccent, size: 20),
                    SizedBox(width: 5),
                    Text(
                      "Ủng hộ",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Text(
                "Ôn Thi GPLX",
                textAlign: TextAlign.center,
                style: textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                ),
              ),
            ),
            ElevatedButton.icon(
              onPressed: onLoginTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: user != null
                    ? Colors.white
                    : AppColors.primary, // Đổi màu nếu đã login
                foregroundColor: user != null
                    ? AppColors.primary
                    : Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                elevation: 4,
              ),
              icon: Icon(
                user != null ? Icons.account_circle : Icons.login,
                size: 20,
              ),
              label: Text(
                user != null
                    ? _getShortName(
                        user!.fullName,
                      )
                    : "Đăng nhập",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getShortName(String fullName) {
    if (fullName.isEmpty) return "User";
    List<String> names = fullName.trim().split(" ");
    return names.isNotEmpty ? names.last : fullName;
  }
}
