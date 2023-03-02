import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  onPressed() {
    print('icon button click...');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Test'),
        ),
        body: Column(
          children: [
            GestureDetector(
              child: Image.asset('images/icon/user.png'),
              onTap: () {
                print('image click...');
              },
              onVerticalDragStart: (DragStartDetails details) {
                print('onVerticalDragStart global posision : '
                    '${details.globalPosition.dx}'
                    '${details.globalPosition.dy}');
                print('onVerticalDragStart local posision : '
                    '${details.localPosition.dx}'
                    '${details.localPosition.dy}');
              },
            ),
            ElevatedButton(onPressed: onPressed, child: Text('Click Me'),
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
            )
          ],
        ),
      ),
    );
  }
}
