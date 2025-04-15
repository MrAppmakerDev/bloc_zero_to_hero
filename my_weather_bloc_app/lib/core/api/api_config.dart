class ApiConfig {
  static const String apiKey = String.fromEnvironment('API_KEY',
      defaultValue: 'ce8e595838a0443a9cd192331251104');
  static const String baseUrl = String.fromEnvironment('BASE_URL',
      defaultValue: 'http://api.weatherapi.com/v1/');
}
