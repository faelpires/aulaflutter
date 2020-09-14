class EnvironmentConfig {
  static const BASE_API_URL = String.fromEnvironment(
    'BASE_API_URL',
    defaultValue: 'https://demoapifaelpires.azurewebsites.net/api',
  );
}
