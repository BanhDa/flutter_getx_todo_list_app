import 'dart:convert';

import 'package:flutter_getx_todo_app/core/utils/keys.dart';
import 'package:flutter_getx_todo_app/data/services/storages/services.dart';
import 'package:get/get.dart';
import 'package:flutter_getx_todo_app/data/models/task.dart';

class TaskProvider {
  final StorageService _storageService = Get.find<StorageService>();

  List<Task> readTasks() {
    var tasks = <Task>[];

    jsonDecode(_storageService.read(taskKey).toString())
      .forEach( (e) => tasks.add(Task.fromJson(e)) );

    return tasks;
  }

  void writeTask(List<Task> tasks) {
    _storageService.write(taskKey, jsonEncode(tasks));
  }
}