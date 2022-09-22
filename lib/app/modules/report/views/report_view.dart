import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:todo_app/app/modules/report/detail_number.dart';
import 'package:todo_app/core/values/colors.dart';

import '../controllers/report_controller.dart';
import 'package:todo_app/core/utils/extensions.dart';

class ReportView extends GetView<ReportController> {
  const ReportView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            controller.ctrl.changeTabIndex(0);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 16,
          ),
        ),
      ),
      body: SafeArea(child: Obx(() {
        final createdTasks = controller.totalTask;
        final completedTask = controller.totalDone;
        final liveTask = createdTasks - completedTask;
        final percent = createdTasks == 0.0
            ? 0
            : (completedTask * 100 / createdTasks).toStringAsFixed(2);
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
          child: ListView(
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.data_usage,
                    color: Colors.blue,
                  ),
                  SizedBox(
                    width: 2.0.wp,
                  ),
                  Text(
                    "Report",
                    style: TextStyle(
                        fontSize: 24.0.sp, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 4.0.wp,
              ),
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: TextStyle(fontSize: 14.0.sp, color: Colors.grey),
              ),
              SizedBox(
                height: 3.0.wp,
              ),
              const Divider(
                thickness: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DetailNumber(
                      color: Colors.green,
                      number: liveTask,
                      text: "Live Tasks"),
                  DetailNumber(
                      color: Colors.orange,
                      number: completedTask,
                      text: "Completed"),
                  DetailNumber(
                      color: Colors.blue,
                      number: createdTasks,
                      text: "Created"),
                ],
              ),
              SizedBox(
                height: 8.0.wp,
              ),
              UnconstrainedBox(
                child: SizedBox(
                  width: 70.0.wp,
                  height: 70.0.wp,
                  child: CircularStepProgressIndicator(
                    totalSteps: createdTasks == 0 ? 1 : createdTasks,
                    currentStep: createdTasks == 0 ? 1 : completedTask,
                    stepSize: 20,
                    padding: 0,
                    selectedColor: green,
                    unselectedColor: Colors.grey[200]!,
                    width: 150,
                    height: 150,
                    selectedStepSize: 22,
                    roundedCap: (_, __) => true,
                    child: Center(
                        child: Text(
                      "$percent %",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0.sp),
                    )),
                  ),
                ),
              )
            ],
          ),
        );
      })),
    );
  }
}
