import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getx_todo_app/data/models/task.dart';
import 'package:flutter_getx_todo_app/data/models/todo.dart';
import 'package:flutter_getx_todo_app/data/services/storages/repository.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  TaskRepository taskRepository;

  HomeController({required this.taskRepository});

  final _tasks = <Task>[].obs;
  final _chipIndex = 0.obs;
  final _deleting = false.obs;
  final _openTrash = false.obs;
  final _task = Rx<Task?>(null);

  final doingTodos = <Todo>[].obs;
  final doneTodos = <Todo>[].obs;

  final formKey = GlobalKey<FormState>();
  final editController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    _tasks.assignAll(taskRepository.readTasks());
    ever(_tasks, (_) => taskRepository.writeTasks(_tasks));
  }

  @override
  void onClose() {
    editController.dispose();
    super.onClose();
  }

  bool addTask(Task task) {
    if (_tasks.contains(task)) {
      return false;
    }
    _tasks.add(task);
    return true;
  }

  get getTasks {
    return _tasks.value;
  }

  void clearData() {
    editController.clear();
    _chipIndex.value = 0;
  }

  get getChipIndex {
    return _chipIndex.value;
  }

  setChipIndex(value) {
    _chipIndex.value = value;
  }

  setDeleting(bool value) {
    _deleting.value = value;
  }

  bool get isDeleting {
    return _deleting.value;
  }

  void deleteTask(task) {
    _tasks.remove(task);
  }

  setOpenTrash(bool value) {
    _openTrash.value = value;
  }

  bool get isOpenTrash {
    return _openTrash.value;
  }

  setTask(Task? task) {
    _task.value = task;
  }

  get getTask {
    return _task.value;
  }

  bool updateTask(Task task, todoTitle) {
    if (task.containTodoTitle(todoTitle)) {
      return false;
    }
    task.addTodo(todoTitle);
    _tasks.refresh();
    changeTodos(task.todos ?? []);
    return true;
  }

  void changeTodos(List<Todo> selects) {
    doingTodos.clear();
    doneTodos.clear();

    Todo todo;
    for (int i = 0; i < selects.length; i++) {
      todo = selects[i];
      if (todo.done == true) {
        doneTodos.add(todo);
      } else {
        doingTodos.add(todo);
      }
    }
  }

  addTodo(String title) {
    Todo doingTodo = Todo(title: title, done: false);
    if (doingTodos.any((todo) => doingTodo == todo)) {
      return false;
    }
    Todo doneTodo = Todo(title: title, done: true);
    if (doneTodos.any((todo) => doneTodo == todo)) {
      return false;
    }
    doingTodos.add(doingTodo);
    return true;
  }

  updateTodos() {
    List<Todo> newTodos = [];
    newTodos.addAll([...doingTodos, ...doneTodos]);
    _task.value?.addTodos(newTodos);
    Task? newTask = _task.value?.copyWith(todos: newTodos);
    var oldIndex = _tasks.indexOf(_task.value);
    _tasks[oldIndex] = newTask!;
    _tasks.refresh();
  }

  doneTodo(String title) {
    Todo doingTodo = Todo(title: title, done: false);
    int index = doingTodos.indexWhere((element) => doingTodo == element);
    doingTodos.removeAt(index);

    doneTodos.add(Todo(title: title, done: true));

    doneTodos.refresh();
    doingTodos.refresh();
  }
}
