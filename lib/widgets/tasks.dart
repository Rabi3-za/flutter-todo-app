import 'package:flutter/material.dart';

import '../screens/archived_screen.dart';
import '../screens/done_screen.dart';
import '../screens/tasks_screen.dart';

class Tasks extends StatefulWidget {
  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  final List<Map<String, Object>> _pages = [
    {
      'page': TasksScreen(),
      'title': 'New Tasks',
    },
    {
      'page': DoneScreen(),
      'title': 'Done Tasks',
    },
    {
      'page': ArchivedScreen(),
      'title': 'Archived Tasks',
    }
  ];
  int _selectPageIndex = 0;

  void _selectedPage(int index) {
    setState(() {
      _selectPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: Text(_pages[_selectPageIndex]['title'], style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: _pages[_selectPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectedPage,
        currentIndex: _selectPageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done),
            label: 'Done',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.archive),
            label: 'Archived',
          ),
        ],
      ),
    );
  }
}
