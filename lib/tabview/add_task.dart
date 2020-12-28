import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sql_assginment/dbHelper.dart';
import 'package:sql_assginment/util/colorConverter.dart';
import 'package:sql_assginment/util/textFieldEx.dart';

import '../main.dart';
import '../task.dart';

class AddTask extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyState();
  }
}

class MyState extends State<AddTask> {
  var title;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Add task"),
        ),
        body: Builder(
          builder: (context) {
            return Center(
              child: Container(
                margin: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      decoration: TextBorder.myDecoration("task title"),
                      onChanged: (value) {
                        title = value;
                      },
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 50),
                      alignment: Alignment.center,
                      child: RaisedButton(
                        color: HexColor.fromHex("#606060"),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        child: Container(
                            padding: EdgeInsets.all(18),
                            width: 200,
                            child: Text(
                              "Add task",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            )),
                        onPressed: () async {
                          if (title == null) {
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text("Insert Task Title!"),
                              action: SnackBarAction(
                                  label: "dismiss",
                                  onPressed: () {
                                    Scaffold.of(context).hideCurrentSnackBar();
                                  }),
                            ));
                            return;
                          }
                          var task = Task();
                          task.setValue(title, 0);

                          if (await DbHelper.db.insertTask(task) > 0) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyApp()),
                                ModalRoute.withName(
                                    Navigator.defaultRouteName));
                          } else {
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text("Something error, try again!"),
                              action: SnackBarAction(
                                  label: "dismiss",
                                  onPressed: () {
                                    Scaffold.of(context).hideCurrentSnackBar();
                                  }),
                            ));
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
