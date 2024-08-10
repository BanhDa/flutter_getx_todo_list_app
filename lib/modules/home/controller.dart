import 'package:flutter/cupertino.dart';
import 'package:flutter_getx_todo_app/data/models/task.dart';
import 'package:flutter_getx_todo_app/data/services/storages/repository.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {

  TaskRepository taskRepository;

  HomeController({required this.taskRepository});

  final tasks = <Task>[].obs;
  final chipIndex = 0.obs;
  final deleting = false.obs;

  final fromKey = GlobalKey<FormState>();
  final editController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    tasks.assignAll(taskRepository.readTasks());
    ever(tasks, (_) => taskRepository.writeTasks(tasks));
  }

  @override
  void onClose() {
    editController.dispose();
    super.onClose();
  }

  bool addTask(Task task) {
    if (tasks.contains(task)) {
      return false;
    }
    tasks.add(task);
    return true;
  }

  void clearData() {
    editController.clear();
    chipIndex.value = 0;
  }

  setDeleting(bool value) {
    deleting.value = value;
  }

  bool get isDeleting {
    return deleting.value;
  }
}