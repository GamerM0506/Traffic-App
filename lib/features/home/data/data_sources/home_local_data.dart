import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';
import '../../domain/entities/menu_item.dart';
import '../../../../config/routes/app_routes.dart';

class HomeLocalData {
  static List<MenuItem> get menuItems => [
    MenuItem(
      title: "Đề ngẫu nhiên",
      icon: Icons.school,
      color: AppColors.menuRandom,
      route: AppRoutes.license,
    ),
    MenuItem(
      title: "Thi theo bộ đề",
      icon: Icons.laptop,
      color: AppColors.menuExam,
      route: AppRoutes.license,
    ),
    MenuItem(
      title: "Các câu bị sai",
      icon: Icons.person_search,
      color: AppColors.menuWrong,
    ),
    MenuItem(
      title: "Ôn tập câu hỏi",
      icon: Icons.menu_book,
      color: AppColors.menuReview,
    ),
    MenuItem(
      title: "Các biển báo",
      icon: Icons.directions_car,
      color: AppColors.menuSigns,
      route: AppRoutes.trafficSign
    ),
    MenuItem(
      title: "Mẹo ghi nhớ",
      icon: Icons.tips_and_updates,
      color: AppColors.menuTips,
    ),
    MenuItem(
      title: "60 câu điểm liệt",
      icon: Icons.warning_amber,
      color: AppColors.menuWarning,
    ),
    MenuItem(
      title: "Top 50 câu sai",
      icon: Icons.assignment_late,
      color: AppColors.menuTop50,
    ),
  ];
}
