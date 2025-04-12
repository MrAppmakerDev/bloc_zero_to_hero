import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_weather_bloc_app/data/model/weather_model.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherState()) {
    on<WeatherEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
