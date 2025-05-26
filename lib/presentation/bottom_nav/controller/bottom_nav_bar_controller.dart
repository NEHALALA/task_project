import 'package:task_project/presentation/home_page/view/home_view.dart';
import 'package:task_project/presentation/map/controller/map_controller.dart';
import 'package:task_project/presentation/map/view/map_view.dart';
import 'package:task_project/presentation/profile/controller/profile_controller.dart';
import 'package:task_project/presentation/profile/view/profile_view.dart';
import 'package:task_project/presentation/task/controller/task_controller.dart';
import 'package:task_project/presentation/task/view/task_view.dart';
import '../../../imports.dart';

class BottomNavBarController extends GetxController {
  var selectedIndex = 0.obs;

  @override
  void onInit() {
    Get.put(ProfileController());
    Get.put(TaskController());
    Get.put(MapViewController());
    //Get.lazyPut(() => ReportController());
    super.onInit();
  }

  final screens = [HomeView(), TaskView(), MapView(), ProfileView()];

  void changeTab(int index) {
    selectedIndex.value = index;
  }
}
