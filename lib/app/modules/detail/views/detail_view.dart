import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:todo_app/app/modules/detail/widgets/done_list.dart';
import 'package:todo_app/core/utils/extensions.dart';
import 'package:todo_app/core/values/image.dart';

import '../../home/controllers/home_controller.dart';
import '../controllers/detail_controller.dart';
import '../widgets/doing_list.dart';

class DetailView extends GetView<DetailController> {
  const DetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final task = controller.task.value;
      final color = HexColor.fromHex(task.color!);
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 16,
            ),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0.wp),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(2.0.wp),
                    child: Icon(
                      IconData(task.icon!, fontFamily: "MaterialIcons"),
                      color: color,
                    ),
                  ),
                  Text(
                    task.title!,
                    style: TextStyle(
                      fontSize: 12.0.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 16.0.wp,
                right: 16.0.wp,
                top: 3.0.wp,
              ),
              child: Row(
                children: [
                  Text(
                    "${task.length} Tasks",
                    style: TextStyle(
                      fontSize: 12.0.sp,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(width: 3.0.wp),
                  Expanded(
                    child: StepProgressIndicator(
                      totalSteps: task.length == 0 ? 1 : task.length,
                      currentStep: task.length == 0 ? 1 : task.done.length,
                      size: 5,
                      padding: 0,
                      selectedGradientColor: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [color.withOpacity(0.5), color],
                      ),
                      unselectedColor: Colors.grey[300]!,
                    ),
                  ),
                  SizedBox(width: 3.0.wp),
                  if (task.length != 0)
                    Text(
                      "${(task.done.length * 100 / task.length).toStringAsFixed(2)} % done",
                      style: TextStyle(
                        fontSize: 12.0.sp,
                        color: Colors.grey,
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 2.0.wp,
                horizontal: 5.0.wp,
              ),
              child: Form(
                key: controller.formKey,
                child: TextFormField(
                  controller: controller.editCtrl,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[400]!),
                    ),
                    prefixIcon: const Icon(
                      Icons.check_box_outline_blank,
                      color: Colors.grey,
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.done),
                      onPressed: () {
                        if (controller.formKey.currentState!.validate()) {
                          final success = controller.addTodo(
                            controller.editCtrl.text,
                          );
                          if (success) {
                            EasyLoading.showSuccess("Todo item add success");
                            Get.find<HomeController>().tasks.refresh();
                          } else {
                            EasyLoading.showError("Todo item already exist");
                          }
                          controller.clear();
                        }
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter your todo title";
                    }
                    return null;
                  },
                ),
              ),
            ),
            if (task.length == 0)
              Expanded(
                child: Center(
                  child: Image.asset(
                    emptyTodoListImage,
                    fit: BoxFit.cover,
                    width: 65.0.wp,
                  ),
                ),
              )
            else
              Flexible(
                child: ListView(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  children: [DoingList(), SizedBox(height: 2.0.wp), DoneList()],
                ),
              ),
          ],
        ),
      );
    });
  }
}
