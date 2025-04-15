import 'package:get_it/get_it.dart';
import 'package:my_weather_bloc_app/business_logic/bloc/weather_bloc.dart';
import 'package:my_weather_bloc_app/business_logic/repository/weather_repository_impl.dart';
import 'package:my_weather_bloc_app/core/api/api_client.dart';
import 'package:my_weather_bloc_app/data/data_source/weather_remote_datasource.dart';
import 'package:my_weather_bloc_app/data/repository/weather_repository.dart';

final GetIt getIt = GetIt.instance;

void setup() {
  print('called 1');
  registerApiClient();
  print('called 2');
  registerDatasource();
  print('called 3');
  registerRepository();
  print('called 4');
  registerBloc();
  print('called 5');
}

/// remember: always add a type to register

void registerApiClient() => getIt.registerSingleton<ApiClient>(ApiClient());

void registerDatasource() {
  getIt.registerLazySingleton<WeatherRemoteDatasource>(() {
    final dio = getIt.get<ApiClient>().getDio();
    return WeatherRemoteDatasource(dio: dio);
  });
}

void registerRepository() => getIt.registerSingleton<WeatherRepository>(
      WeatherRepositoryImpl(
        datasource: getIt(),
      ),
    );

void registerBloc() => getIt.registerFactory<WeatherBloc>(
      () => WeatherBloc(
        repository: getIt(),
      ),
    );
