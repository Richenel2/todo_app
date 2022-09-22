// ignore_for_file: invalid_use_of_protected_member

import 'package:get/get.dart';
import 'package:todo_app/app/modules/home/controllers/home_controller.dart';

class ReportController extends GetxController {
  final ctrl = Get.find<HomeController>();

  int get totalTask {
    int i = 0;
    for (var element in ctrl.tasks.value) {
      i += element.length;
    }
    return i;
  }

  int get totalDone {
    int i = 0;
    for (var element in ctrl.tasks.value) {
      i += element.done.length;
    }
    return i;
  }
}
