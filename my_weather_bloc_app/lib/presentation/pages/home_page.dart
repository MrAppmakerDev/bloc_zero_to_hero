import 'package:flutter/foundation.dart';
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
  final _formKey = GlobalKey<FormState>();
  final _cityController = TextEditingController();

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    double horizontalPadding;

    if (screenWidth > 1200) {
      horizontalPadding = 500; // for desktop screens
    } else if (screenWidth >= 768) {
      horizontalPadding = 100; // for tablet screens
    } else {
      horizontalPadding = 16; // for mobile screens
    }
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Weather BloC App'),
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
            }
          },
          builder: (context, state) {
            return switch (state.status) {
              WeatherStatus.loading => const Center(
                  child: CircularProgressIndicator(),
                ),
              _ => Padding(
                  padding: kIsWeb
                      ? EdgeInsets.symmetric(horizontal: horizontalPadding)
                      : EdgeInsets.all(16.0),
                  // Add padding for better layout
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      // Stretch for better button layout
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.sunny,
                          size: 150.0, // Reduced size for better fit
                          color: Colors.yellow[300],
                        ),
                        state.status == WeatherStatus.success
                            ? Text(
                                '${state.response?.location.name}',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            : SizedBox.shrink(),
                        state.status == WeatherStatus.success
                            ? Text(
                                '${state.response?.location.country}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : SizedBox.shrink(),
                        state.status == WeatherStatus.success
                            ? Text(
                                '${state.response?.current.condition.text}',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                ),
                              )
                            : SizedBox.shrink(),
                        const SizedBox(height: 20.0),
                        TextFormField(
                          controller: _cityController,
                          decoration: const InputDecoration(
                            labelText: 'City',
                            // Use labelText instead of hintText for better accessibility
                            border: OutlineInputBorder(),
                            // Add a visible border
                            contentPadding:
                                EdgeInsets.all(12.0), // Adjust padding
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'City cannot be empty'; // More direct error message
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20.0),
                        CustomButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // Dispatch event here
                              context.read<WeatherBloc>().add(
                                    RefreshWeatherDataEvent(
                                        location: _cityController.text),
                                  );
                            }
                          }, // Add vertical padding
                          text: 'Get Weather',
                          backgroundColor: Colors
                              .yellow[300], // More descriptive button text
                        ),
                      ],
                    ),
                  ),
                ),
            };
          },
        ),
      ),
    );
  }
}
