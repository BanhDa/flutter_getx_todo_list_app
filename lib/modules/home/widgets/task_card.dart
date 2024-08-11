import 'package:flutter/material.dart';
import 'package:flutter_getx_todo_app/core/utils/extensions.dart';
import 'package:flutter_getx_todo_app/modules/detail/view.dart';
import 'package:flutter_getx_todo_app/modules/home/controller.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../data/models/task.dart';

class TaskCard extends StatelessWidget {
  final homeController = Get.find<HomeController>();
  final Task task;
  late final color;

  TaskCard({super.key, required this.task}) {
    color = HexColor.fromHex(task.color);
  }

  @override
  Widget build(BuildContext context) {
    final squareWidth = Get.width - 12.0.wp;

    return GestureDetector(
      onTap: () => Get.to(() => DetailPage(task: task,)),
      child: Container(
        width: squareWidth / 2,
        height: squareWidth / 2,
        margin: EdgeInsets.all(3.0.wp),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              color: Colors.grey[300]!,
              blurRadius: 250,
              offset: const Offset(0, 10))
        ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            showProgressIndicator(),
            showIcon(),
            showTaskInfo()
          ],
        ),
      ),
    );
  }

  handleTaskClick(Task task) {
    homeController.changeTodos(task.todos ?? []);
    Get.to(() => DetailPage(task: task,));
  }

  showProgressIndicator() {
    return StepProgressIndicator(
      // TODO: change after finish todo CRUD
      totalSteps: 100,
      currentStep: 80,
      size: 5,
      padding: 0,
      selectedGradientColor: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color.withOpacity(0.5), color]),
      unselectedGradientColor: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, Colors.white]),
    );
  }

  showIcon() {
    return Padding(
        padding: EdgeInsets.all(4.0.wp),
        child: Icon(
          IconData(task.icon, fontFamily: 'MaterialIcons'),
          color: color,
        ));
  }

  showTaskInfo() {
    return Padding(
      padding: EdgeInsets.all(4.0.wp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            task.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12.0.sp,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 2.0.wp),
          Text(
            '${task.todos?.length ?? 0} Task',
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.grey),
          )
        ],
      ),
    );
  }
}
