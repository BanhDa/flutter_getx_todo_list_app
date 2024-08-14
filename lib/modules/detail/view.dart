import 'package:flutter/material.dart';
import 'package:flutter_getx_todo_app/core/utils/extensions.dart';
import 'package:flutter_getx_todo_app/modules/detail/widgets/doing_list.dart';
import 'package:flutter_getx_todo_app/modules/home/controller.dart';
import 'package:get/get.dart';

import '../../data/models/task.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class DetailPage extends StatelessWidget {
  final homeController = Get.find<HomeController>();
  final Task task;
  late final Color taskColor;

  DetailPage({super.key, required this.task}) {
    taskColor = HexColor.fromHex(task.color);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      key: homeController.formKey,
      child: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(3.0.wp),
            child: Column(
              children: [
                Row(
                  children: [
                    BackButton(
                      onPressed: () => handleBackButton(),
                    )
                  ],
                ),
                showTaskType(),
                showTaskProgress(),
                showDoingTasks()
              ],
            ),
          ),
          DoingList()
        ],
      ),
    ));
  }

  handleBackButton() {
    homeController.updateTodos();
    homeController.editController.clear();
    Get.back();
  }

  showTaskType() {
    return Row(
      children: [
        Icon(
          IconData(task.icon, fontFamily: 'MaterialIcons'),
          color: taskColor,
        ),
        SizedBox(
          width: 3.0.wp,
        ),
        Text(
          task.title,
          style: TextStyle(fontSize: 12.0.sp, fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  showTaskProgress() {
    return Obx(() {
      var totalTodos =
          homeController.doingTodos.length + homeController.doneTodos.length;
      return Padding(
        padding: EdgeInsets.only(left: 9.0.wp, top: 3.0.wp, right: 12.0.wp),
        child: Row(
          children: [
            Text(
              '$totalTodos Tasks',
              style: TextStyle(fontSize: 12.0.sp, color: Colors.grey),
            ),
            SizedBox(
              width: 3.0.wp,
            ),
            Expanded(
                child: StepProgressIndicator(
              totalSteps: totalTodos == 0 ? 1 : totalTodos,
              currentStep: homeController.doneTodos.length,
              size: 5,
              padding: 0,
              selectedGradientColor: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [taskColor.withOpacity(0.5), taskColor]),
              unselectedGradientColor: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.grey[300]!, Colors.grey[300]!]),
            ))
          ],
        ),
      );
    });
  }

  showDoingTasks() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.0.wp, horizontal: 5.0.wp),
      child: TextFormField(
        controller: homeController.editController,
        autofocus: true,
        decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400]!)),
            prefixIcon: Icon(
              Icons.check_box_outline_blank,
              color: Colors.grey[400],
            ),
            suffixIcon: IconButton(
                onPressed: () => handleAddTodo(),
                icon: const Icon(Icons.done))),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Please enter your todo item';
          }
          return null;
        },
      ),
    );
  }

  handleAddTodo() {
    if (homeController.formKey.currentState!.validate()) {
      var success = homeController.addTodo(homeController.editController.text);
      if (success) {
        EasyLoading.showSuccess('Todo item add success');
      } else {
        EasyLoading.showError('Todo item already exist');
      }
    }
    homeController.editController.clear();
  }
}
