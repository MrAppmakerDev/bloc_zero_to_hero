part of 'weather_bloc.dart';

enum WeatherStatus { initial, loading, success, failure }

class WeatherState {
  WeatherResponse? response;
  WeatherError? error;
  WeatherStatus? status;

  WeatherState._({
    this.response,
    this.error,
    required this.status,
  });

  factory WeatherState.initial() =>
      WeatherState._(status: WeatherStatus.initial);

  WeatherState copyWith(
      {WeatherResponse? response, WeatherError? error, WeatherStatus? status}) {
    return WeatherState._(
      response: response ?? this.response,
      error: error ?? this.error,
      status: status ?? this.status,
    );
  }
}
