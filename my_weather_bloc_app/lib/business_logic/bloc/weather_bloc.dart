import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_weather_bloc_app/core/api/api_client.dart';
import 'package:my_weather_bloc_app/core/get_it/get_it.dart';
import 'package:my_weather_bloc_app/data/model/weather_error.dart';
import 'package:my_weather_bloc_app/data/model/weather_model.dart';
import 'package:my_weather_bloc_app/data/repository/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository repository;
  late final StreamSubscription _timeoutSubscriber;

  WeatherBloc({required this.repository}) : super(WeatherState.initial()) {
    // 1️ - subscribe to ApiClient's timeout stream
    final apiClient = getIt<ApiClient>();
    _timeoutSubscriber = apiClient.onFirstTimeout.listen((_) {
      add(WeatherTimeoutEvent());
    });

    on<RefreshWeatherDataEvent>(onRefreshWeatherDataEvent);
    on<WeatherTimeoutEvent>(onWeatherTimeoutEvent);
  }

  Future<void> onRefreshWeatherDataEvent(
      RefreshWeatherDataEvent event, Emitter emit) async {
    emit(state.copyWith(status: WeatherStatus.loading));
    var data = await repository.getWeatherData(event.location);
    if (data.isLeft()) {
      if (data.left.code == 500) {
        emit(state.copyWith(status: WeatherStatus.timeout, error: data.left));
      } else {
        emit(state.copyWith(status: WeatherStatus.failure, error: data.left));
      }
    } else {
      emit(state.copyWith(status: WeatherStatus.success, response: data.right));
    }
  }

  void onWeatherTimeoutEvent(
    WeatherTimeoutEvent event,
    Emitter emit,
  ) {
    // immediately show TIME_OUT state
    emit(state.copyWith(
      status: WeatherStatus.timeout,
      error: WeatherError(
        code: -1,
        message: 'Please wait. Server Restarting...',
      ),
    ));
  }

  @override
  Future<void> close() {
    _timeoutSubscriber.cancel();
    return super.close();
  }
}
