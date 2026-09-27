class AppConfig {
  static const Duration debounceDuration = Duration(milliseconds: 900); // per rispettare policy BE
  static const String braveApiKey = String.fromEnvironment('BRAVE_API_KEY'); // TODO cosi fa schifo
}
