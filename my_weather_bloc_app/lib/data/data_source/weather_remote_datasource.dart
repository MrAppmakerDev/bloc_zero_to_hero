import 'package:dio/dio.dart';
import 'package:my_weather_bloc_app/core/model/either.dart';

class WeatherRemoteDatasource {
  final Dio dio;

  WeatherRemoteDatasource({required this.dio});

  Future<Either<Map<String, dynamic>, Map<String, dynamic>>> getRawWeatherData(
      String location) async {
    try {
      final response = await dio.get(
        '/api/weather',
        queryParameters: {
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
      print('print: ${e.type}');
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        final errorCode = 500;
        final errorMessage = 'Server error: ${e.toString()}';
        final data = {'code': errorCode, 'message': errorMessage};
        return Either.left(data as Map<String, dynamic>);
      }

      if (e.response != null && e.response?.data != null) {
        // Handle DioException
        return Either.left(e.response?.data as Map<String, dynamic>);
      } else {
        // Handle network errors
        final errorCode = -1;
        final errorMessage = 'Network error: ${e.toString()}';
        final data = {'code': errorCode, 'message': errorMessage};
        return Either.left(data as Map<String, dynamic>);
      }
    } catch (e) {
      // Handle unexpected errors
      final errorCode = -2;
      final errorMessage = 'An unexpected error occurred: ${e.toString()}';
      final data = {'code': errorCode, 'message': errorMessage};
      return Either.left(data as Map<String, dynamic>);
    }
  }
}
