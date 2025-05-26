import 'package:task_project/imports.dart';
import 'package:task_project/presentation/widgets/snackbar_util.dart';
import 'package:task_project/routes/route_const.dart';
import 'package:task_project/service/auth/auth_service.dart';
import 'package:task_project/services/snackbar_util.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final isPasswordVisible = true.obs;
  RxBool isLoading = false.obs;
  final AuthService _authService = AuthService.instance;

  void login() {
    if (emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      SnackbarUtil.show(
        message: "Please fill all fileds",
        type: SnackbarType.error,
      );
    } else {
      submit;
    }
  }

  Future<void> get submit async {
    isLoading.value = true;
    try {
      await _authService.login(
        emailController.text.trim(),
        passwordController.text,
      );
      SnackbarUtil.show(
        message: 'User Login successfully!',
        type: SnackbarType.success,
      );

      Get.offNamed(RouteConst.bottomNav);
    } catch (e) {
      print("e in login: ${e.toString()}");
      SnackbarUtil.show(message: e.toString(), type: SnackbarType.error);
    } finally {
      isLoading.value = false;
    }
  }
}
