class WeatherModel {
  final String cityName;
  final double temp;
  final double feelsLike;
  final int humidity;
  final double windSpeed;
  final String description;
  final String icon;
  final int sunrise;
  final int sunset;
  final int timezone;

  WeatherModel({
    required this.cityName,
    required this.temp,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
    required this.description,
    required this.icon,
    required this.sunrise,
    required this.sunset,
    required this.timezone,
  });

  factory WeatherModel.fromJson(Map data) {
    return WeatherModel(
      cityName: data['name'],
      temp: data['main']['temp'] * 1.0,
      feelsLike: data['main']['feels_like'] * 1.0,
      humidity: data['main']['humidity'],
      windSpeed: data['wind']['speed'] * 1.0,
      description: data['weather'][0]['description'],
      icon: data['weather'][0]['icon'],
      sunrise: data['sys']['sunrise'],
      sunset: data['sys']['sunset'],
      timezone: data['timezone'],
    );
  }
}
