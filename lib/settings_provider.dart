import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/features/settings/pages/settings_view.dart';
import 'package:todo_app/features/tasks/pages/tasks_view.dart';

class SettingsProvider extends ChangeNotifier {
  ThemeMode currentTheme = ThemeMode.light;

  List<Widget> screens = [TasksView(), SettingsView()];

  String currentLanguage = "en";

  int currentIndex = 0;

  changeIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  changeLanguage(String newLanguage) async {
    if (currentLanguage == newLanguage) return;
    currentLanguage = newLanguage;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("language", currentLanguage);

    notifyListeners();
  }

  changeTheme(ThemeMode newTheme) async {
    if (currentTheme == newTheme) return;
    currentTheme = newTheme;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("theme", currentTheme.name);

    notifyListeners();
  }

  bool isDark() {
    return currentTheme == ThemeMode.dark;
  }

  Future<void> loadSettings() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? mode = prefs.getString("theme");
    String? language = prefs.getString("language");

    mode ??= "light";
    currentTheme = (mode == "dark" ? ThemeMode.dark : ThemeMode.light);


    language ??= "en";
    currentLanguage = language;

  }
}