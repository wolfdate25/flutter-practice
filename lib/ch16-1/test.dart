import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Future<int> sum() {
    return Future<int>(() {
      var sum = 0;
      for (int i = 0; i < 500000000; i++) {
        sum += i;
      }
      return sum;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Future'),
        ),
        body: Center(
          child: FutureBuilder<int>(
            future: sum(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text('Sum: ${snapshot.data}');
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );

  }
}