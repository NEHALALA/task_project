import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarUtil {
  static void show({
    required String message,
    String title = '',
    SnackbarType type = SnackbarType.info,
  }) {
    Color bgColor;
    IconData icon;

    switch (type) {
      case SnackbarType.success:
        bgColor = Colors.green;
        icon = Icons.check_circle;
        break;
      case SnackbarType.error:
        bgColor = Colors.red;
        icon = Icons.error;
        break;
      case SnackbarType.warning:
        bgColor = Colors.orange;
        icon = Icons.warning;
        break;
      case SnackbarType.info:
      default:
        bgColor = Colors.blue;
        icon = Icons.info;
        break;
    }

    Get.snackbar(
      title.isNotEmpty ? title : type.name.capitalize!,
      message,
      backgroundColor: bgColor,
      colorText: Colors.white,
      icon: Icon(icon, color: Colors.white),
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      borderRadius: 10,
      duration: const Duration(seconds: 3),
    );
  }
}

enum SnackbarType { success, error, warning, info }
