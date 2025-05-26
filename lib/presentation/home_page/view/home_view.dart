import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_project/config/theme/theme_controller.dart';
import 'package:task_project/gen/fonts.gen.dart';
import 'package:task_project/imports.dart';
import 'package:task_project/presentation/task/controller/task_controller.dart';

class HomeView extends GetView<TaskController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = ThemeController.instance;
    return Scaffold(
      appBar: AppBar(
        title: TextView(
          text: "Today's Task",
          fontFamily: FontFamily.calSans,
          fontSize: 24.sp,
        ),
      ),

      body: Obx(() {
        final tasks = controller.todayTasks;
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        if (tasks.isEmpty) {
          return const Center(child: Text("No tasks for today"));
        }

        return ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            final task = tasks[index];

            return Card(
              color:
                  themeController.isDarkMode.value
                      ? AppColors.cardColor
                      : AppColors.greyColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.all(12),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                title: TextView(
                  text: task.title,
                  fontFamily: FontFamily.calSans,
                  fontSize: 14.sp,
                ),

                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    TextView(
                      text: task.description,
                      fontFamily: FontFamily.calSans,
                      textColor: AppColors.greenColor,
                    ),
                    const SizedBox(height: 4),
                    TextView(
                      text: "Time: ${DateFormat('hh:mm a').format(task.date)}",
                      fontFamily: FontFamily.calSans,
                      fontSize: 14.sp,
                    ),
                  ],
                ),
                trailing: Checkbox(
                  value: task.isCompleted,
                  activeColor: themeController.iconColor,
                  onChanged: (val) {
                    if (val != null) {
                      controller.markTaskCompleted(task.id, val);
                    }
                  },
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
