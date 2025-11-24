import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_premium_full/providers/weather_provider.dart';
import 'weather_details_page.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final wp = context.watch<WeatherProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorites"),
      ),

      body: wp.favorites.isEmpty
          ? const Center(
              child: Text(
                "No favorites added yet",
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: wp.favorites.length,
              itemBuilder: (context, index) {
                final city = wp.favorites[index];

                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.only(bottom: 15),
                  child: ListTile(
                    title: Text(
                      city,
                      style: const TextStyle(fontSize: 18),
                    ),

                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        wp.removeFavorite(city);
                      },
                    ),

                    onTap: () async {
                      try {
                        await wp.getByCity(context, city);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const WeatherDetailsPage(),
                          ),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Failed to load weather for $city"),
                          ),
                        );
                      }
                    },
                  ),
                );
              },
            ),
    );
  }
}
