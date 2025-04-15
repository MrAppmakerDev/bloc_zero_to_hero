part of 'weather_bloc.dart';

abstract class WeatherEvent {}

class RefreshWeatherDataEvent extends WeatherEvent {
  final String location;

  RefreshWeatherDataEvent({required this.location});
}
