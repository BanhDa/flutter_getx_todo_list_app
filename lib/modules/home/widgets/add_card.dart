import 'package:flutter/material.dart';
import 'package:flutter_getx_todo_app/core/utils/extensions.dart';
import 'package:flutter_getx_todo_app/data/models/task.dart';
import 'package:flutter_getx_todo_app/modules/home/controller.dart';
import 'package:flutter_getx_todo_app/widgets/icons.dart';
import 'package:get/get.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AddCard extends StatelessWidget {
  final homeController = Get.find<HomeController>();

  final icons = getIcons();

  AddCard({super.key});

  @override
  Widget build(BuildContext context) {
    var squareWidth = Get.width - 12.0.wp;

    return Container(
      width: squareWidth / 2,
      height: squareWidth / 2,
      margin: EdgeInsets.all(3.0.wp),
      child: InkWell(
        onTap: () => buildAddCardDialog(),
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

  void buildAddCardDialog() async {
    await Get.defaultDialog(
        titlePadding: EdgeInsets.symmetric(vertical: 5.0.wp),
        radius: 5,
        title: 'Task type',
        content: Form(
          key: homeController.formKey,
          child: Column(
            children: [
              /**
               * Title
               */
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.0.wp),
                child: showTitleField(),
              ),
              /**
               * Type
               */
              Padding(
                padding: EdgeInsets.symmetric(vertical: 3.0.wp),
                child: Wrap(spacing: 1.5.wp, children: showChoiceChips()),
              ),
              /**
               * Create Button
               */
              showCreateTaskButton(),
            ],
          ),
        ));
    homeController.clearData();
  }

  showTitleField() {
    return TextFormField(
      controller: homeController.editController,
      decoration: const InputDecoration(
          border: OutlineInputBorder(), labelText: 'title'),
      validator: (value) => validateTaskTitle(value),
    );
  }

  showChoiceChips() {
    return icons
        .map((e) => Obx(() {
              final index = icons.indexOf(e);
              return ChoiceChip(
                selectedColor: Colors.grey[300],
                pressElevation: 0,
                backgroundColor: Colors.white,
                showCheckmark: false,
                label: e,
                selected: homeController.getChipIndex == index,
                onSelected: (selected) {
                  homeController.setChipIndex(selected ? index : 0);
                },
                side: const BorderSide(color: Colors.white),
              );
            }))
        .toList();
  }

  showCreateTaskButton() {
    return ElevatedButton(
      onPressed: () => createTaskButton(),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        minimumSize: const Size(150, 40),
        backgroundColor: Colors.blue[500],
      ),
      child: const Text('Confirm'),
    );
  }

  createTaskButton() {
    if (homeController.formKey.currentState!.validate()) {
      int icon = icons[homeController.getChipIndex].icon!.codePoint;
      String color = icons[homeController.getChipIndex].color!.toHex();
      var task = Task(
          title: homeController.editController.text, icon: icon, color: color);
      Get.back();
      homeController.addTask(task)
          ? EasyLoading.showSuccess('Create success')
          : EasyLoading.showError('Duplicate Task');
    }
  }

  validateTaskTitle(String? value) {
    if (value == null || value.trim().isBlank!) {
      return 'Please enter your task title';
    }
    return null;
  }
}
