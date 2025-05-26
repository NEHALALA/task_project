import 'package:task_project/routes/route_const.dart';
import 'package:task_project/services/local_storage.dart';
import '../../../../imports.dart';

class SplashController extends GetxController {
  final RxString userId = ''.obs;
  @override
  void onInit() {
    routingOnboarding();
    super.onInit();
  }

  void routingOnboarding() {
    print('@@@hehee');
    userId.value = LocalStorage.instance.read("userId") ?? '';
    print("userId in splash: $userId");

    Future.delayed(const Duration(seconds: 3), () {
      print('@@@hehee`');

      if (userId.value.isEmpty) {
        Get.offNamed(RouteConst.login);
      } else {
        Get.offNamed(RouteConst.bottomNav);
      }
      print('@@@hehee11');
    });
  }
}
