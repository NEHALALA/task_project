import 'package:task_project/imports.dart';
import 'package:task_project/presentation/task/controller/task_controller.dart';

class TaskBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(TaskController());
  }
}
