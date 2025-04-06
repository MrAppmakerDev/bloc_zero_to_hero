import 'package:bloc/bloc.dart';

Future<void> main(List<String> args) async {
  final cubit = CounterCubit();
  final subscriber = cubit.stream.listen(print);

  // print(cubit.state);

  cubit.counterInc();
  // print(cubit.state); // increases state + 1 = 1

  cubit.counterInc();
  // print(cubit.state); // increases state + 1 = 2

  cubit.counterInc();
  // print(cubit.state); // increases state + 1 = 3

  cubit.counterDec();
  // print(cubit.state); // decreases state - 1 = 2

  cubit.counterDec();
  // print(cubit.state); // decreases state - 1 = 1

  await Future.delayed(Duration(seconds: 1));
  await subscriber.cancel();
  // cubit.close();
}

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void counterInc() => emit(state + 1);
  void counterDec() => emit(state - 1);
}
