import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String title;
  final int icon;
  final String color;
  final List<dynamic>? todos;

  const Task(
      {required this.title,
      required this.icon,
      required this.color,
      this.todos});

  Task copyWith({
    String? title,
    int? icon,
    String? color,
    List<dynamic>? todos,
  }) =>
      Task(
          title: title ?? this.title,
          icon: icon ?? this.icon,
          color: color ?? this.color,
          todos: todos ?? this.todos);

  static const String TITLE = 'title';
  static const String ICON = 'icon';
  static const String COLOR = 'color';
  static const String TODOS = 'todos';

  factory Task.fromJson(Map<String, dynamic> json) => Task(
      title: json[TITLE],
      icon: json[ICON],
      color: json[COLOR],
      todos: json[TODOS]);

  Map<String, dynamic> toJson() => {
    TITLE: title,
    ICON: icon,
    COLOR: color,
    TODOS: todos
  };

  @override
  List<Object?> get props => [title, icon, color];
}
