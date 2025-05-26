import 'package:task_project/imports.dart';
import 'package:task_project/presentation/signup/controller/signup_controller.dart';

class SignupBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignupController());
  }
}
