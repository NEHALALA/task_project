import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_project/gen/assets.gen.dart';
import 'package:task_project/gen/fonts.gen.dart';
import 'package:task_project/imports.dart';
import 'package:task_project/presentation/signup/controller/signup_controller.dart';
import 'package:task_project/presentation/widgets/form_textfiled.dart';
import 'package:task_project/routes/route_const.dart';

class SignupView extends GetView<SignupController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.r),
        child: ListView(
          children: [
            SizedBox(height: 60.h),
            Align(
              alignment: Alignment.center,
              child: TextView(
                text: Strings.signUp,
                fontSize: 20.sp,
                fontFamily: FontFamily.calSans,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: TextView(
                text: Strings.signupSubtitle,
                fontSize: 14.sp,
                textColor: AppColors.textPrimaryLightColor,
                fontFamily: FontFamily.calSans,
              ),
            ),
            SizedBox(height: 20.h),
            Obx(
              () => CircleAvatar(
                radius: 45.r,
                backgroundImage:
                    controller.isSelectedImage.value
                        ? FileImage(controller.selectedImage.value!)
                        : $AssetsImagesGen().profile.image().image,
              ),
            ),
            SizedBox(height: 10.h),
            GestureDetector(
              onTap: () {
                controller.pickImage();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextView(text: "Add Image", fontFamily: FontFamily.calSans),
                  SizedBox(width: 2.w),
                  Icon(Icons.edit, color: AppColors.blueColor),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                Expanded(
                  child: FormTextfiledWidget(
                    labelText: "First Name",
                    controller: controller.firstNameController,
                    hintText: "John",
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: FormTextfiledWidget(
                    labelText: "Last Name",
                    controller: controller.lastNameController,
                    hintText: "Doe",
                  ),
                ),
              ],
            ),
            SizedBox(height: 14.h),
            FormTextfiledWidget(
              labelText: "Email",
              controller: controller.emailController,
              hintText: "Enter your Email",
            ),
            SizedBox(height: 14.h),
            Obx(
              () => FormTextfiledWidget(
                isSuffix: true,
                isobsecure: controller.isPasswordVisible.value,
                labelText: "Password",
                controller: controller.passwordController,
                hintText: "Enter your password",
                suffix: IconButton(
                  onPressed: () => controller.isPasswordVisible.toggle(),
                  icon: Icon(
                    controller.isPasswordVisible.value
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Obx(
              () => FormTextfiledWidget(
                isSuffix: true,
                isobsecure: controller.isConfirmPasswordVisible.value,
                labelText: "Confirm Password",
                controller: controller.confirmPasswordController,
                hintText: "Confirm your password",
                suffix: IconButton(
                  onPressed: () => controller.isConfirmPasswordVisible.toggle(),
                  icon: Icon(
                    controller.isConfirmPasswordVisible.value
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            SizedBox(
              height: 50.h,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.blueColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: () {
                  controller.singup();
                },
                child: TextView(
                  text: "Signup",
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: FontFamily.calSans,
                  textColor: AppColors.blackColor,
                ),
              ),
            ),
            SizedBox(height: 26.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextView(
                  text: "Already have an account?",
                  fontFamily: FontFamily.calSans,
                ),
                SizedBox(width: 3.w),
                GestureDetector(
                  onTap: () => Get.offAllNamed(RouteConst.login),
                  child: TextView(
                    text: "Login",
                    fontSize: 14.sp,
                    fontFamily: FontFamily.calSans,
                    textColor: AppColors.blueColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
