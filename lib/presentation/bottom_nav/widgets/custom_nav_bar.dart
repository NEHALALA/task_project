import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_project/config/app_colors.dart';
import 'package:task_project/config/theme/theme_controller.dart';
import 'package:task_project/presentation/bottom_nav/controller/bottom_nav_bar_controller.dart';

class CustomNavBar extends StatelessWidget {
  CustomNavBar({super.key});

  final List<IconData> icons = [
    Icons.home,
    Icons.task,
    Icons.map,
    Icons.person,
  ];

  final controller = Get.find<BottomNavBarController>();
  final ThemeController themeController = ThemeController.instance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: navGroup(),
    );
  }

  Widget navGroup() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(4, (i) {
        return GestureDetector(
          onTap: () => controller.changeTab(i),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Obx(() {
              final isActive = controller.selectedIndex.value == i;
              return Icon(
                icons[i],
                color:
                    isActive
                        ? themeController.iconColor
                        : AppColors.darkerGreyColor,
              );
            }),
          ),
        );
      }),
    );
  }
}
