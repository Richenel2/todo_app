import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/app/modules/detail/controllers/detail_controller.dart';
import 'package:todo_app/core/utils/extensions.dart';

class DoingList extends StatelessWidget {
  final crtl = Get.find<DetailController>();
  DoingList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final todos = crtl.task.value.todos;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...todos.map((e) => ListTile(
            onTap: () {
              crtl.changeTodo(true, e);
            },
            title: Text("$e"),
            leading: Checkbox(
              value: false,
              onChanged: (value) {
                crtl.changeTodo(true, e);
              },
              fillColor: MaterialStateProperty.resolveWith(
                  (states) => Colors.grey),
            ),
          )),
          if (crtl.task.value.done.isNotEmpty && todos.isNotEmpty)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
              child: const Divider(
                thickness: 2,
              ),
            )
        ],
      );
    });
  }
}
