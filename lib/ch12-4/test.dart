import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:practice/ch11-1/test.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Test'),
        ),
        body: TestScreen()
      )
    );
  }
}

class TestScreen extends StatefulWidget {
  @override
  TestState createState() => TestState();
}

class TestState extends State<TestScreen> {
  DateTime dateValue = DateTime.now();
  TimeOfDay timeValue = TimeOfDay.now();

  _dialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Dialog Title'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: InputDecoration(border: OutlineInputBorder())
                ),
                Row(
                  children: [
                    Checkbox(
                      value: true,
                      onChanged: (value) {}
                    ),
                    Text('수신동의')
                  ],
                )
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                }, child: Text("OK"),
              )
            ]
          );
        }
    );
  }

  _bottomSheet() {
    showBottomSheet(context: context,
        backgroundColor: Colors.yellow,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.add),
                title: Text('Add'),
                onTap: () {
                  Navigator.of(context).pop();
                }
              ),
              ListTile(
                leading: Icon(Icons.remove),
                title: Text('REMOVE'),
                onTap: () => Navigator.of(context).pop(),
              )
            ]
          );
        }
    );
  }

  _modalBottomSheet() {
    showModalBottomSheet(context: context,
        backgroundColor: Colors.yellow,
        builder: (context) {
          return SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: Icon(Icons.add),
                    title: Text('Add'),
                    onTap: () {
                      Navigator.of(context).pop();
                    }
                  ),
                  ListTile(
                    leading: Icon(Icons.remove),
                    title: Text('REMOVE'),
                    onTap: () => Navigator.of(context).pop(),
                  )
                ]
              )
          );
        }
    );
  }

  Future datePicker() async {
    DateTime? picked = await showDatePicker(context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2016),
        lastDate: new DateTime(2030)
    );
    if (picked != null) setState(() => {dateValue = picked});
  }

  Future timePicker() async {
    TimeOfDay? selectedTime = await showTimePicker(context: context,
        initialTime: new TimeOfDay.now()
    );
    if (selectedTime != null) setState(() => {timeValue = selectedTime});
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(onPressed: _dialog, child: Text('dialog')),
          ElevatedButton(onPressed: _bottomSheet, child: Text('bottomsheet')),
          ElevatedButton(onPressed: _modalBottomSheet, child: Text('modal bottomsheet')),
          ElevatedButton(onPressed: datePicker, child: Text('date picker')),
          Text('date : ${DateFormat('yyyy-MM-dd').format(dateValue)}'),
          ElevatedButton(onPressed: timePicker, child: Text('time picker')),
          Text('date : ${timeValue.hour}:${timeValue.minute}'),
        ],
      ),
    );
  }
}