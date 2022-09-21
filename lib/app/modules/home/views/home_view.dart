import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:get/get.dart';
import 'package:todo_app/app/data/models/task_model.dart';
import 'package:todo_app/app/modules/home/views/add_dialog_view.dart';
import 'package:todo_app/app/modules/home/widgets/add_card.dart';
import 'package:todo_app/app/modules/home/widgets/task_card.dart';
import 'package:todo_app/core/utils/extensions.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(4.0.wp),
              child: Text(
                "My List",
                style:
                    TextStyle(fontSize: 24.0.sp, fontWeight: FontWeight.bold),
              ),
            ),
            Obx(() => GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  children: [
                    ...controller.tasks
                        .map(
                          (e) => LongPressDraggable(
                            data: e,
                            onDragStarted: () =>
                                controller.changeDeleting(true),
                            onDraggableCanceled: (__, _) =>
                                controller.changeDeleting(false),
                            onDragEnd: (_) => controller.changeDeleting(false),
                            child: TaskCard(task: e),
                            feedback:
                                Opacity(opacity: 0.8, child: TaskCard(task: e)),
                          ),
                        )
                        .toList(),
                    AddCard()
                  ],
                ))
          ],
        ),
      ),
      floatingActionButton: DragTarget<Task>(
        onAccept: (task) {
          controller.deleteTask(task);
          EasyLoading.showSuccess("Delete success");
        },
        builder: (_, candidat, request) {
          return Obx(
            () => FloatingActionButton(
              backgroundColor:
                  controller.deleting.value ? Colors.red : Colors.blue,
              onPressed: () {
                Get.to(const AddDialogView(), transition: Transition.downToUp);
              },
              child: Icon(controller.deleting.value ? Icons.delete : Icons.add),
            ),
          );
        },
      ),
    );
  }
}
