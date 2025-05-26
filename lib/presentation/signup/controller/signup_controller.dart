import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:task_project/imports.dart';
import 'package:task_project/presentation/widgets/snackbar_util.dart';
import 'package:task_project/routes/route_const.dart';
import 'package:task_project/service/auth/auth_service.dart';
import 'package:task_project/services/local_storage.dart';

class SignupController extends GetxController {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final isPasswordVisible = true.obs;
  final isConfirmPasswordVisible = true.obs;
  final ImagePicker picker = ImagePicker();
  final Rx<File?> selectedImage = Rx<File?>(null);
  RxBool isSelectedImage = false.obs;
  final AuthService _authService = AuthService.instance;
  RxBool isLoading = false.obs;

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
      isSelectedImage.value = true;
      LocalStorage.instance.write(
        'userProfileImage',
        pickedFile.path,
      ); // Save image path
    }
  }

  void singup() {
    if (emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty ||
        firstNameController.text.trim().isEmpty ||
        lastNameController.text.trim().isEmpty ||
        confirmPasswordController.text.trim().isEmpty ||
        selectedImage.value == null) {
      SnackbarUtil.show(
        message: "Please fill all filedls",
        title: "Error!",
        type: SnackbarType.error,
      );
    } else if (passwordController.text.trim() !=
        confirmPasswordController.text.trim()) {
      SnackbarUtil.show(
        message: "Password does not mat",
        title: "Error!",
        type: SnackbarType.error,
      );
    } else {
      suubmit;
    }
  }

  Future<void> get suubmit async {
    isLoading.value = true;
    try {
      await _authService.register(
        emailController.text.trim(),
        passwordController.text,
        firstNameController.text.trim(),
        lastNameController.text.trim(),
      );
      print("Sucessfully registerd");
      SnackbarUtil.show(
        message: 'User registered successfully!',
        type: SnackbarType.success,
      );

      await Get.offAllNamed(RouteConst.bottomNav);
      print("Sucessfully registerd");
    } catch (e) {
      print("error in login:: ${e.toString()}");
      SnackbarUtil.show(message: '${e.toString()}', type: SnackbarType.error);
    } finally {
      isLoading.value = false;
    }
  }
}
