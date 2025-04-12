import 'package:dio/dio.dart';
import 'package:my_weather_bloc_app/core/api/api_config.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiClient {
  Dio getDio() {
    Dio dio = Dio(
      BaseOptions(
        baseUrl: ApiConfig.baseUrl,
        connectTimeout: Duration(seconds: 10),
        receiveTimeout: Duration(seconds: 10),
      ),
    );

    /// This logs requests and responses in a pretty format.
    dio.interceptors.add(PrettyDioLogger(
      responseHeader: true,
      requestHeader: true,
      responseBody: true,
      requestBody: true,
      request: true,
      compact: false,
    ));

    return dio;
  }
}
