import 'package:shared_preferences/shared_preferences.dart';

class CacheService {
  static SharedPreferences? preferences;

  static init() async {
    preferences = await SharedPreferences.getInstance();
  }

  /// language
  static void saveLanguage(String language) {
    preferences!.setString("language", language);
  }

  static String getLanguage() {
    String data = preferences!.getString("language") ?? "uz";
    return data;
  }
}
