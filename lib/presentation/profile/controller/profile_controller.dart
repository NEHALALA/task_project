import 'dart:io';

import 'package:task_project/config/models/user_info/user_info_model.dart';
import 'package:task_project/imports.dart';
import 'package:task_project/service/auth/auth_service.dart';
import 'package:task_project/services/local_storage.dart';

class ProfileController extends GetxController {
  Rx<File?> selectedImage = Rx<File?>(null);
  final AuthService _authService = AuthService.instance;
  final RxString userId = ''.obs;
  final RxString fullName = ''.obs;

  @override
  void onInit() {
    getProfileImage();
    userData();
    super.onInit();
  }

  void getProfileImage() {
    final imagePath = LocalStorage.instance.read("userProfileImage");

    if (imagePath != null &&
        imagePath is String &&
        File(imagePath).existsSync()) {
      selectedImage.value = File(imagePath);
    } else {
      selectedImage.value = null;
    }
    userId.value = LocalStorage.instance.read('userId');
    print("uid ${userId.value}");

    print("selectedImage: ${selectedImage.value}");
  }

  void userData() {
    _authService.retrieveInfo(userId.value);

    print('authService userdata: ${_authService.userInfo.firstName}');
    fullName.value =
        "${_authService.userInfo.firstName} ${_authService.userInfo.lastName}";
  }
}
