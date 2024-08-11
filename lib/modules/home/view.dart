import 'package:flutter/material.dart';
import 'package:flutter_getx_todo_app/core/utils/extensions.dart';
import 'package:flutter_getx_todo_app/data/models/task.dart';
import 'package:flutter_getx_todo_app/modules/home/controller.dart';
import 'package:flutter_getx_todo_app/modules/home/widgets/add_card.dart';
import 'package:flutter_getx_todo_app/modules/home/widgets/add_dialog.dart';
import 'package:flutter_getx_todo_app/modules/home/widgets/task_card.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

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
      floatingActionButton: buildAddButton(),
    );
  }

  buildTasks() {
    return controller.getTasks.map((task) => buildTask(task)).toList();
  }

  buildTask(task) {
    return LongPressDraggable(
        data: task,
        onDragStarted: () {
          controller.setDeleting(true);
        },
        onDraggableCanceled: (_, __) {
          controller.setDeleting(false);
          controller.setOpenTrash(false);
        },
        onDragEnd: (_) {
          controller.setDeleting(false);
          controller.setOpenTrash(false);
        },
        feedback: Opacity(
          opacity: 0.8,
          child: TaskCard(task: task),
        ),
        child: TaskCard(
          task: task,
        ));
  }

  handleAddButton() {
    if (controller.getTasks.isEmpty) {
      EasyLoading.showInfo('Please create your task');
      return;
    }
    Get.to(() => AddDialog(), transition: Transition.downToUp);
  }

  buildAddButton() {
    return DragTarget<Task>(
      builder: (_, __, ___) {
        return Obx(() => FloatingActionButton(
              onPressed: () => handleAddButton(),
              backgroundColor: controller.isDeleting ? Colors.red : Colors.blue,
              child: Icon(
                controller.isDeleting
                    ? controller.isOpenTrash
                        ? Icons.delete_outline
                        : Icons.delete
                    : Icons.add,
                color: Colors.white,
              ),
            ));
      },
      onAcceptWithDetails: (details) => deleteTask(details),
      onLeave: (data) {
        controller.setOpenTrash(false);
      },
      onMove: (_) {
        controller.setOpenTrash(true);
      },
    );
  }

  deleteTask(details) {
    controller.deleteTask(details?.data);
    EasyLoading.showSuccess('Delete successful');
  }
}
