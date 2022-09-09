import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/tasks_mng.dart';
import '../widgets/list_tasks.dart';

class ArchivedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final archivedTsk = Provider.of<TasksMng>(context);
    return ListTasks('archived', archivedTsk.itemsArchieved, archivedTsk.deleteTaskFromArchived, (String id) {}, (String id, String from) {});
  }
}