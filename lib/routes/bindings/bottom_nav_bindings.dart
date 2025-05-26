import 'package:get/get.dart';
import 'package:task_project/presentation/bottom_nav/controller/bottom_nav_bar_controller.dart';

class BottomNavBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(BottomNavBarController());
  }
}
