import 'package:flutter/material.dart';
import 'package:flutter_getx_todo_app/core/utils/extensions.dart';
import 'package:flutter_getx_todo_app/modules/home/controller.dart';
import 'package:flutter_getx_todo_app/modules/home/widgets/add_card.dart';
import 'package:flutter_getx_todo_app/modules/home/widgets/task_card.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'My List',
              style: TextStyle(fontSize: 24.0.sp, fontWeight: FontWeight.bold),
            ),
          ),
          Obx(() => GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                children: [...buildTasks(), AddCard()],
              )),
        ],
      )),
      floatingActionButton: Obx(() => buildAddButton()),
    );
  }

  buildTasks() {
    return controller.tasks
        .map((task) => LongPressDraggable(
            data: task,
            onDragStarted: () => controller.setDeleting(true),
            onDraggableCanceled: (_, __) => controller.setDeleting(false),
            onDragEnd: (_) => controller.setDeleting(false),
            feedback: Opacity(
              opacity: 0.8,
              child: TaskCard(task: task),
            ),
            child: TaskCard(
              task: task,
            )))
        .toList();
  }

  buildAddButton() {
    return FloatingActionButton(
      onPressed: () {},
      backgroundColor: controller.isDeleting ? Colors.blue : Colors.red,
      child: Icon(
        controller.isDeleting ? Icons.delete : Icons.add,
        color: Colors.white,
      ),
    );
  }
}
