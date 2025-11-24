# 🌤️ **Premium Weather App (Flutter)**

A modern, full–featured weather application built with **Flutter**, providing a premium minimal UI, GPS location support, favorites management, dark mode, Celsius/Fahrenheit switching, and integration with the OpenWeatherMap API.

This project follows clean folder structure practices, state management using **Provider**, and supports Android & iOS builds.

---

# 📁 **Folder Structure (Full Project Structure)**
weather_premium_full/
│
├── android/ # Android native project
├── ios/ # iOS native project
├── linux/ # Linux build support
├── macos/ # macOS build support
├── windows/ # Windows build support
├── web/ # Web support
│
├── assets/
│ └── icons/ # Weather icons and images
│
├── lib/
│ ├── main.dart # Application entry point
│ │
│ ├── models/
│ │ └── weather_model.dart # Data model for weather object
│ │
│ ├── services/
│ │ ├── api_service.dart # OpenWeather API handling
│ │ └── location_service.dart # GPS & permissions logic
│ │
│ ├── providers/
│ │ ├── app_provider.dart # Global theme + unit settings
│ │ └── weather_provider.dart # Weather logic + favorites
│ │
│ ├── theme/
│ │ └── app_theme.dart # Light/Dark theme configuration
│ │
│ ├── widgets/
│ │ ├── gradient_background.dart # Premium gradient UI background
│ │ └── weather_info_tile.dart # Info row widget for details page
│ │
│ └── pages/
│ ├── home_page.dart # Search + GPS page
│ ├── weather_details_page.dart # Premium weather details
│ ├── favorites_page.dart # Favorites list and removal
│ └── settings_page.dart # Dark mode + temperature units
│
├── pubspec.yaml # Dependencies + project metadata
└── README.md # Project documentation

---

# 🔑 **API Key Setup**

Open:
lib/services/api_service.dart

Replace:

```dart
final String apiKey = "PUT_API_KEY_HERE";
```
With your actual OpenWeatherMap API key.

Get your key from:
👉 https://openweathermap.org/api

---

# How to Run the App

1️⃣ Install dependencies

  - Run:
     flutter pub get

2️⃣ Fix unsupported platforms

  - If Flutter says: "No supported devices connected"
  - Run:
     flutter create .

3️⃣ Run the app
    flutter run

---

# 📦 Build an Android APK

run:
 flutter build apk --release

Your APK will be generated in:

build/app/outputs/flutter-apk/app-release.apk 

---

# 🍏 iOS Build (Optional / If using macOS)

⚠ iOS requires a Mac with Xcode installed.

1️⃣ Install CocoaPods
   sudo gem install cocoapods

2️⃣ Install iOS dependencies
  cd ios
  pod install
  cd ..

3️⃣ Build iOS release
  flutter build ios --release


Output appears in:

 build/ios/iphoneos/


 You must sign the app using Xcode to run it on a physical iPhone.

---

⭐ Features Included

🔍 Search weather by city

📍 GPS Weather (manual button)

⭐ Add/Remove favorites with SharedPreferences

🌓 Dark / Light theme toggle

🌡 Switch between Celsius and Fahrenheit

🎨 Premium material UI with gradients

🌤 Detailed weather info:

    Temperature

    Description

    Feels Like

    Humidity

    Wind Speed

    Sunrise & Sunset (local time)

    Weather icons

    Clean MVC-like folder structure

    Fully extensible architecture

---

🧩 Tech Stack

Flutter (Dart)

Provider (State management)

Geolocator (GPS & permissions)

SharedPreferences (local storage)

Google Fonts

Material 3 UI

OpenWeatherMap API