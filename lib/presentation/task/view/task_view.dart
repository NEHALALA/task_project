// Import necessary packages
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:task_project/config/models/task/task_model.dart';
import 'package:task_project/config/theme/theme_controller.dart';
import 'package:task_project/gen/fonts.gen.dart';
import 'package:task_project/imports.dart';
import 'package:task_project/presentation/task/controller/task_controller.dart';

class TaskView extends GetView<TaskController> {
  const TaskView({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeController themeController = ThemeController.instance;

    return Scaffold(
      appBar: AppBar(
        title: TextView(
          text: "Your Tasks",
          fontFamily: FontFamily.calSans,
          fontSize: 26.sp,
        ),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: themeController.iconColor,
        onPressed: () => _showAddTaskDialog(context),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final tasks = controller.tasks;

        if (tasks.isEmpty) {
          return const Center(
            child: Text(
              "No tasks found",
              style: TextStyle(color: Colors.white),
            ),
          );
        }

        return ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            final task = tasks[index];
            final weekDates = controller.currentWeekDates;

            return Card(
              color:
                  themeController.isDarkMode.value
                      ? AppColors.cardColor
                      : AppColors.greyColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.all(12),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextView(text: task.title, fontFamily: FontFamily.calSans),
                    const SizedBox(height: 8),
                    Text(
                      "${task.repeatType} | ${task.description}",
                      style: const TextStyle(color: Colors.green, fontSize: 14),
                    ),
                    if (task.time != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: TextView(
                          text: "Time: ${task.time}",
                          fontFamily: FontFamily.calSans,
                        ),
                      ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:
                          weekDates.map((date) {
                            final isHighlighted = _shouldHighlight(
                              task.repeatType,
                              date.weekday,
                            );
                            return Column(
                              children: [
                                TextView(
                                  text: DateFormat.E().format(date),
                                  fontFamily: FontFamily.calSans,
                                ),
                                const SizedBox(height: 4),
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color:
                                          isHighlighted
                                              ? themeController.iconColor
                                              : AppColors.darkerGreyColor,
                                      width: 2,
                                    ),
                                    color: Colors.transparent,
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  child: TextView(
                                    text: '${date.day}',
                                    fontFamily: FontFamily.calSans,
                                    textColor:
                                        isHighlighted
                                            ? themeController.iconColor
                                            : AppColors.blackColor,
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }

  bool _shouldHighlight(String repeatType, int weekday) {
    switch (repeatType) {
      case 'Everyday':
        return true;
      case 'Weekend':
        return weekday == 6 || weekday == 7;
      case 'Weekdays':
        return weekday >= 1 && weekday <= 5;
      default:
        return false;
    }
  }

  void _showAddTaskDialog(BuildContext context) {
    final titleController = TextEditingController();
    final descController = TextEditingController();
    String selectedRepeat = 'Everyday';
    TimeOfDay? selectedTime;

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Add Task"),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(labelText: "Title"),
                  ),
                  TextField(
                    controller: descController,
                    decoration: const InputDecoration(labelText: "Description"),
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: selectedRepeat,
                    decoration: const InputDecoration(labelText: "Repeat Type"),
                    items:
                        ['Everyday', 'Weekend', 'Weekdays']
                            .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)),
                            )
                            .toList(),
                    onChanged: (val) {
                      setState(() {
                        selectedRepeat = val!;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Text("Select Time: "),
                      const SizedBox(width: 10),
                      TextButton(
                        onPressed: () async {
                          final pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (pickedTime != null) {
                            selectedTime = pickedTime;
                          }
                        },
                        child: Text(
                          selectedTime != null
                              ? selectedTime!.format(context)
                              : "Choose Time",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                final newTask = TaskModel(
                  id: '',
                  title: titleController.text.trim(),
                  description: descController.text.trim(),
                  date: DateTime.now(),
                  repeatType: selectedRepeat,
                  days: selectedRepeat,
                  time: selectedTime?.format(
                    context,
                  ), // ✅ this now works correctly
                );
                controller.addTask(newTask);
                Get.back();
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }
}
