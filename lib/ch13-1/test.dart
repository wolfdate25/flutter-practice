import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.orange,
          foregroundColor: Colors.black,
        )
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Test'),
        ),
        body: Center(
          child: Column(
            children: [
              ElevatedButton(onPressed: (){}, child: Text('Button')),
              Checkbox(value: true, onChanged: (value) {}),
              Text('HelloWord')
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add),
        )
      )
    );
  }

}