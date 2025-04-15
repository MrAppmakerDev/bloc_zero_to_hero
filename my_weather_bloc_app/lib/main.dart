import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_weather_bloc_app/business_logic/bloc/weather_bloc.dart';
import 'package:my_weather_bloc_app/core/get_it/get_it.dart';
import 'package:my_weather_bloc_app/presentation/pages/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setup();
  runApp(
    BlocProvider(
      create: (context) => getIt<WeatherBloc>(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather BloC App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
      ),
      home: HomePage(),
    );
  }
}
