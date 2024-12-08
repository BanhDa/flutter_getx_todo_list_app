import 'package:flutter_getx_todo_app/data/provider/task/provider.dart';
import 'package:flutter_getx_todo_app/data/models/task.dart';

class TaskRepository {
  TaskProvider taskProvider;

  TaskRepository({required this.taskProvider});

  List<Task> readTasks() => taskProvider.readTasks();

  void writeTasks(List<Task> tasks) => taskProvider.writeTask(tasks);
}