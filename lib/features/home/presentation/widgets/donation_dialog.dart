import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';

class DonationDialog extends StatelessWidget {
  const DonationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Ủng hộ tác giả",
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              "Bạn có thể ủng hộ mình một tách cafe hoặc tùy tâm để duy trì ứng dụng nhé! ❤️",
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/images/qr_code.jpg',
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 200,
                    height: 200,
                    color: Colors.grey[200],
                    child: const Icon(Icons.qr_code_2, size: 50, color: Colors.grey),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(12),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  const Text(
                    "NGÂN HÀNG: TECHCOMBANK",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "STK: 19039733411011",
                    style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "CHỦ TK: LE THANH VINH",
                    style: TextStyle(letterSpacing: 1.1),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                  "Đóng",
                  style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600)
              ),
            ),
          ],
        ),
      ),
    );
  }
}