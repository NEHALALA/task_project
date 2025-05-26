import 'package:get/instance_manager.dart';
import 'package:task_project/presentation/home_page/controller/home_controller.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
  }
}
