import 'package:flutter_getx_todo_app/data/provider/task/provider.dart';
import 'package:flutter_getx_todo_app/data/services/storages/repository.dart';
import 'package:flutter_getx_todo_app/modules/home/controller.dart';
import 'package:get/get.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(
        taskRepository: TaskRepository(
            taskProvider: TaskProvider()
        )
    ));
  }
}
