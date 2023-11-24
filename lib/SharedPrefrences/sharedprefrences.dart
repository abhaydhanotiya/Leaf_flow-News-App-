import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static final SharedPreferencesHelper _instance =
      SharedPreferencesHelper._ctor();

  factory SharedPreferencesHelper() {
    return _instance;
  }

  SharedPreferencesHelper._ctor();

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static late SharedPreferences _prefs;

  static void setFirstTime({required bool status}) {
    _prefs.setBool('isFirstTime', status);
  }

  static dynamic getFirstTime() {
    return _prefs.getBool("isFirstTime");
  }

  static void setLanguageCode({required String code}) {
    _prefs.setString('selectedLanguageCode', code);
  }

  static dynamic getLanguageCode() {
    return _prefs.getString("selectedLanguageCode");
  }

  static void setCountryCode({required String code}) {
    _prefs.setString('selectedCountryCode', code);
  }

  static dynamic getCountryCode() {
    return _prefs.getString("selectedCountryCode");
  }
}
