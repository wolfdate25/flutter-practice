import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);
  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);
}

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Cubit Test')),
        body: BlocProvider(
          create: (context) => CounterCubit(),
          child: MyWidget(),
        ),
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<CounterCubit>(context);
    return BlocBuilder<CounterCubit, int>(
      builder: (context, state) {
        return Column(
          children: [
            Text('Cubit: $state'),
            ElevatedButton(
              child: Text('Increment'),
              onPressed: () => cubit.increment(),
            ),
            ElevatedButton(
              child: Text('Decrement'),
              onPressed: () => cubit.decrement(),
            ),
          ],
        );
      },
    );
  }
}