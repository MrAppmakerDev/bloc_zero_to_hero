class ApiConfig {
  /// under run configuration add args = --dart-define=API_KEY=YourAPIKey
  /// or, flutter run --dart-define=API_KEY=YourAPIKey
  ///
  /// flutter build web --dart-define=API_KEY=your_actual_api_key
  /// --obfuscate --split-debug-info=build/debug-info
  static const String baseUrl = String.fromEnvironment('BASE_URL',
      defaultValue: 'http://api.weatherapi.com/v1/');
}
