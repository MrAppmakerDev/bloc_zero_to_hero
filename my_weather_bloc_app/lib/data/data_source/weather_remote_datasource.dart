import 'package:dio/dio.dart';
import 'package:my_weather_bloc_app/core/api/api_config.dart';
import 'package:my_weather_bloc_app/core/model/either.dart';

class WeatherRemoteDatasource {
  final Dio dio;

  WeatherRemoteDatasource({required this.dio});

  Future<Either<dynamic, dynamic>> getRawWeatherData(String location) async {
    try {
      final response = await dio.get(
        '/current.json',
        queryParameters: {
          'key': ApiConfig.apiKey,
          'q': location,
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        return Either.right(response.data as Map<String, dynamic>);
      } else {
        // Handle API errors
        return Either.left(response.data as Map<String, dynamic>);
      }
    } on DioException catch (e) {
      if (e.response != null) {
        // Handle DioException
        return Either.left(e.response as Map<String, dynamic>);
      } else {
        // Handle network errors
        final errorCode = -1;
        final errorMessage = 'Network error: ${e.toString()}';
        final data = {'error': errorCode, 'message': errorMessage};
        return Either.left(data as Map<String, dynamic>);
      }
    } catch (e) {
      // Handle unexpected errors
      final errorCode = -2;
      final errorMessage = 'An unexpected error occurred: ${e.toString()}';
      final data = {'error': errorCode, 'message': errorMessage};
      return Either.left(data as Map<String, dynamic>);
    }
  }
}
