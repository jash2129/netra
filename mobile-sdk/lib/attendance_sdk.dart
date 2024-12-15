import 'package:shared_preferences.dart';
export 'models/user.dart';
export 'models/attendance.dart';

class AttendanceSDK {
  static late String _baseUrl;
  static late SharedPreferences _prefs;

  /// Initialize the SDK with configuration
  static Future<void> initialize({
    required String baseUrl,
  }) async {
    _baseUrl = baseUrl;
    _prefs = await SharedPreferences.getInstance();
  }

  /// Get the base URL
  static String get baseUrl => _baseUrl;

  /// Get shared preferences instance
  static SharedPreferences get prefs => _prefs;

  /// Check if SDK is initialized
  static bool get isInitialized => _baseUrl.isNotEmpty;
}
