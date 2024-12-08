import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getx_todo_app/core/utils/extensions.dart';
import 'package:flutter_getx_todo_app/modules/home/controller.dart';
import 'package:flutter_getx_todo_app/modules/home/widgets/add_card.dart';
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
            padding: EdgeInsets.all(4.0.wp),
            child: Text(
              'My List',
              style: TextStyle(fontSize: 24.0.sp, fontWeight: FontWeight.bold),
            ),
          ),
          GridView.count(
            crossAxisCount: 2, // cố định số cột
            shrinkWrap: true, // lưới sẽ co lại phù hợp với nội dung
            // tạo hiệu ứng nảy, khi người dùng cuộn vượt quá giới hạn (thường thấy trong IOS)
            physics: BouncingScrollPhysics(),
            // tạo hiệu ứng dừng chặt ( thường thấy trên Android)
            // physics: ClampingScrollPhysics(),
            children: [
              AddCard()
            ],
          )
        ],
      )),
    );
  }
}
