import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/app/modules/home/controllers/home_controller.dart';
import 'package:todo_app/app/widgets/icons.dart';
import 'package:todo_app/core/utils/extensions.dart';

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
                  Wrap(
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
                ]),
              ));
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
