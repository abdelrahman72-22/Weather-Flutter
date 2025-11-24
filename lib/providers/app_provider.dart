import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppProvider extends ChangeNotifier {
  bool isDark = false;
  bool useCelsius = true; // °C or °F

  AppProvider() {
    loadSettings();
  }

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    isDark = prefs.getBool("isDark") ?? false;
    useCelsius = prefs.getBool("useCelsius") ?? true;
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    isDark = !isDark;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isDark", isDark);
    notifyListeners();
  }

  Future<void> toggleUnits() async {
    useCelsius = !useCelsius;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("useCelsius", useCelsius);
    notifyListeners();
  }
}
