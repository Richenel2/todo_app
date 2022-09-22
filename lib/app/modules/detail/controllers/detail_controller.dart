import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/app/data/models/task_model.dart';
import 'package:todo_app/app/modules/home/controllers/home_controller.dart';

class DetailController extends GetxController {
  final task = (Get.arguments["task"] as Task).obs;

  final editCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool addTodo(String text) {
    final todos = task.value.todos;
    if (todos.any((element) => element == text)) {
      return false;
    }
    task.value.todos.add(text);
    task.refresh();
    return true;
  }

  void clear() {
    editCtrl.clear();
  }

  void changeTodo(value, text) {
    if (value) {
      task.value.todos.remove(text);
      task.value.done.add(text);
    } else {
      task.value.todos.add(text);
      task.value.done.remove(text);
    }

    task.refresh();
    Get.find<HomeController>().tasks.refresh();
  }

  void deleteTodo(text) {
    task.value.done.remove(text);
    task.refresh();
    Get.find<HomeController>().tasks.refresh();
  }
}
