import 'dart:io';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_project/gen/assets.gen.dart';
import 'package:task_project/gen/fonts.gen.dart';
import 'package:task_project/imports.dart';
import 'package:task_project/presentation/profile/controller/profile_controller.dart';
import 'package:task_project/routes/route_const.dart';
import 'package:task_project/services/local_storage.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TextView(
          text: "Profile",
          fontFamily: FontFamily.calSans,
          fontWeight: FontWeight.w400,
          fontSize: 28.sp,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20.h),
            // ignore: unnecessary_null_comparison
            Obx(() {
              return CircleAvatar(
                radius: 50.r,
                backgroundColor: Colors.grey[300],
                backgroundImage:
                    controller.selectedImage.value != null
                        ? FileImage(controller.selectedImage.value!)
                        : $AssetsImagesGen().profile.provider(),
              );
            }),
            SizedBox(height: 10.h),
            TextView(
              text: controller.fullName.value,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: 20.h),
            ListTile(
              onTap: () => Get.toNamed(RouteConst.customizeTheme),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              tileColor: AppColors.colorCC7B2A,
              title: TextView(text: 'Customize App Theme', fontSize: 14.sp),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                LocalStorage.instance.remove("userId");
                LocalStorage.instance.remove("userProfileImage");
                Get.offAllNamed(RouteConst.login);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.logout, color: AppColors.redColor),
                  SizedBox(width: 5.w),
                  TextView(
                    text: "Logout",
                    fontFamily: FontFamily.calSans,
                    textColor: AppColors.redColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
