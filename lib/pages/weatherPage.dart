import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_models.dart';
import 'package:weather_app/models/weather_service.dart';
import 'package:weather_app/pages/homepage.dart';
import 'package:weather_app/pages/search_page.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService(apiKey: "abcc0a2644344fb9b84ce5959696a3be",httpClient: http.Client());

  Weather? _weather;
  Weather? _searchWeather;

  void _updateSearchWeather(Weather newWeather) {
    setState(() {
      _searchWeather = newWeather;
    });
  }

  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentLocation();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();

    _fetchWeather();
  }

  int _currentIndex = 0;

  void updateCurrentIndex(int index) {
    setState(() {
      _currentIndex = index;
      if (index == 0) {
        setState(() {});
      }
    });
  }

  void navigateBottom(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      Homepage(
        weather: _searchWeather ?? _weather,
        onIndexChanged: updateCurrentIndex,
      ),
      Search(
        onUpdateIndex: updateCurrentIndex,
        onUpdateSearchWeather: _updateSearchWeather,
      )
    ];

    return Scaffold(
      extendBody: true,
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(0, 255, 193, 7),
        currentIndex: _currentIndex,
        onTap: navigateBottom,
        elevation: 0.0,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.amber,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: Colors.amber),
            label: 'Search',
          ),
        ],
      ),
    );
  }
}
