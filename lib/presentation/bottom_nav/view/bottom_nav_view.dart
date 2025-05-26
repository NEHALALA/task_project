import 'package:task_project/imports.dart';
import 'package:task_project/presentation/bottom_nav/controller/bottom_nav_bar_controller.dart';
import 'package:task_project/presentation/bottom_nav/widgets/custom_nav_bar.dart';

class BottomNavView extends GetView<BottomNavBarController> {
  const BottomNavView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomNavBar(),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}
