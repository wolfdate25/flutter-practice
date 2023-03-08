import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<MyApp> with SingleTickerProviderStateMixin {
  late TabController controller;

  @override void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
  }

  @override void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('TabBar Test'),
          bottom: TabBar(
            controller: controller,
            tabs: [
              Tab(icon: Icon(Icons.home), text: 'Home'),
              Tab(icon: Icon(Icons.search), text: 'Search'),
              Tab(icon: Icon(Icons.settings), text: 'Settings'),
            ],
          ),
        ),
        body: TabBarView(
          controller: controller,
          children: [
            Center(child: Text('Home')),
            Center(child: Text('Search')),
            Center(child: Text('Settings')),
          ],
        ),
      ),
    );
  }
}