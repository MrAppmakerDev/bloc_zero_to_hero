import 'package:bloc/bloc.dart';

Future<void> main(List<String> args) async {
  final bloc = CounterBloc();
  final subscriber = bloc.stream.listen(print);

  // print(cubit.state);

  bloc.add(CounterEvent.increment);
  // print(cubit.state); // increases state + 1 = 1

  bloc.add(CounterEvent.increment);
  // print(cubit.state); // increases state + 1 = 2

  bloc.add(CounterEvent.increment);
  // print(cubit.state); // increases state + 1 = 3

  bloc.add(CounterEvent.decrement);
  // print(cubit.state); // decreases state - 1 = 2

  bloc.add(CounterEvent.decrement);
  // print(cubit.state); // decreases state - 1 = 1

  await Future.delayed(Duration(seconds: 1));
  await subscriber.cancel();
  // cubit.close();
}

// class CounterCubit extends Cubit<int> {
//   CounterCubit() : super(0);

//   void counterInc() => emit(state + 1);
//   void counterDec() => emit(state - 1);
// }

enum CounterEvent { increment, decrement }

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<CounterEvent>(
      (event, emit) {
        switch (event) {
          case CounterEvent.increment:
            emit(state + 1);
          case CounterEvent.decrement:
            emit(state - 1);
        }
      },
    );
  }
}
