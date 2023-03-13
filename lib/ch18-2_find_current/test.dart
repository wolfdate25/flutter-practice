import 'package:flutter/material.dart';

void main() {
  runApp(ParentWidget());
}

class ParentWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ParentWidgetState();
}

class ParentWidgetState extends State<ParentWidget> {
  bool favorited = false;
  int favoriteCount = 10;
  int childCount = 0;
  GlobalKey<ChildWidgetState> childKey = GlobalKey();

  void toggleFavorite() {
    setState(() {
      favorited = !favorited;
      if (favorited) {
        favoriteCount++;
      } else {
        favoriteCount--;
      }
    });
  }

  void getChildData() {
    ChildWidgetState? childState = childKey.currentState;
    setState(() {
      childCount = childState?.childCount ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text('State Test'),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('I am Parent, child Count: $childCount'),
            ElevatedButton(onPressed: getChildData, child: Text('Get Child Data'))
          ],
        ),
        ChildWidget(key: childKey),
        IconWidget(favorited: favorited, onChanged: toggleFavorite),
        ContentWidget(favoriteCount: favoriteCount),
      ]),
    ));
  }
}

class ChildWidget extends StatefulWidget {
  ChildWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ChildWidgetState();
}

class ChildWidgetState extends State<ChildWidget> {
  int childCount = 0;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(child: Text('I am Child, $childCount')),
      ElevatedButton(
          onPressed: () {
            setState(() {
              childCount++;
            });
          },
          child: Text('Increment'))
    ]);
  }
}

class IconWidget extends StatelessWidget {
  final bool favorited;
  final Function onChanged;

  IconWidget({this.favorited: false, required this.onChanged});

  void _handleTap() {
    onChanged();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(
        icon: (favorited ? Icon(Icons.star) : Icon(Icons.star_border)),
        iconSize: 200,
        color: Colors.red,
        onPressed: _handleTap,
      ),
    );
  }
}

class ContentWidget extends StatelessWidget {
  final int favoriteCount;

  ContentWidget({required this.favoriteCount});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
          child: Text(
        'favoriteCount: $favoriteCount',
        style: TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      ))
    ]);
  }
}
