import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/app/modules/detail/controllers/detail_controller.dart';
import 'package:todo_app/core/utils/extensions.dart';

class DoneList extends StatelessWidget {
  final crtl = Get.find<DetailController>();
  DoneList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final done = crtl.task.value.done;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (done.isNotEmpty)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
              child: Text(
                "Completed(${done.length})",
                style: TextStyle(
                  fontSize: 14.0.sp,
                  color: Colors.grey,
                ),
              ),
            ),
          ...done.map((e) => Dismissible(
                onDismissed: (_) {
                  crtl.deleteTodo(e);
                },
                key: ObjectKey(e),
                direction: DismissDirection.endToStart,
                background: Container(
                  padding: EdgeInsets.only(right: 5.0.wp),
                  color: Colors.red.withOpacity(0.8),
                  alignment: Alignment.centerRight,
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                child: ListTile(
                    onTap: () {
                      crtl.changeTodo(false, e);
                    },
                    title: Text(
                      "$e",
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          decoration: TextDecoration.lineThrough),
                    ),
                    leading: Icon(
                      Icons.check,
                      color: HexColor.fromHex(crtl.task.value.color!),
                    )),
              ))
        ],
      );
    });
  }
}
