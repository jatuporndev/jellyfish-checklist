class AppRouter {
  AppRouter._();
  // Singleton instance
  static final AppRouter _instance = AppRouter._();

  // Getter to access the singleton instance
  factory AppRouter() => _instance;

  static const String home = "/home";
  static const String signIn = "/sign_in";
  static const String createRoom = "/create_room";
}