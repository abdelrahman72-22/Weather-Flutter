import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_premium_full/models/weather_model.dart';
import 'package:weather_premium_full/services/api_service.dart';
import 'package:weather_premium_full/services/location_service.dart';
import 'package:weather_premium_full/providers/app_provider.dart';
import 'package:provider/provider.dart';

class WeatherProvider extends ChangeNotifier {
  final ApiService api = ApiService();
  final LocationService locationService = LocationService();

  WeatherModel? weather;
  bool loading = false;
  List<String> favorites = [];

  WeatherProvider() {
    loadFavorites();
  }

  // --------------------------------------------------------
  // Load Favorites from storage
  // --------------------------------------------------------
  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    favorites = prefs.getStringList("favorites") ?? [];
    notifyListeners();
  }

  // --------------------------------------------------------
  // Save Favorites to storage
  // --------------------------------------------------------
  Future<void> saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList("favorites", favorites);
  }

  // --------------------------------------------------------
  // Add favorite
  // --------------------------------------------------------
  void addFavorite(String city) {
    if (!favorites.contains(city)) {
      favorites.add(city);
      saveFavorites();
      notifyListeners();
    }
  }

  // --------------------------------------------------------
  // Remove favorite
  // --------------------------------------------------------
  void removeFavorite(String city) {
    favorites.remove(city);
    saveFavorites();
    notifyListeners();
  }

  // --------------------------------------------------------
  // Get weather by city
  // --------------------------------------------------------
  Future<void> getByCity(BuildContext context, String city) async {
    loading = true;
    notifyListeners();

    final app = Provider.of<AppProvider>(context, listen: false);

    try {
      weather = await api.getByCity(city, app.useCelsius);
    } catch (e) {
      loading = false;
      notifyListeners();
      rethrow;
    }

    loading = false;
    notifyListeners();
  }

  // --------------------------------------------------------
  // Get weather by user GPS location (button only)
  // --------------------------------------------------------
  Future<void> getByLocation(BuildContext context) async {
    loading = true;
    notifyListeners();

    final app = Provider.of<AppProvider>(context, listen: false);

    try {
      final pos = await locationService.getLocation();
      weather = await api.getByLocation(pos.latitude, pos.longitude, app.useCelsius);
    } catch (e) {
      loading = false;
      notifyListeners();
      rethrow;
    }

    loading = false;
    notifyListeners();
  }
}
