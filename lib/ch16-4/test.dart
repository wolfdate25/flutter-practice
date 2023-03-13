import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  subscriptionTest() {
    var stream = Stream.fromIterable([1,2,3,]);
    StreamSubscription subscription = stream.listen(null);
    subscription.onData((data) {
      print('value: $data');
    });
    subscription.onError((error) {
      print('error: $error');
    });
    subscription.onDone(() {
      print('stream done');
    });
  }

  controllerTest() {
    var controller = StreamController();
    var stream1 = Stream.fromIterable([1,2,3,]);
    var stream2 = Stream.fromIterable(['A','B','C',]);

    stream1.listen((value) {
      controller.add(value);
    });

    stream2.listen((value) {
      controller.add(value);
    });

    controller.stream.listen((value) {
      print('value: $value');
    });
  }

  transformerTest() {
    var stream = Stream.fromIterable([1,2,3,]);
    StreamTransformer<int, dynamic> transformer = StreamTransformer.fromHandlers(
      handleData: (data, sink) {
        print('in transformer... $data');
        sink.add(data * data);
      }
    );
    stream.transform(transformer).listen((value) {
      print('in listen...: $value');
    });
  }
  // Each ElevatedButton holding a different stream
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text('Test'),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    child: Text('Subscription'),
                    onPressed: () {
                      subscriptionTest();
                      
                    },
                  ),
                  ElevatedButton(
                    child: Text('Controller'),
                    onPressed: () {
                      controllerTest();
                    },
                  ),
                  ElevatedButton(
                    child: Text('Transformer'),
                    onPressed: () {
                      transformerTest();
                    },
                  ),
                ],
              ),
            )
        )
    );
  }
}