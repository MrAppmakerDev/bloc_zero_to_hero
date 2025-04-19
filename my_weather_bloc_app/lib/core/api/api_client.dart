import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
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

    dio.interceptors.add(
      RetryInterceptor(
        dio: dio,
        logPrint: print, // logs retry attempts
        retries: 3, // total retry attempts
        retryDelays: const [
          Duration(seconds: 3), // 1st retry after 3s
          Duration(seconds: 5), // 2nd retry after 5s
          Duration(seconds: 7), // 3rd retry after 7s
        ],
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
