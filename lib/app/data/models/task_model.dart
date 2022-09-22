import 'package:equatable/equatable.dart';

class Task extends Equatable {
  String? title;
  int? icon;
  String? color;
  List todos = [];
  List done = [];
  DateTime? date;

  Task({this.title, this.icon, this.color, todos, done, date}) {
    this.date = date ?? DateTime.now();
    this.done = done ?? [];
    this.todos = todos ?? [];
  }

  Task.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    icon = json['icon'];
    color = json['color'];
    date = DateTime.parse(json["date"]);
    if (json['todos'] != null) {
      todos = [];
      json['todos'].forEach((v) {
        todos.add(v);
      });
    }
    if (json['done'] != null) {
      done = [];
      json['done'].forEach((v) {
        done.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['icon'] = icon;
    data['color'] = color;
    data['date'] = date?.toString();
    data['todos'] = todos;
    data['done'] = done;
    return data;
  }

  Task copyWith({String? title, int? icon, String? color, List? todos}) => Task(
        title: title ?? this.title,
        icon: icon ?? this.icon,
        color: color ?? this.color,
        todos: todos ?? this.todos,
      );

  @override
  List<Object?> get props => [title, icon, color];

  int get length {
    return todos.length + done.length;
  }
}
