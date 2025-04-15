class ApiConfig {
  /// under run configuration add args = --dart-define=API_KEY=YourAPIKey
  /// or, flutter run --dart-define=API_KEY=YourAPIKey
  static const String apiKey =
      String.fromEnvironment('API_KEY', defaultValue: '');
  static const String baseUrl = String.fromEnvironment('BASE_URL',
      defaultValue: 'http://api.weatherapi.com/v1/');
}
