import 'package:task_project/imports.dart';
import 'package:task_project/presentation/map/controller/map_controller.dart';

class MapBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(MapViewController());
  }
}
