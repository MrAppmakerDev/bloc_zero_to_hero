import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_weather_bloc_app/business_logic/bloc/weather_bloc.dart';
import 'package:my_weather_bloc_app/presentation/widgets/custom_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text('Weather BloC App'),
            centerTitle: true,
          ),
          body: BlocConsumer<WeatherBloc, WeatherState>(
            listener: (context, state) {
              if (state.status == WeatherStatus.failure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.error?.message ?? 'An error occurred!'),
                  ),
                );
              } else if (state.status == WeatherStatus.loading) {
                CircularProgressIndicator();
              }
            },
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.sunny,
                    size: 250.0,
                    color: Colors.yellow[300],
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    controller: textController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(10.0),
                        hintText: 'Enter the city?'),
                  ),
                  SizedBox(height: 10.0),
                  CustomButton(
                    onPressed: () {
                      context.read<WeatherBloc>().add(RefreshWeatherDataEvent(
                          location: textController.text));
                    },
                    text: 'Submit',
                    backgroundColor: Colors.yellow[300],
                  ),
                ],
              );
            },
          )),
    );
  }
}
