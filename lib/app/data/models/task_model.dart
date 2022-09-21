import 'package:equatable/equatable.dart';

class Task extends Equatable {
  String? title;
  int? icon;
  String? color;
  List? todos;
  DateTime? date;

  Task({this.title, this.icon, this.color, this.todos, date})
      : date = date ?? DateTime.now();

  Task.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    icon = json['icon'];
    color = json['color'];
    date = DateTime.parse(json["date"] );
    if (json['todos'] != null) {
      todos = [];
      json['todos'].forEach((v) {
        todos?.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['icon'] = icon;
    data['color'] = color;
    data['date'] = date?.toString();
    if (todos != null) {
      data['todos'] = todos;
    }
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
}
