import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:task_project/config/models/task/task_model.dart';
import 'package:task_project/imports.dart';
import 'package:task_project/service/notification/notification_service.dart';
import 'package:task_project/services/local_storage.dart';

class TaskController extends GetxController {
  final RxList<TaskModel> tasks = <TaskModel>[].obs;
  final RxBool isLoading = false.obs;
  final Rx<DateTime> selectedDate = DateTime.now().obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  String userId = '';

  @override
  void onInit() {
    super.onInit();
    initUserAndFetchTasks();
  }

  Future<void> initUserAndFetchTasks() async {
    isLoading.value = true;

    // Try to read userId from local storage
    userId = LocalStorage.instance.read("userId") ?? '';

    // Fallback to FirebaseAuth
    if (userId.isEmpty) {
      userId = auth.currentUser?.uid ?? '';
    }

    if (userId.isNotEmpty) {
      await fetchTasks(userId);
    } else {
      Get.snackbar("Error", "User not logged in. Tasks cannot be fetched.");
    }

    isLoading.value = false;
  }

  /// Start of the current week
  DateTime get startOfWeek {
    final now = DateTime.now();
    return now.subtract(Duration(days: now.weekday % 7));
  }

  /// List of 7 days for the week
  List<DateTime> get currentWeekDates {
    final start = startOfWeek;
    return List.generate(7, (index) => start.add(Duration(days: index)));
  }

  /// Tasks filtered by selected date
  List<TaskModel> get filteredTasks {
    final selected = DateFormat('yyyy-MM-dd').format(selectedDate.value);
    return tasks.where((task) {
      final taskDate = DateFormat('yyyy-MM-dd').format(task.date);
      return selected == taskDate;
    }).toList();
  }

  /// Change selected date
  void updateSelectedDate(DateTime date) {
    selectedDate.value = date;
  }

  /// Fetch all tasks from Firestore
  Future<void> fetchTasks(String id) async {
    try {
      isLoading.value = true;
      final snapshot =
          await _firestore
              .collection('users')
              .doc(id)
              .collection('tasks')
              .get();

      print("Raw documents: ${snapshot.docs.length}");

      for (var doc in snapshot.docs) {
        print("Doc ID: ${doc.id} → ${doc.data()}");
      }

      final fetched =
          snapshot.docs.map((doc) {
            final data = doc.data();
            return TaskModel.fromJson(data);
          }).toList();

      tasks.assignAll(fetched);
    } catch (e, s) {
      print("Error fetching tasks: $e");
      print("Stack trace: $s");
      Get.snackbar("Error", "Failed to fetch tasks: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// Add new task
  Future<void> addTask(TaskModel task) async {
    try {
      final docRef =
          _firestore.collection('users').doc(userId).collection('tasks').doc();

      final newTask = TaskModel(
        id: docRef.id,
        title: task.title,
        description: task.description,
        date: task.date,
        repeatType: task.repeatType,
        days: task.days,
        time: task.time,
      );

      await docRef.set(newTask.toJson());
      tasks.add(newTask);
      // final timeParts = newTask.time!.split(':');
      // int hour = int.parse(timeParts[0]);
      // int minute = int.parse(timeParts[1]);

      // DateTime scheduledDateTime = DateTime(
      //   newTask.date.year,
      //   newTask.date.month,
      //   newTask.date.day,
      //   hour,
      //   minute,
      // );

      // // Skip if time is in the past
      // if (scheduledDateTime.isAfter(DateTime.now())) {
      //   await NotificationService.scheduleNotification(
      //     id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      //     title: "Task Reminder",
      //     body: "${newTask.title} at ${newTask.time}",
      //     scheduledDate: scheduledDateTime,
      //   );
      // }
    } catch (e) {
      Get.snackbar("Error", "Failed to add task");
    }
  }

  /// Tasks for today
  List<TaskModel> get todayTasks {
    final today = DateTime.now();
    final formattedToday = DateFormat('yyyy-MM-dd').format(today);
    final todayWeekday = DateFormat('E').format(today); // 'Mon', 'Tue', etc.

    return tasks.where((task) {
      final taskDate = DateFormat('yyyy-MM-dd').format(task.date);
      final repeatType = task.repeatType?.toLowerCase() ?? '';
      final daysList = task.days ?? [];

      // Check if the date matches today
      if (taskDate != formattedToday) return false;

      // Match based on repeat type
      switch (repeatType) {
        case 'daily':
          return true;
        case 'weekdays':
          return today.weekday >= 1 && today.weekday <= 5; // Mon–Fri
        case 'weekends':
          return today.weekday == 6 || today.weekday == 7; // Sat or Sun
        // Check if today is in custom days
        default:
          return true; // Fallback to include if no repeatType is defined
      }
    }).toList();
  }

  /// Mark task completed
  Future<void> markTaskCompleted(String taskId, bool completed) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('tasks')
          .doc(taskId)
          .update({'isCompleted': completed});

      final index = tasks.indexWhere((task) => task.id == taskId);
      if (index != -1) {
        tasks[index] = tasks[index].copyWith(isCompleted: completed);
        tasks.refresh();
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to update task status");
    }
  }

  /// Debug: clear all tasks locally
  void clearTasks() {
    tasks.clear();
  }
}
