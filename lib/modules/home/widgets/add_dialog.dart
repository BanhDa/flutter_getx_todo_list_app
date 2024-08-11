import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getx_todo_app/core/utils/extensions.dart';
import 'package:flutter_getx_todo_app/data/models/task.dart';
import 'package:flutter_getx_todo_app/modules/home/controller.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AddDialog extends StatelessWidget {
  final homeController = Get.find<HomeController>();

  AddDialog({super.key, task}) {
    homeController.setTask(task);
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CloseButton(
                    onPressed: () => handleCloseButton(),
                  ),
                  showDoneButton()
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  showTitle(),
                  showTodoItem(),
                  showAddTo(),
                  ...showTasks()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  handleCloseButton() {
    Get.back();
    homeController.editController.clear();
    homeController.setTask(null);
  }

  handleDoneButton() {
    if (!homeController.formKey.currentState!.validate()) {
      return;
    }

    if (homeController.getTask == null) {
      EasyLoading.showError('Please select task type');
      return;
    }

    var updateSuccess = homeController.updateTask(
      homeController.getTask,
      homeController.editController.text
    );
    if (!updateSuccess) {
      EasyLoading.showError('Todo item is already exist');
      return;
    }

    EasyLoading.showSuccess('Todo item add success');
    homeController.editController.clear();
    homeController.setTask(null);
  }

  showDoneButton() {
    return TextButton(
        onPressed: () => handleDoneButton(),
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.transparent),
        ),
        child: Text(
          'Done',
          style: TextStyle(
            fontSize: 14.0.sp,
          ),
        ));
  }

  showTitle() {
    return Text(
      'New Task',
      style: TextStyle(fontSize: 20.0.sp, fontWeight: FontWeight.bold),
    );
  }

  showTodoItem() {
    return TextFormField(
      controller: homeController.editController,
      autofocus: true,
      decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400]!))),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please enter your todo item';
        }
        return null;
      },
    );
  }

  showAddTo() {
    return Padding(
      padding: EdgeInsets.only(bottom: 5.0.wp, top: 5.0.wp),
      child: Text('Add to',
          style: TextStyle(fontSize: 14.0.sp, color: Colors.grey)),
    );
  }

  showTasks() {
    return homeController.getTasks.map((task) => showTask(task));
  }

  showTask(Task task) {
    return Obx(
      () => InkWell(
        onTap: () {
          homeController.setTask(task);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 2.0.wp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    IconData(task.icon, fontFamily: "MaterialIcons"),
                    color: HexColor.fromHex(task.color),
                  ),
                  SizedBox(
                    width: 3.0.wp,
                  ),
                  Text(
                    task.title,
                    style: TextStyle(
                        fontSize: 12.0.sp, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              if (homeController.getTask == task)
                const Icon(
                  Icons.check,
                  color: Colors.blue,
                )
            ],
          ),
        ),
      ),
    );
  }
}
