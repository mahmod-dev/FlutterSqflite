import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sql_assginment/dbHelper.dart';
import 'package:sql_assginment/task.dart';

class AllTasks extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyState();
  }
}

class MyState extends State<AllTasks> {
  var dbHelper = DbHelper.db;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Container(
            child: Center(
              child: FutureBuilder<List>(
                  future: dbHelper.getAllTasks(),
                  initialData: List(),
                  builder: (context, snapshot) {
                    return snapshot.hasData
                        ? ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              final item = snapshot.data[index];
                              final id = item.row[0];
                              final title = item.row[1];
                              final isCompleted = item.row[2];
                              return ListTile(
                                leading:InkWell(
                                      child: Container(padding: EdgeInsets.all(10),child: Icon(Icons.delete)),
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            Future.delayed(
                                                    Duration(seconds: 10))
                                                .then((_) {
                                              Navigator.pop(context);
                                            });
                                            return AlertDialog(
                                              title: Text(title),
                                              content: Text(
                                                  "Do you want to delete this task"),
                                              actions: [
                                                RaisedButton(
                                                    child: Text("Yes"),
                                                    onPressed: () {
                                                      dbHelper.deleteTask(id);
                                                      setState(() {});

                                                      Navigator.of(context)
                                                          .pop();
                                                    }),
                                                RaisedButton(
                                                    child: Text("No"),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();

                                                      //  Navigator.pop(context);
                                                    }),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    ),
                                title: Text(title),
                                trailing: Checkbox(
                                  value: isCompleted == 1 ? true : false,
                                  onChanged: (value) {
                                    int isFinished = value == true ? 1 : 0;
                                    Task task = Task(title, isFinished);
                                      dbHelper.updateTask(id, task);
                                    setState(() {});
                                  },
                                ),
                              );
                            },
                          )
                        : Center(
                            child: CircularProgressIndicator(),
                          );
                  }),
            ),
          ),
        ),
      ),
    );
  }
}
//                return ListTile(leading: Icon(Icons.delete), title: Text(dbHelper.asStream().first.) ,trailing: Checkbox(onChanged: (value) {
