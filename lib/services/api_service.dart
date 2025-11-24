import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

class ApiService {
  final String baseUrl = "https://api.openweathermap.org/data/2.5/weather";

  // IMPORTANT — Replace with your actual API Key
  final String apiKey = "API_KEY_HERE";

  // ---------------------------------------------------
  // Get weather by city name
  // ---------------------------------------------------
  Future<WeatherModel> getByCity(String city, bool useCelsius) async {
    final unit = useCelsius ? "metric" : "imperial";
    final url = "$baseUrl?q=$city&units=$unit&appid=$apiKey";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("City not found");
    }
  }

  // ---------------------------------------------------
  // Get weather by GPS coordinates
  // ---------------------------------------------------
  Future<WeatherModel> getByLocation(
      double lat, double lon, bool useCelsius) async {
    final unit = useCelsius ? "metric" : "imperial";
    final url =
        "$baseUrl?lat=$lat&lon=$lon&units=$unit&appid=$apiKey";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Location error");
    }
  }
}

