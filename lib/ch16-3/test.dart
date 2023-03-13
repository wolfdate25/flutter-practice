import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  int calFun(int x) {
    return x * x;
  }

  Stream<int> test() {
    Duration duration = Duration(seconds: 3);
    Stream<int> stream = Stream<int>.periodic(duration, calFun);
    return stream.take(5);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Test'),
        ),
        body: Center(
          child: StreamBuilder(
            stream: test(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Center(
                  child: Text(
                    'Completed',
                    style: TextStyle(fontSize: 30),
                  )
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: CircularProgressIndicator(),
                      ),
                      Text(
                        'waiting...',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      )
                    ],
                  )
                );
              } else if (snapshot.connectionState == ConnectionState.active) {
                return Center(
                  child: Text(
                    '${snapshot.data}',
                    style: TextStyle(fontSize: 30),
                  )
                );
              } else {
                return Center(
                  child: Text(
                    'Error',
                    style: TextStyle(fontSize: 30),
                  )
                );
              }
            },
          ),
        ),
      )
    );
  }

}

