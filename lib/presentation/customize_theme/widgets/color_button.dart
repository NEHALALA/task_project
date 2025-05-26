import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_project/config/app_colors.dart';
import 'package:task_project/config/theme/theme_controller.dart';

class ColorButton extends StatelessWidget {
  final Color color;
  final int index;

  ColorButton({required this.color, required this.index});

  @override
  Widget build(BuildContext context) {
    final ThemeController controller = ThemeController.instance;
    return Obx(
      () => GestureDetector(
        onTap: () => controller.setColorIndex(index),
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(
              color:
                  controller.selectedColorIndex.value == index
                      ? (controller.isDarkMode.value
                          ? AppColors.whiteColor
                          : AppColors.blackColor)
                      : Colors.transparent,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}
