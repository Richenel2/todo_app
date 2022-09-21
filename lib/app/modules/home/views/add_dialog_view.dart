import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:get/get.dart';
import 'package:todo_app/app/modules/home/controllers/home_controller.dart';
import 'package:todo_app/core/utils/extensions.dart';

class AddDialogView extends GetView<HomeController> {
  const AddDialogView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: controller.formKey,
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(3.0.wp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      Get.back();
                      controller.clear();
                    },
                  ),
                  TextButton(
                    style: ButtonStyle(
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                    ),
                    onPressed: () {
                      if (controller.formKey.currentState!.validate()) {
                        if (controller.task.value == null) {
                          EasyLoading.showError("Please select Task");
                        } else {
                          final success = controller.updateTask(
                            controller.task.value!,
                            controller.editController.text,
                          );
                          if (success) {
                            EasyLoading.showSuccess("Todo item add success");
                            Get.back();
                          } else {
                            EasyLoading.showError("Todo item already exist");
                          }

                          controller.clear();
                        }
                      }
                    },
                    child: Text(
                      "Done",
                      style: TextStyle(fontSize: 14.0.sp),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5.0.wp),
              child: Text(
                "New Task",
                style:
                    TextStyle(fontSize: 20.0.sp, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
              child: TextFormField(
                controller: controller.editController,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[400]!),
                  ),
                ),
                autofocus: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your todo item";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 5.0.wp,
                left: 5.0.wp,
                right: 5.0.wp,
                bottom: 2.0.wp,
              ),
              child: Text(
                "Add to",
                style: TextStyle(
                  fontSize: 14.0.sp,
                  color: Colors.grey,
                ),
              ),
            ),
            ...controller.tasks
                .map((element) => Obx(
                      () => InkWell(
                        onTap: () {
                          controller.changeTask(element);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 3.0.wp, horizontal: 5.0.wp),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    IconData(
                                      element.icon!,
                                      fontFamily: "MaterialIcons",
                                    ),
                                    color: HexColor.fromHex(element.color!),
                                  ),
                                  SizedBox(
                                    width: 3.0.wp,
                                  ),
                                  Text(
                                    element.title!,
                                    style: TextStyle(
                                        fontSize: 12.0.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              if (controller.task.value == element)
                                const Icon(
                                  Icons.check,
                                  color: Colors.blue,
                                )
                            ],
                          ),
                        ),
                      ),
                    ))
                .toList()
          ],
        ),
      ),
    );
  }
}
