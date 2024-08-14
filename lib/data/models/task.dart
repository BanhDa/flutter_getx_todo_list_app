import 'package:equatable/equatable.dart';
import 'package:flutter_getx_todo_app/data/models/todo.dart';

class Task extends Equatable {
  final String title;
  final int icon;
  final String color;
  late List<Todo>? todos;

   Task(
      {required this.title,
      required this.icon,
      required this.color,
      todos}) {
    this.todos = todos ?? [];
  }

  Task copyWith(
          {String? title, int? icon, String? color, List<Todo>? todos}) =>
      Task(
          title: title ?? this.title,
          icon: icon ?? this.icon,
          color: color ?? this.color,
          todos: todos ?? this.todos);

  factory Task.fromJson(Map<String, dynamic> json) => Task(
      title: json['title'],
      icon: json['icon'],
      color: json['color'],
      todos: json['todos']);

  Map<String, dynamic> toJson() => {
    'title': title,
    'icon': icon,
    'color': color,
    'todos': todos
  };

  @override
  List<Object?> get props => [title, icon, color];

  bool containTodoTitle(String todoTitle) {
    return todos?.any((todo)  {
      return todo.title == todoTitle;
    }) ?? false;
  }

  addTodo(String todoTitle) {
    var todo = Todo(title: todoTitle);
    todos?.add(todo);
  }

  addTodos(List<Todo> todos) {
    this.todos = todos;
  }
}
