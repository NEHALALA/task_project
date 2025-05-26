import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_project/gen/assets.gen.dart';
import 'package:task_project/gen/fonts.gen.dart';
import 'package:task_project/imports.dart';
import 'package:task_project/presentation/login/controller/login_controller.dart';
import 'package:task_project/presentation/widgets/form_textfiled.dart';
import 'package:task_project/routes/route_const.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.r),
        child: Column(
          children: [
            SizedBox(height: 80.h),
            TextView(
              text: Strings.login,
              fontSize: 20.sp,
              fontFamily: FontFamily.calSans,
            ),
            TextView(
              text: Strings.loginSubtitle,
              fontSize: 14.sp,
              textColor: AppColors.textPrimaryLightColor,
              fontFamily: FontFamily.calSans,
            ),
            SizedBox(height: 20.h),
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
                  controller.login();
                },
                child: TextView(
                  text: "Login",
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
                $AssetsImagesGen().google.image(height: 20.h, width: 20.w),
                SizedBox(width: 10.w),
                TextView(
                  text: "Sign with google",
                  fontFamily: FontFamily.calSans,
                ),
              ],
            ),

            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextView(
                  text: "Don't have an account?",
                  fontFamily: FontFamily.calSans,
                ),
                SizedBox(width: 3.w),
                GestureDetector(
                  onTap: () => Get.toNamed(RouteConst.signUp),
                  child: TextView(
                    text: "SignUp",
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
