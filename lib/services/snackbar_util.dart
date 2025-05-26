import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:task_project/config/app_colors.dart';
import 'package:task_project/gen/fonts.gen.dart';
import 'package:task_project/presentation/widgets/text_view.dart';

class SnackBarUtil {
  static void showSnackBar({String? message, Duration? duration}) {
    Get.rawSnackbar(
      messageText: TextView(
        text: message?.tr ?? 'Alert',
        textColor: AppColors.primaryLightColor,
        fontFamily: FontFamily.calSans,
        fontSize: 16.sp,
      ),
      duration: duration ?? const Duration(seconds: 2),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.whiteColor,
      margin: EdgeInsets.symmetric(horizontal: 15.w),
      barBlur: 20,
      borderRadius: 20,
      boxShadows: [
        BoxShadow(
          color: AppColors.blackColor.withOpacity(0.2),
          offset: Offset(0, -2),
          blurRadius: 5,
          spreadRadius: 5,
        ),
      ],
    );
  }
}
