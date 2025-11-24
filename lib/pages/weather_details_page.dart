import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_premium_full/providers/weather_provider.dart';
import 'package:weather_premium_full/widgets/gradient_background.dart';

class WeatherDetailsPage extends StatelessWidget {
  const WeatherDetailsPage({super.key});

  String formatTime(int unix, int timezoneOffset) {
    final date = DateTime.fromMillisecondsSinceEpoch((unix + timezoneOffset) * 1000, isUtc: true);
    return "${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    final wp = context.watch<WeatherProvider>();
    final w = wp.weather;

    if (w == null) {
      return const Scaffold(
        body: Center(child: Text("No weather data found")),
      );
    }

    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // City name
                Text(
                  w.cityName,
                  style: const TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 10),

                // Icon
                Image.network(
                  "https://openweathermap.org/img/wn/${w.icon}@4x.png",
                  height: 130,
                ),

                // Temperature
                Text(
                  "${w.temp.toStringAsFixed(1)}°",
                  style: const TextStyle(
                    fontSize: 70,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                // Description
                Text(
                  w.description.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white70,
                  ),
                ),

                const SizedBox(height: 30),

                // Weather info
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      infoRow("Feels like", "${w.feelsLike}°"),
                      infoRow("Humidity", "${w.humidity}%"),
                      infoRow("Wind speed", "${w.windSpeed} m/s"),
                      infoRow("Sunrise", formatTime(w.sunrise, w.timezone)),
                      infoRow("Sunset", formatTime(w.sunset, w.timezone)),
                    ],
                  ),
                ),

                const Spacer(),

                // Add to Favorites
                ElevatedButton.icon(
                  icon: const Icon(Icons.favorite_border),
                  onPressed: () {
                    wp.addFavorite(w.cityName);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("${w.cityName} added to favorites"),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 55),
                    backgroundColor: Colors.white.withOpacity(0.2),
                  ),
                  label: const Text(
                    "Add to Favorites",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(color: Colors.white70, fontSize: 16)),
          Text(value,
              style: const TextStyle(color: Colors.white, fontSize: 16)),
        ],
      ),
    );
  }
}
