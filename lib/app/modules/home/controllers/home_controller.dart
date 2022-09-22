import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/app/data/models/task_model.dart';
import 'package:todo_app/app/data/services/storage/repository.dart';

class HomeController extends GetxController {
  TaskRepository taskRepository;
  HomeController({required this.taskRepository});

  final tasks = <Task>[].obs;
  final formKey = GlobalKey<FormState>();
  final deleting = false.obs;
  final editController = TextEditingController();
  final tabIndex = 0.obs;
  final chipIndex = 0.obs;
  final task = Rx<Task?>(null);

  @override
  void onInit() {
    super.onInit();

    tasks.assignAll(taskRepository.readTasks());
    ever(tasks, (_) => taskRepository.writeTasks(tasks));
  }

  void changeDeleting(bool del) {
    deleting.value = del;
  }

  void changeChipIndex(int value) {
    chipIndex.value = value;
  }

  bool addTask(Task task) {
    if (tasks.contains(task)) return false;
    tasks.add(task);
    return true;
  }

  clear() {
    editController.clear();
    changeChipIndex(0);
    changeTask(null);
  }

  void deleteTask(Task task) {
    tasks.remove(task);
  }

  void changeTask(Task? select) {
    task.value = select;
  }

  bool updateTask(Task task, String text) {
    final todos = task.todos;
    if (todos.any((element) => element == text)) {
      return false;
    }
    todos.add(text);
    tasks[tasks.indexOf(task)].todos = todos;
    tasks.refresh();
    return true;
  }

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }
}
