import 'package:flutter/material.dart';

class Task {
  String id;
  String title;
  String taskTime;
  String taskDate;

  Task({
    @required this.id,
    @required this.title,
    @required this.taskTime,
    @required this.taskDate,
  });
}
