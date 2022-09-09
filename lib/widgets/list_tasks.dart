import 'package:flutter/material.dart';

class ListTasks extends StatelessWidget {
  final from;
  final data;
  final Function deleteFn;
  final Function moveToDoneFn;
  final Function moveToArchiveFn;

  ListTasks(this.from, this.data, this.deleteFn, this.moveToDoneFn,
      this.moveToArchiveFn);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: data.length <= 0
          ? Center(
              child: Text('No tasks yet, start add one!'),
            )
          : ListView.builder(
              itemCount: data.length,
              itemBuilder: ((context, index) => Dismissible(
                    key: ValueKey(data[index].id),
                    background: Container(
                      color: Theme.of(context).errorColor,
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(
                        right: 20,
                      ),
                    ),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      deleteFn(data[index].id);
                    },
                    confirmDismiss: (direction) {
                      return showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: Text('Are you sure?'),
                          content: Text(
                              'Do you want to remove the task from the list?'),
                          actions: [
                            FlatButton(
                              child: Text('No'),
                              onPressed: () {
                                Navigator.of(ctx).pop(false);
                              },
                            ),
                            FlatButton(
                              child: Text('Yes'),
                              onPressed: () {
                                Navigator.of(ctx).pop(true);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Card(
                        elevation: 20,
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.blue,
                            child: FittedBox(
                              child: Text(data[index].taskTime),
                            ),
                          ),
                          title: Text(
                            data[index].title,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Text(
                              data[index].taskDate,
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  moveToDoneFn(data[index].id);
                                },
                                icon: Icon(
                                  Icons.check,
                                  color: Colors.green,
                                ),
                              ),
                              SizedBox(
                                width: 13,
                              ),
                              IconButton(
                                onPressed: () {
                                  moveToArchiveFn(data[index].id, from);
                                },
                                icon: Icon(Icons.archive),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )),
            ),
    );
  }
}
