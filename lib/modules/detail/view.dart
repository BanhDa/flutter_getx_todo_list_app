import 'package:flutter/material.dart';
import 'package:flutter_getx_todo_app/core/utils/extensions.dart';
import 'package:flutter_getx_todo_app/modules/home/controller.dart';
import 'package:get/get.dart';

import '../../data/models/task.dart';

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
        body: ListView(
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
              Row(
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
                    style: TextStyle(
                        fontSize: 12.0.sp, fontWeight: FontWeight.bold),
                  )
                ],
              )
            ],
          ),
        )
      ],
    ));
  }

  handleBackButton() {
    Get.back();
  }
}
