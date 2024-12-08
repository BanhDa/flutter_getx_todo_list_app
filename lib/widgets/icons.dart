import 'package:flutter/material.dart';
import 'package:flutter_getx_todo_app/core/values/colors.dart';
import 'package:flutter_getx_todo_app/core/values/icons.dart';

const String materialIcons = 'MaterialIcons';

List<Icon> getIcons() {
  return const [
    Icon(IconData(personIcon, fontFamily: materialIcons), color: Colors.purple,),
    Icon(IconData(workIcon, fontFamily: materialIcons), color: Colors.pink,),
    Icon(IconData(movieIcon, fontFamily: materialIcons), color: Colors.green,),
    Icon(IconData(sportIcon, fontFamily: materialIcons), color: Colors.yellow,),
    Icon(IconData(travelIcon, fontFamily: materialIcons), color: deepPink,),
    Icon(IconData(shopIcon, fontFamily: materialIcons), color: Colors.lightBlue,)
  ];
}