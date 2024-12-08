import 'package:flutter/cupertino.dart';
import 'package:flutter_getx_todo_app/data/models/task.dart';
import 'package:flutter_getx_todo_app/data/services/storages/repository.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  TaskRepository taskRepository;
  HomeController({required this.taskRepository});

  final formKey = GlobalKey<FormState>();
  final editController = TextEditingController();
  final tasks = <Task>[].obs;

  @override
  void onInit() {
    super.onInit();
    // thay thế danh sách của biến tasks bằng danh sách lưu ở storage
    tasks.assignAll(taskRepository.readTasks());
    // Lắng nghe sự kiện thay đổi task list -> nếu có thay đổi thì lưu lại vào storage
    ever(tasks, (callback) => taskRepository.writeTasks(tasks));
  }

}