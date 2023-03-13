import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class CounterEvent {
  int no;

  CounterEvent(this.no);
}

class IncrementEvent extends CounterEvent {
  IncrementEvent(int no) : super(no);
}

class DecreaseEvent extends CounterEvent {
  DecreaseEvent(int no) : super(no);
}

class BlocCounter extends Bloc<CounterEvent, int> {
  BlocCounter() : super(0) {
    on<IncrementEvent>((event, emit) {
      emit(state + event.no);
    });
    on<DecreaseEvent>((event, emit) {
      emit(state - event.no);
    });
  }

  @override
  void onEvent(CounterEvent event) {
    super.onEvent(event);
  }

  @override
  void onTransition(Transition<CounterEvent, int> transition) {
    super.onTransition(transition);
    print('transition : $transition');
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    print('error : $error');
  }
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text('Bloc Test'),
            ),
            body: BlocProvider(
                create: (context) => BlocCounter(),
                child: BlocCounterWidget())));
  }
}

class BlocCounterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocCounter, int>(
        builder: (BuildContext context, int state) {
      return Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Bloc Counter : $state',
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          ElevatedButton(
              onPressed: () {
                BlocProvider.of<BlocCounter>(context).add(IncrementEvent(1));
              },
              child: Text('Increment')),
          ElevatedButton(
              onPressed: () {
                BlocProvider.of<BlocCounter>(context).add(DecreaseEvent(1));
              },
              child: Text('Decrease')),
        ],
      ));
    });
  }
}
