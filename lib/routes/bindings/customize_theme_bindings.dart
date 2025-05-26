import 'package:task_project/imports.dart';
import 'package:task_project/presentation/customize_theme/controller/customize_controller.dart';

class CustomizeThemeBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(CustomizeThemeController());
  }
}
