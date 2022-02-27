import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ModeProvider with ChangeNotifier {
  ThemeMode mode = ThemeMode.light;

  changeThemeMode() {
    if (mode == ThemeMode.light) {
      mode = ThemeMode.dark;
    } else {
      mode = ThemeMode.light;
    }
    print(mode);
    notifyListeners();
  }
}
