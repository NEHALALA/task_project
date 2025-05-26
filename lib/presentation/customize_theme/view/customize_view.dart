import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_project/config/theme/theme_controller.dart';
import 'package:task_project/gen/fonts.gen.dart';
import 'package:task_project/imports.dart';
import 'package:task_project/presentation/customize_theme/controller/customize_controller.dart';
import 'package:task_project/presentation/customize_theme/widgets/color_button.dart';

class CustomizeThemeView extends GetView<CustomizeThemeController> {
  final ThemeController themeController = ThemeController.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Obx(
          () => IconButton(
            color: themeController.iconColor,
            onPressed: () => Get.back(),
            icon: Icon(Icons.arrow_back_ios),
          ),
        ),
        title: TextView(
          text: "Customize",
          fontFamily: FontFamily.calSans,
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextView(
                    text: "Theme",
                    fontFamily: FontFamily.calSans,
                    fontSize: 14.sp,
                  ),
                  Obx(
                    () => TextView(
                      text: themeController.isDarkMode.value ? "Dark" : "Light",
                      fontFamily: FontFamily.calSans,
                      fontSize: 14.sp,
                      textColor: AppColors.darkerGreyColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Obx(
                () => SwitchListTile(
                  activeTrackColor: themeController.iconColor,
                  title: TextView(
                    text: "Ultra Dark Theme",
                    fontFamily: FontFamily.calSans,
                    fontSize: 14.sp,
                  ),
                  subtitle: TextView(
                    text: "The ultimate dark theme appearance",
                    fontFamily: FontFamily.calSans,
                    fontSize: 14.sp,
                    textColor: AppColors.darkerGreyColor,
                  ),
                  value: themeController.isDarkMode.value,
                  onChanged: themeController.toggleDarkMode,
                ),
              ),
              SizedBox(height: 15.h),
              Text(
                'Select Accent colors',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: List.generate(
                  ThemeController.colors.length,
                  (index) => ColorButton(
                    color: ThemeController.colors[index],
                    index: index,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
