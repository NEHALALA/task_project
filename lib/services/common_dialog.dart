import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_project/config/app_colors.dart';

class DialogUtil {
  static AlertDialog? alert;
  static AlertDialog? alert2;
  static AlertDialog? alert3;

  static void createDialogInstance() {
    alert = AlertDialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          CircularProgressIndicator(color: AppColors.whiteColor),
        ],
      ),
    );
  }

  static showLoaderDialog({String message = "Loading..."}) {
    alert ??= AlertDialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          CircularProgressIndicator(color: AppColors.whiteColor),
        ],
      ),
    );

    showDialog(
      barrierDismissible: false,
      context: Get.context!,
      builder: (BuildContext context) {
        return Material(
          type: MaterialType.transparency,
          child: WillPopScope(
            onWillPop: () async {
              return Future.value(false);
            },
            child: alert!,
          ),
        );
      },
    );
  }

  static void dismissDialog() {
    if (alert != null) {
      Navigator.pop(Get.context!);
    }
  }

  static void dismissLoadingDialog() {
    if (alert3 != null) {
      Navigator.pop(Get.context!);
    }
  }
}
