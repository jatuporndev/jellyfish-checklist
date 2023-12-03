class AppStrings {
  AppStrings._();

  // Singleton instance
  static final AppStrings _instance = AppStrings._();

  // Getter to access the singleton instance
  factory AppStrings() => _instance;

  static const strNoRouteFound = "no_route_found";
  static const strAppName = "Ruammitr";
  static const String success = "success";

  // error handler
  static const String strBadRequestError = "bad_request_error";
  static const String strNoContent = "no_content";
  static const String strForbiddenError = "forbidden_error";
  static const String strUnauthorizedError = "unauthorized_error";
  static const String strNotFoundError = "not_found_error";
  static const String strConflictError = "conflict_error";
  static const String strInternalServerError = "internal_server_error";
  static const String strUnknownError = "unknown_error";
  static const String strTimeoutError = "timeout_error";
  static const String strDefaultError = "default_error";
  static const String strCacheError = "cache_error";
  static const String strNoInternetError = "no_internet_error";

  //login
  static const String login = "เข้าสู่ระบบ";
  static const String loginDeception = "เข้าใช้งานง่ายๆ ด้วยชื่อผู้ใช้และรหัสผ่านของคุณ";
  static const String powerBy = "Powered by NTBX";

  //Main menu
  static const String collectionMenu = "ตามหนี้";
  static const String paymentMenu = "รับเงิน";
  static const String customerInfoMenu = "ข้อมูลลูกค้า";
  static const String commentMenu = "ความคิดเห็นและข้อเสนอแนะ";
  static const String logoutMenu = "ออกจากระบบ";
}
