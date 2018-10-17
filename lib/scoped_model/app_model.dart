import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppModel extends Model {
  static const _PREFS_KEY_AUTH = "auth prefs key";
  final SharedPreferences _sharedPrefs;

  AppModel(this._sharedPrefs) {

  }

  bool isAuthorized() => _sharedPrefs.getBool(_PREFS_KEY_AUTH) ?? false;
}