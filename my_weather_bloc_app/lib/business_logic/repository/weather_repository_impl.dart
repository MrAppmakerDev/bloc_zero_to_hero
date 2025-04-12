import 'package:my_weather_bloc_app/core/model/either.dart';
import 'package:my_weather_bloc_app/data/data_source/weather_remote_datasource.dart';
import 'package:my_weather_bloc_app/data/model/weather_error.dart';
import 'package:my_weather_bloc_app/data/model/weather_model.dart';
import 'package:my_weather_bloc_app/data/repository/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDatasource datasource;

  WeatherRepositoryImpl({required this.datasource});

  @override
  Future<Either<WeatherError, WeatherResponse>> getWeatherData(
      String location) async {
    final data = await datasource.getRawWeatherData(location);
    if (data.isRight()) {
      return Either.right(WeatherResponse.fromJson(data.right));
    } else {
      return Either.left(WeatherError.fromJson(data.left));
    }
  }
}
