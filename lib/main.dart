import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_premium_full/pages/home_page.dart';
import 'package:weather_premium_full/providers/app_provider.dart';
import 'package:weather_premium_full/providers/weather_provider.dart';
import 'package:weather_premium_full/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()),
        ChangeNotifierProvider(create: (_) => WeatherProvider()),
      ],
      child: const WeatherApp(),
    ),
  );
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appProvider = context.watch<AppProvider>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Premium Weather",
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: appProvider.isDark ? ThemeMode.dark : ThemeMode.light,
      home: const HomePage(),
    );
  }
}
