part of 'weather_bloc.dart';

class WeatherState {
  WeatherResponse? response;
  bool? isLoading;

  WeatherState({
    this.isLoading,
    this.response,
  });
}
