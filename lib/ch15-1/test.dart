import 'dart:convert';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAppState();
}

class Todo {
  int id;
  String title;
  bool completed;

  Todo(this.id, this.title, this.completed);
  Todo.fromJson(Map<String,dynamic> json) :
      id = json['id'], title = json['title'], completed = json['completed'];

  Map<String, dynamic> toJson() => {'id': id, 'title': title, 'completed': completed};
}

class MyAppState extends State<MyApp> {
  String jsonStr = '{"id": 1, "title": "Hello", "completed": false}';
  Todo? todo;
  String result = '';

  onPressDecode() {
    setState(() {
      result = "decode : id: ${todo?.id}, title: ${todo?.title}, completed: ${todo?.completed}";
    });
  }

  onPressEncode() {
    setState(() {
      result = "encode : ${jsonEncode(todo)}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('JSON'),
        ),
        body: Center(
          child: Column(
            children: [
              TextButton(
                onPressed: () {
                  todo = Todo.fromJson(jsonDecode(jsonStr));
                  onPressDecode();
                },
                child: Text('Decode'),
              ),
              TextButton(
                onPressed: () {
                  todo = Todo(1, 'Hello', false);
                  onPressEncode();
                },
                child: Text('Encode'),
              ),
              Text(result),
            ],
          ),
        ),
      ),
    );
  }

}