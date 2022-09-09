import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/task.dart';
import '../provider/tasks_mng.dart';

class FormSheet extends StatefulWidget {
  @override
  State<FormSheet> createState() => _FormSheetState();
}

class _FormSheetState extends State<FormSheet> {
  TextEditingController dateInput = TextEditingController();
  TextEditingController timeInput = TextEditingController();

  final _form = GlobalKey<FormState>();
  final _timeFocusNode = FocusNode();
  final _dateFocusNode = FocusNode();
  var _addedTasks = Task(
    id: null,
    title: '',
    taskTime: '',
    taskDate: '',
  );

  void _saveForm() {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    _addedTasks.id = DateTime.now().toString();
    Provider.of<TasksMng>(context, listen: false).addTask(
      _addedTasks.id,
      _addedTasks.title,
      _addedTasks.taskTime,
      _addedTasks.taskDate,
    );
    
  }

  @override
  void dispose() {
    _timeFocusNode.dispose();
    _dateFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _form,
              child: Container(
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.title),
                        labelText: 'Task Title',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_timeFocusNode);
                      },
                      validator: (value) {
                        if (value == '') {
                          return 'Please provide a value.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _addedTasks = Task(
                          id: null,
                          title: value,
                          taskTime: _addedTasks.taskTime,
                          taskDate: _addedTasks.taskDate,
                        );
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: TextFormField(
                        controller: timeInput,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.schedule),
                          labelText: 'Task Time',
                          border: OutlineInputBorder(),
                        ),
                        focusNode: _timeFocusNode,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_dateFocusNode);
                        },
                        validator: (value) {
                          if (value == '') {
                            return 'Please provide a time.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _addedTasks = Task(
                            id: null,
                            title: _addedTasks.title,
                            taskTime: value,
                            taskDate: _addedTasks.taskDate,
                          );
                        },
                        onTap: () async {
                          TimeOfDay pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay(hour: 12, minute: 0),
                          );
                          if (pickedTime != null) {
                            setState(() {
                              timeInput.text = pickedTime.format(context);
                            });
                          }
                        },
                      ),
                    ),
                    TextFormField(
                      controller: dateInput,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.calendar_today),
                        labelText: "Task Date",
                        border: OutlineInputBorder(),
                      ),
                      focusNode: _dateFocusNode,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => _saveForm(),
                      validator: (value) {
                        if (value == '') {
                          return 'Please provide a Date.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _addedTasks = Task(
                          id: null,
                          title: _addedTasks.title,
                          taskTime: _addedTasks.taskTime,
                          taskDate: value,
                        );
                      },
                      onTap: () async {
                        DateTime pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                        );
                        if (pickedDate != null) {
                          String formattedDate =
                              DateFormat.yMMMMd().format(pickedDate);
                          setState(() {
                            dateInput.text = formattedDate;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
