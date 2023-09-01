import 'package:flutter/material.dart';

import '../models/task.dart';

class TasksMng with ChangeNotifier {
  List<Task> _items = [
    Task(
      id: 'p1',
      title: 'go to shop',
      taskTime: '12:30 PM',
      taskDate: 'August 8, 2022',
    ),
    Task(
      id: 'p2',
      title: 'go to jop',
      taskTime: '1:30 PM',
      taskDate: 'August 8, 2022',
    ),
  ];

  List<Task> _doneTasks = [
    Task(
      id: 'p2',
      title: 'go to jop',
      taskTime: '1:30 PM',
      taskDate: 'August 8, 2022',
    ),
  ];

  List<Task> _archievedTask = [];

  List<Task> get items {
    return [..._items];
  }

  List<Task> get itemsDone {
    return [..._doneTasks];
  }

  List<Task> get itemsArchieved {
    return [..._archievedTask];
  }

  void addTask(String? id,String title, String taskTime, String taskDate,) {
    _items.add(Task(id: id, title: title, taskTime: taskTime, taskDate: taskDate));
    notifyListeners();
  }

  void addTaskToDone(String id) {
    Task task = findTaskById(id, _items);
    deleteTask(id);
    _doneTasks.add(task);
    notifyListeners();
  }

  void addTaskToArchieve(String id,String belongTo) {
    if(belongTo == 'newTask') {
      Task task = findTaskById(id, _items);
      deleteTask(id);
      _archievedTask.add(task);
    } else if(belongTo == 'doneTask') {
      Task task = findTaskById(id, _doneTasks);
      deleteTaskFromDone(id);
      _archievedTask.add(task);
    }
    notifyListeners();
  }

  Task findTaskById(String id, List<Task> listOfTasks) {
    return listOfTasks.firstWhere((item) => item.id == id);
  }

  void deleteTask(String id) {
    Task task = findTaskById(id, _items);
    _items.remove(task);
    notifyListeners();
  }

  void deleteTaskFromDone(String id) {
    Task task = findTaskById(id, _doneTasks);
    _doneTasks.remove(task);
    notifyListeners();
  }

  void deleteTaskFromArchived(String id) {
    Task task = findTaskById(id, _archievedTask);
    _archievedTask.remove(task);
    notifyListeners();
  }
}
