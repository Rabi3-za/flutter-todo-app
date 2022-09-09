import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/form_sheet.dart';
import '../provider/tasks_mng.dart';
import '../widgets/list_tasks.dart';

class TasksScreen extends StatefulWidget {
  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  TextEditingController dateInput = TextEditingController();
  TextEditingController timeInput = TextEditingController();
  bool showDialog = false;

  @override
  Widget build(BuildContext context) {
    final tasksData = Provider.of<TasksMng>(context);

    return Scaffold(
      bottomSheet: showDialog ? FormSheet() : null,
      body: ListTasks('newTask',tasksData.items, tasksData.deleteTask, tasksData.addTaskToDone,tasksData.addTaskToArchieve),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          setState(() {
            showDialog = !showDialog;
          });
        },
      ),
    );
  }
}
