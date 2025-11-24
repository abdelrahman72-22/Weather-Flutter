import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_premium_full/providers/weather_provider.dart';
import 'weather_details_page.dart';
import 'favorites_page.dart';
import 'settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController cityCtrl = TextEditingController();
  String errorMsg = "";

  @override
  Widget build(BuildContext context) {
    final wp = context.watch<WeatherProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Premium Weather"),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const FavoritesPage()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const SettingsPage()));
            },
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Search box
            TextField(
              controller: cityCtrl,
              decoration: const InputDecoration(
                labelText: "Enter city name",
                prefixIcon: Icon(Icons.location_city),
              ),
            ),

            const SizedBox(height: 20),

            // Search button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () async {
                if (cityCtrl.text.trim().isEmpty) {
                  setState(() => errorMsg = "Please enter a city name");
                  return;
                }

                try {
                  setState(() => errorMsg = "");
                  await wp.getByCity(context, cityCtrl.text.trim());
                  if (mounted) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const WeatherDetailsPage()),
                    );
                  }
                } catch (e) {
                  setState(() => errorMsg = "City not found");
                }
              },
              child: const Text("Search"),
            ),

            const SizedBox(height: 20),

            // Use my location button
            ElevatedButton.icon(
              icon: const Icon(Icons.my_location),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () async {
                try {
                  setState(() => errorMsg = "");
                  await wp.getByLocation(context);
                  if (mounted) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const WeatherDetailsPage()),
                    );
                  }
                } catch (e) {
                  setState(() => errorMsg = "Location error");
                }
              },
              label: const Text(
                "Use My Location",
                style: TextStyle(color: Colors.white),
              ),
            ),

            const SizedBox(height: 20),

            // Error message
            if (errorMsg.isNotEmpty)
              Text(
                errorMsg,
                style: const TextStyle(color: Colors.red),
              ),

            const SizedBox(height: 20),

            // Loading indicator
            if (wp.loading)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
