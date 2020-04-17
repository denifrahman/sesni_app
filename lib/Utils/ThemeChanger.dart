import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

ThemeData light = ThemeData(
  scaffoldBackgroundColor: Colors.grey[100],
  inputDecorationTheme: const InputDecorationTheme(
    labelStyle: TextStyle(color: Colors.black, fontSize: 12),
    hintStyle: TextStyle(color: Colors.grey, fontSize: 15, fontFamily: 'OpenSans-Regular', fontWeight: FontWeight.w500),
  ),
  fontFamily: 'OpenSans-Regular',
  primaryColor: Colors.white,
  appBarTheme: AppBarTheme(
    brightness: Brightness.light,
    actionsIconTheme: IconThemeData(size:14),
     textTheme: TextTheme(
       title: TextStyle(fontSize: 15, color: Colors.black,fontFamily: 'OpenSans-Regular', fontWeight: FontWeight.bold )
     )
  ),
);

ThemeData dark = ThemeData(
    brightness: Brightness.dark,
//  scaffoldBackgroundColor: Colors.black,
    fontFamily: 'OpenSans-Regular');

class ThemeNotifier extends ChangeNotifier {
  final String key = "theme";
  SharedPreferences _prefs;
  bool _darkTheme;

  bool get darkTheme => _darkTheme;

  ThemeNotifier() {
    _darkTheme = true;
    _loadFromPrefs();
  }

  toggleTheme(param) {
    if (param == 1) {
      _darkTheme = true;
    } else if (param == 2) {
      _darkTheme = false;
    }
    _saveToPrefs();
    notifyListeners();
  }

  _initPrefs() async {
    if (_prefs == null) _prefs = await SharedPreferences.getInstance();
  }

  _loadFromPrefs() async {
    await _initPrefs();
    _darkTheme = _prefs.getBool(key) ?? true;
    notifyListeners();
  }

  _saveToPrefs() async {
    await _initPrefs();
    _prefs.setBool(key, _darkTheme);
  }
}
