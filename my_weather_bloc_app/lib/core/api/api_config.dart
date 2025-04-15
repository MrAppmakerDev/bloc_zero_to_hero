class ApiConfig {
  static const String apiKey = String.fromEnvironment('API_KEY',
      defaultValue: '');
  static const String baseUrl = String.fromEnvironment('BASE_URL',
      defaultValue: 'http://api.weatherapi.com/v1/');
}
