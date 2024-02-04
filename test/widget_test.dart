import 'package:flutter_test/flutter_test.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_models.dart';
import 'package:weather_app/models/weather_service.dart';

class MockGeolocator extends Mock implements GeolocatorPlatform {}



void main() {
  group('WeatherService', () {
    
    test('getCurrentLocation throws exception on denied location permission',
        () async {
      // Arrange
      final mockGeolocator = MockGeolocator();
      final weatherService =
          WeatherService("abcc0a2644344fb9b84ce5959696a3be");

      // Stub the Geolocator methods to simulate denied location permission
      when(mockGeolocator.checkPermission())
          .thenAnswer((_) async => LocationPermission.denied);

      // Act & Assert
      expect(
        () async => await weatherService.getCurrentLocation(),
        throwsException,
      );
    });
  });
}
