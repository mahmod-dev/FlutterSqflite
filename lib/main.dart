import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sql_assginment/tabview/add_task.dart';
import 'package:sql_assginment/tabview/all_tasks.dart';
import 'package:sql_assginment/tabview/completed_tasks.dart';
import 'package:sql_assginment/tabview/uncompleted_tasks.dart';
import 'package:sql_assginment/task.dart';

import 'dbHelper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyStatefull();
  }
}

class MyStatefull extends State<MyApp> with SingleTickerProviderStateMixin {
  TabController controller;
  var key = GlobalKey<ScaffoldState>();
  var dbHelper = DbHelper.db;

  @override
  void initState() {
    super.initState();

    controller = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    Future<List<Task>> map = dbHelper.getAllTasks();
    map.then((value) {
      //Provider.of<Task>(context, listen: false).setList(value);
    });

    return Provider(
      create: (context) {
        return Task();
      },
      child: MaterialApp(
        title: "Sql app",
        home: Scaffold(
          key: key,
          appBar: AppBar(
            title: Text("ToDo App"),
            bottom: TabBar(isScrollable: true, controller: controller, tabs: [
              Container(padding: EdgeInsets.all(5), child: Text("All tasks")),
              Container(
                  padding: EdgeInsets.all(5), child: Text("completed tasks")),
              Container(
                  padding: EdgeInsets.all(5), child: Text("Uncompleted tasks"))
            ]),
          ),
          body: Center(
              child: TabBarView(
            children: [AllTasks(), CompletedTasks(), UnCompletedTasks()],
            controller: controller,
          )),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(key.currentState.context,
                  MaterialPageRoute(builder: (context) {
                return AddTask();
              }));
            },
            tooltip: 'Add task',
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
