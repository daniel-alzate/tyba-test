import 'package:shared_preferences/shared_preferences.dart';

class PreferencesProvider {
  static final PreferencesProvider _instancia =
      new PreferencesProvider._internal();

  factory PreferencesProvider() {
    return _instancia;
  }

  PreferencesProvider._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  get token {
    return _prefs.getString('token') ?? '';
  }

  set token(String value) {
    _prefs.setString('token', value);
  }
}
