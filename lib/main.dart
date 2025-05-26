import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:task_project/config/strings.dart';
import 'package:task_project/config/theme/app_theme.dart';
import 'package:task_project/config/theme/theme_controller.dart';
import 'package:task_project/routes/pages.dart';
import 'package:task_project/routes/route_const.dart';
import 'package:task_project/service/notification/notification_service.dart';
import 'package:task_project/services/app_base_component.dart';
import 'package:task_project/services/logger.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await NotificationService.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await GetStorage.init();
  AppLogger.instance.init();
  Get.put(AppBaseComponent.instance);
  Get.put(ThemeController(), permanent: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = ThemeController.instance;
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: Strings.appName,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme(themeController.primaryColor),
          darkTheme: AppTheme.darkTheme(themeController.primaryColor),
          themeMode:
              themeController.isDarkMode.value
                  ? ThemeMode.dark
                  : ThemeMode.light,
          initialRoute: RouteConst.splash,
          getPages: AppPages.routes,
          builder: (context, child) {
            return Stack(
              children: [
                child!,
                AppBaseComponent.instance.buildLoadingOverlay(),
                AppBaseComponent.instance.buildNetworkStatusWidget(),
              ],
            );
          },
        );
      },
    );
  }
}
