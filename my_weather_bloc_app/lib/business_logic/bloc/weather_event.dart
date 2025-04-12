part of 'weather_bloc.dart';

class WeatherEvent extends Cubit<WeatherState> {
  WeatherEvent() : super(WeatherState(isLoading: false, response: null));

  void setLoading() => emit(WeatherState(isLoading: state.isLoading));

  void loadWeather() => emit(WeatherState(response: state.response));
}
