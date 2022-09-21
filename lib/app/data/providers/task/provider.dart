import 'dart:convert';

import 'package:get/get.dart';
import 'package:todo_app/app/data/models/task_model.dart';
import 'package:todo_app/app/data/services/storage/services.dart';
import 'package:todo_app/core/utils/keys.dart';

class TaskProvider {
  final StorageService _storage = Get.find<StorageService>();
  List<Task> readTasks() {
    var tasks = <Task>[];
    jsonDecode(_storage.read(taskKey).toString())
        .forEach((e) => tasks.add(Task.fromJson(e)));
    return tasks;
  }

  void writeTasks(List<Task> tasks) {
    _storage.write(taskKey, jsonEncode(tasks)); 
  }
}
