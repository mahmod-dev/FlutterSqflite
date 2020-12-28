import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sql_assginment/dbHelper.dart';

import '../task.dart';

class UnCompletedTasks extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Mystate();
  }
}

class Mystate extends State<UnCompletedTasks> {
  var dbHelper = DbHelper.db;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Center(child: ListView.builder(
          itemBuilder: (context, index) {
            Task task = Provider.of<Task>(context).getList()[index];

            return ListTile(
              leading: InkWell(
                child: Container(
                    padding: EdgeInsets.all(10), child: Icon(Icons.delete)),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      Future.delayed(Duration(seconds: 10)).then((_) {
                        Navigator.pop(context);
                      });
                      return AlertDialog(
                        title: Text(task.title),
                        content: Text("Do you want to delete this task"),
                        actions: [
                          RaisedButton(
                              child: Text("Yes"),
                              onPressed: () {
                                dbHelper.deleteTask(task.id);
                                setState(() {});

                                Navigator.of(context).pop();
                              }),
                          RaisedButton(
                              child: Text("No"),
                              onPressed: () {
                                Navigator.of(context).pop();

                                //  Navigator.pop(context);
                              }),
                        ],
                      );
                    },
                  );
                },
              ),
              title: Text(task.title),
              trailing: Checkbox(
                value: task.isFinished == 1 ? true : false,
                onChanged: (value) {
                  int isFinished = value == true ? 1 : 0;
                  print(isFinished);
                  dbHelper.updateTask(task.id, task);
                },
              ),
            );
          },
        )),
      ),
    );
  }
}
