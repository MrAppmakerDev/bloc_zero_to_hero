import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bloc_app/cubit/counter_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterCubit(),
      child: MaterialApp(
        title: 'Flutter Demo',
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  // to initialize the instance
  // final _counter = CounterCubit();
  // int _state = 0;

  // to listen to the events and set the state
  // @override
  // void initState() {
  //   _counter.stream.listen(
  //     (event) => setState(() {
  //       _state = event;
  //     }),
  //   );
  //   super.initState();
  // }

  // to free the instance
  // @override
  // void dispose() {
  //   _counter.close();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Cubit App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            BlocBuilder<CounterCubit, CounterState>(
              builder: (context, state) {
                return Text(
                  state.counter < 0
                      ? 'Brr! ${state.counter}'
                      : state.counter % 2 == 0
                          ? 'Hurray! ${state.counter}'
                          : 'Hmm! ${state.counter}',
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  onPressed: () =>
                      BlocProvider.of<CounterCubit>(context).decrement(),
                  tooltip: 'decrement',
                  child: const Icon(Icons.remove),
                ),
                FloatingActionButton(
                  onPressed: () =>
                      BlocProvider.of<CounterCubit>(context).increment(),
                  tooltip: 'increment',
                  child: const Icon(Icons.add),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

// class CounterCubit extends Cubit<int> {
//   CounterCubit() : super(0);

//   void increment() => emit(state + 1);
//   void decrement() => emit(state - 1);
// }

// enum CounterEvent { increment, decrement }

// class CounterBloc extends Bloc<CounterEvent, int> {
//   CounterBloc() : super(0) {
//     on<CounterEvent>((event, emit) {
//       switch (event) {
//         case CounterEvent.increment:
//           emit(state + 1);
//         case CounterEvent.decrement:
//           emit(state - 1);
//       }
//     });
//   }
// }
