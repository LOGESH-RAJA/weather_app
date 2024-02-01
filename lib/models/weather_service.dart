import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_models.dart';

class WeatherService {
  static const BASE_URL = "https://api.openweathermap.org/data/2.5/weather";
  final String apiKey;

  WeatherService(this.apiKey);

  Future<Weather> getWeather(String cityName) async {
    try {
      final response = await http.get(Uri.parse('$BASE_URL?q=$cityName&appid=$apiKey&units=metric'));

      if (response.statusCode == 200) {
        return Weather.fromJson(jsonDecode(response.body));
      } else {
        // Handle specific error cases based on status code
        throw Exception("Failed to load weather data: ${response.statusCode}");
      }
    } catch (e) {
      // Handle other exceptions, e.g., network issues
      throw Exception("Failed to load weather data: $e");
    }
  }

  Future<String> getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

      String? city = placemarks.isNotEmpty ? placemarks[0].locality : null;

      return city ?? "";
    } catch (e) {
      // Handle location-related exceptions
      throw Exception("Failed to get current location: $e");
    }
  }
}
