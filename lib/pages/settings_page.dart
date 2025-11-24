import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_premium_full/providers/app_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            // ------------------------------
            // DARK MODE SWITCH
            // ------------------------------
            SwitchListTile(
              title: const Text(
                "Dark Mode",
                style: TextStyle(fontSize: 18),
              ),
              value: app.isDark,
              onChanged: (_) => app.toggleTheme(),
              secondary: const Icon(Icons.dark_mode),
            ),

            const SizedBox(height: 10),

            // ------------------------------
            // TEMPERATURE UNITS
            // ------------------------------
            SwitchListTile(
              title: const Text(
                "Use Celsius (°C)",
                style: TextStyle(fontSize: 18),
              ),
              value: app.useCelsius,
              onChanged: (_) => app.toggleUnits(),
              secondary: const Icon(Icons.thermostat),
            ),

            const SizedBox(height: 20),

            const Divider(),

            const SizedBox(height: 15),

            // ------------------------------
            // APP INFO
            // ------------------------------
            const Text(
              "Premium Weather App\nVersion 1.0.0",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
            )
          ],
        ),
      ),
    );
  }
}
