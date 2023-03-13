import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  String result = '';

  dioTest() async {
    try {
      var dio = Dio(BaseOptions(
        baseUrl: 'https://reqres.in/api/',
        connectTimeout: Duration(seconds: 5),
        receiveTimeout: Duration(seconds: 3),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
        },
      ));
      List<Response> responses = await Future.wait([
        dio.get('users?page=1'),
        dio.get('users?page=2'),
      ]);
      responses.forEach((element) {
        if (element.statusCode == 200) {
          setState(() {
            result += element.data.toString();
          });
        }
      });
    } catch (e) {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Dio'),
        ),
        body: Center(
          child: Column(
            children: [
              TextButton(
                onPressed: () {
                  dioTest();
                },
                child: Text('Get Server Data'),
              ),
              Text(result),
            ],
          ),
        ),
      ),
    );
  }
}
