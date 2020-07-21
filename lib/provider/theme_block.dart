import 'package:flutter/widgets.dart';

class ThemeBlock extends ChangeNotifier {
  bool _darkTheme = false;

  void enableDarkTheme(bool value) {
    _darkTheme = value;
    notifyListeners();
  }

  bool get isDarkThemeEnabled {
    return _darkTheme;
  }
}
