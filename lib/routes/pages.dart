import 'package:get/get.dart';
import 'package:task_project/presentation/bottom_nav/view/bottom_nav_view.dart';
import 'package:task_project/presentation/customize_theme/view/customize_view.dart';
import 'package:task_project/presentation/home_page/view/home_view.dart';
import 'package:task_project/presentation/login/view/login_view.dart';
import 'package:task_project/presentation/map/view/map_view.dart';
import 'package:task_project/presentation/profile/view/profile_view.dart';
import 'package:task_project/presentation/signup/view/signup_view.dart';
import 'package:task_project/presentation/splash/view/splash_view.dart';
import 'package:task_project/presentation/task/view/task_view.dart';
import 'package:task_project/routes/bindings/bottom_nav_bindings.dart';
import 'package:task_project/routes/bindings/customize_theme_bindings.dart';
import 'package:task_project/routes/bindings/home_bindings.dart';
import 'package:task_project/routes/bindings/login_bindings.dart';
import 'package:task_project/routes/bindings/map_bindings.dart';
import 'package:task_project/routes/bindings/profile_bindings.dart';
import 'package:task_project/routes/bindings/signup_bindings.dart';
import 'package:task_project/routes/bindings/splash_bindings.dart';
import 'package:task_project/routes/bindings/task_bindings.dart';
import 'package:task_project/routes/route_const.dart';

class AppPages {
  // static const initial = RouteConst.initial;

  static final List<GetPage<dynamic>> routes = [
    GetPage(
      name: RouteConst.splash,
      page: () => const SplashView(),
      binding: SplashBindings(),
    ),
    GetPage(
      name: RouteConst.home,
      page: () => HomeView(),
      binding: HomeBindings(),
    ),
    GetPage(
      name: RouteConst.bottomNav,
      page: () => BottomNavView(),
      binding: BottomNavBindings(),
    ),
    GetPage(
      name: RouteConst.task,
      page: () => TaskView(),
      binding: TaskBindings(),
    ),
    GetPage(
      name: RouteConst.map,
      page: () => MapView(),
      binding: MapBindings(),
    ),
    GetPage(
      name: RouteConst.profile,
      page: () => ProfileView(),
      binding: ProfileBindings(),
    ),
    GetPage(
      name: RouteConst.customizeTheme,
      page: () => CustomizeThemeView(),
      binding: CustomizeThemeBindings(),
    ),
    GetPage(
      name: RouteConst.login,
      page: () => LoginView(),
      binding: LoginBindings(),
    ),
    GetPage(
      name: RouteConst.signUp,
      page: () => SignupView(),
      binding: SignupBindings(),
    ),
  ];
}
