import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:todo_app/app/data/models/task_model.dart';
import 'package:todo_app/app/modules/home/controllers/home_controller.dart';
import 'package:todo_app/app/widgets/icons.dart';
import 'package:todo_app/core/utils/extensions.dart';
import 'package:todo_app/core/values/colors.dart';

class AddCard extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  AddCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final icons = getIcons();
    var squareWidth = Get.width - 12.0.wp;
    return Container(
      width: squareWidth / 2,
      height: squareWidth / 2,
      margin: EdgeInsets.all(3.0.wp),
      child: InkWell(
        onTap: () {
          Get.defaultDialog(
              onWillPop: () async {
                homeCtrl.clear();
                return true;
              },
              titlePadding: EdgeInsets.symmetric(vertical: 5.0.wp),
              radius: 5,
              title: "Task Type",
              content: Form(
                key: homeCtrl.formKey,
                child: Column(children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.0.wp),
                    child: TextFormField(
                      controller: homeCtrl.editController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "title",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your task title";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.0.wp),
                    child: Wrap(
                      spacing: 2.0.wp,
                      children: icons
                          .map((e) => Obx(() {
                                final index = icons.indexOf(e);
                                return ChoiceChip(
                                  selectedColor: Colors.grey[200],
                                  backgroundColor: Colors.white,
                                  pressElevation: 0,
                                  label: e,
                                  selected: homeCtrl.chipIndex.value == index,
                                  onSelected: (bool selected) {
                                    homeCtrl
                                        .changeChipIndex(selected ? index : 0);
                                  },
                                );
                              }))
                          .toList(),
                    ),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          minimumSize: const Size(150, 40)),
                      onPressed: () {
                        if (homeCtrl.formKey.currentState!.validate()) {
                          int icon =
                              icons[homeCtrl.chipIndex.value].icon!.codePoint;
                          String color =
                              icons[homeCtrl.chipIndex.value].color!.toHex();
                          final task = Task(
                            title: homeCtrl.editController.text,
                            icon: icon,
                            color: color,
                          );
                          Get.back();
                          homeCtrl.addTask(task)
                              ? EasyLoading.showSuccess("Create success")
                              : EasyLoading.showError("Duplicated task");
                        }
                      },
                      child: const Text("Confirm"))
                ]),
              ));

          homeCtrl.clear();
        },
        child: DottedBorder(
            color: Colors.grey[400]!,
            dashPattern: const [8, 4],
            child: Center(
              child: Icon(
                Icons.add,
                size: 10.0.wp,
                color: Colors.grey,
              ),
            )),
      ),
    );
  }
}
