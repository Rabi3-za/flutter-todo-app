import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/tasks_mng.dart';
import '../widgets/list_tasks.dart';


class DoneScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final doneTsk = Provider.of<TasksMng>(context);
    return ListTasks('doneTask',doneTsk.itemsDone, doneTsk.deleteTaskFromDone,(String id) {} , doneTsk.addTaskToArchieve);
  }
}