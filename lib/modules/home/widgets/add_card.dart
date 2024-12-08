import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_getx_todo_app/core/utils/extensions.dart';
import 'package:flutter_getx_todo_app/modules/home/controller.dart';
import 'package:flutter_getx_todo_app/widgets/icons.dart';
import 'package:get/get.dart';
import 'package:dotted_border/dotted_border.dart';

class AddCard extends StatelessWidget {
  final homeController = Get.find<HomeController>();

  AddCard({super.key});

  @override
  Widget build(BuildContext context) {
    final icons = getIcons();
    var squareWith = Get.width - 12.0.wp;
    return Container(
      width: squareWith / 2,
      height: squareWith / 2,
      margin: EdgeInsets.all(3.0.wp),
      child: InkWell(
        onTap: () async {
          await handleAddCardTapAction();
        },
        child: buildAdd()
      ),
    );
  }

  handleAddCardTapAction() async {
    await Get.defaultDialog(
      titlePadding: EdgeInsets.symmetric(vertical: 5.0.wp),
      radius: 5,
      title: 'Task Type',
      content: buildTaskTypeForm()
    );
  }

  Widget buildAdd() {
    return DottedBorder(
      color: Colors.grey[400]!,
        dashPattern: const [8, 4],
        child: Center(
      child: Icon(
        Icons.add,
        size: 10.0.wp,
        color: Colors.grey,
      ),
    ));
  }

  Widget buildTaskTypeForm() {
    return Form(
        child: Column(
      children: [
        TextFormField(
          controller: homeController.editController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Title',
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter your task type';
            }
            return null;
          },
        )
      ],
    ));
  }
}
