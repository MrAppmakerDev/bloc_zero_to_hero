import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_weather_bloc_app/data/model/weather_error.dart';
import 'package:my_weather_bloc_app/data/model/weather_model.dart';
import 'package:my_weather_bloc_app/data/repository/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository repository;
  WeatherBloc({required this.repository}) : super(WeatherState.initial()) {
    on<RefreshWeatherDataEvent>(onRefreshWeatherDataEvent);
  }

  Future<void> onRefreshWeatherDataEvent(
      RefreshWeatherDataEvent event, Emitter emit) async {
    emit(state.copyWith(status: WeatherStatus.loading));
    var data = await repository.getWeatherData(event.location);
    if (data.isLeft()) {
      emit(state.copyWith(status: WeatherStatus.failure, error: data.left));
    } else {
      emit(state.copyWith(status: WeatherStatus.success, response: data.right));
    }
  }
}
