// To parse this JSON data, do
//
//     final weatherError = weatherErrorFromJson(jsonString);

import 'dart:convert';

WeatherError weatherErrorFromJson(String str) =>
    WeatherError.fromJson(json.decode(str));

String weatherErrorToJson(WeatherError data) => json.encode(data.toJson());

class WeatherError {
  final int code;
  final String message;

  WeatherError({
    required this.code,
    required this.message,
  });

  WeatherError copyWith({
    int? code,
    String? message,
  }) =>
      WeatherError(
        code: code ?? this.code,
        message: message ?? this.message,
      );

  factory WeatherError.fromJson(Map<String, dynamic> json) => WeatherError(
        code: json["code"] ?? -3,
        message: json["message"] ?? 'Unexpected error occurred at server side!',
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
      };
}
