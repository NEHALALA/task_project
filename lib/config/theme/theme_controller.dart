import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:task_project/config/app_colors.dart';

class ThemeController extends GetxController {
  static ThemeController get instance => Get.find();

  final _box = GetStorage();
  final _key = 'themeData';

  final Rx<bool> isDarkMode = false.obs;
  final Rx<int> selectedColorIndex = 0.obs;
  final Rx<String> categoryStyle = 'CLASSIC'.obs;

  static final List<Color> colors = [
    AppColors.redColor,
    AppColors.yellowColor,
    AppColors.blueColor,
    AppColors.purpleColor,
  ];

  ThemeController() {
    loadThemeData();
  }

  void loadThemeData() {
    final data = _box.read(_key);
    if (data != null) {
      isDarkMode.value = data['isDarkMode'] ?? false;
      selectedColorIndex.value = data['colorIndex'] ?? 0;
      categoryStyle.value = data['categoryStyle'] ?? 'CLASSIC';
    }
  }

  void saveThemeData() {
    _box.write(_key, {
      'isDarkMode': isDarkMode.value,
      'colorIndex': selectedColorIndex.value,
      'categoryStyle': categoryStyle.value,
    });
  }

  void toggleDarkMode(bool value) {
    isDarkMode.value = value;
    saveThemeData();
    Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
  }

  void setColorIndex(int index) {
    selectedColorIndex.value = index;
    saveThemeData();
  }

  void setCategoryStyle(String style) {
    categoryStyle.value = style;
    saveThemeData();
  }

  Color get primaryColor => colors[selectedColorIndex.value];

  // Optional: alias for icon color
  Color get iconColor => primaryColor;
}
