import 'package:task_project/imports.dart';
import 'package:task_project/presentation/login/controller/login_controller.dart';

class LoginBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
  }
}
