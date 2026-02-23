import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final IconData icon;
  final Color color;
  final String? route;

  MenuItem({
    required this.title,
    required this.icon,
    required this.color,
    this.route,
  });
}
