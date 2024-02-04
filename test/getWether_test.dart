import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/models/weather_service.dart';

import 'getWether_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('get the weather data', () {
    test('Get the data if it\'s successful', () async {
      final client = MockClient();
      const BASE_URL = "https://api.openweathermap.org/data/2.5/weather";
      final cityName = "Pala";
      final apiKey = "abcc0a2644344fb9b84ce5959696a3be";

      // Mock successful HTTP response
      when(client.get(
              Uri.parse('$BASE_URL?q=$cityName&appid=$apiKey&units=metric')))
          .thenAnswer((_) async =>
              http.Response('{"weather":[{"main":"rain"}],"main":{"temp":25},"name":"Pala"}', 200));

      // Instantiate the WeatherService with the mocked client
      final weatherService = WeatherService(
          apiKey: "abcc0a2644344fb9b84ce5959696a3be", httpClient: client);

      // Call the getWeather method
      final weather = await weatherService.getWeather("Pala");

      // Verify that the client's get method was called with the expected URL
      verify(client.get(Uri.parse(
          '$BASE_URL?q=Pala&appid=abcc0a2644344fb9b84ce5959696a3be&units=metric')));

      // Verify that the Weather.fromJson method was called with the expected JSON response
      expect(weather.cityName, "Pala");
      expect(weather.temperature, 25.0);
      expect(weather.mainCondition, "rain");
    });
     test('getWeather - Invalid JSON response', () async {
      // Mock an invalid JSON response
       final client = MockClient();
      when(client.get(any))
          .thenAnswer((_) async => http.Response('Invalid JSON', 200));

      // Call the getWeather method
      final weatherService = WeatherService(
          apiKey: "abcc0a2644344fb9b84ce5959696a3be", httpClient: client);
      expect(
          () async => await weatherService.getWeather("Pala"), throwsException);
    });

    test('getWeather - Server error', () async {
      // Mock a server error response
      final client = MockClient();
      when(client.get(any))
          .thenAnswer((_) async => http.Response('Server Error', 500));

      // Call the getWeather method
      final weatherService = WeatherService(
          apiKey: "abcc0a2644344fb9b84ce5959696a3be", httpClient: client);
      expect(
          () async => await weatherService.getWeather("Pala"), throwsException);
    });
  });
}
