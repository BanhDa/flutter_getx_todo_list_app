import 'package:flutter_getx_todo_app/data/providers/task/provider.dart';

import '../../models/task.dart';

class TaskRepository {
  late TaskProvider taskProvider;

  TaskRepository({required this.taskProvider});

  List<Task> readTasks() => taskProvider.readTasks();

  void writeTasks(List<Task> tasks) => taskProvider.writeTasks(tasks);
}
