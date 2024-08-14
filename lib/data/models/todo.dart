import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final String title;
  late final bool done;

  Todo({required this.title, done}) {
    this.done = done ?? false;
  }

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
      title: json['title'],
      done: json['done']
  );

  Map<String, dynamic> toJson() => {
    'title': title,
    'done': done,
  };

  @override
  List<Object?> get props => [title, done];
}