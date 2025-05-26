import 'package:get/instance_manager.dart';
import 'package:task_project/presentation/splash/controller/splash_controller.dart';

class SplashBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
  }
}
