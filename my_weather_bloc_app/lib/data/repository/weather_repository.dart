import 'package:my_weather_bloc_app/core/model/either.dart';
import 'package:my_weather_bloc_app/data/model/weather_error.dart';
import 'package:my_weather_bloc_app/data/model/weather_model.dart';

abstract class WeatherRepository {
  Future<Either<WeatherError, WeatherResponse>> getWeatherData(String location);
}
