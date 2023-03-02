import 'package:flutter/material.dart';

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
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Container(
                    height: 300,
                    child: Row(
                      children: [
                        Container(color: Colors.red, width: 100),
                        Expanded(flex:1,child: Container(color: Colors.amber)),
                        Expanded(flex:1,child: Container(color: Colors.yellow))

                      ]
                    ),
                  ),
                  Container(
                    color:Colors.green,
                    height:300,
                    child: Row(
                        children: [
                          Container(color: Colors.red, width: 100),
                          Expanded(child: Container(color: Colors.amber)),
                          Expanded(child: Container(color: Colors.yellow)),
                          Spacer(),
                          Expanded(child: Container(color: Colors.yellow))
                        ]
                    ),
                  ),
                  Container(
                    color: Colors.blue,
                    height: 300
                  )
                ],
              ),
            )
        )
    );
  }
}