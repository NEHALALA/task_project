import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_project/gen/fonts.gen.dart';
import 'package:task_project/presentation/splash/controller/splash_controller.dart';
import 'package:task_project/presentation/widgets/text_view.dart';
import '../../../imports.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextView(
          text: "Task Mangenment",
          fontSize: 24.sp,
          fontFamily: FontFamily.calSans,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
