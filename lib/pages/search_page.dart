import 'dart:ui';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_models.dart';
import 'package:weather_app/models/weather_service.dart';
import 'package:weather_app/pages/weatherPage.dart';

class Search extends StatefulWidget {
  final void Function(int) onUpdateIndex;
  final void Function(Weather) onUpdateSearchWeather;

 const Search(
      {Key? key,
      required this.onUpdateIndex,
      required this.onUpdateSearchWeather})
      : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final myContoller = TextEditingController();
  Weather? _searchWeather;
  WeatherPage? _serachWeatherPage;
  WeatherService? _service;

  @override
  void initState() {
    super.initState();
    _service = WeatherService(apiKey: "abcc0a2644344fb9b84ce5959696a3be",httpClient: http.Client());
    _serachWeatherPage = const WeatherPage();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myContoller.dispose();
    super.dispose();
  }

  Future<void> search(String searchText) async {
    try {
      if (_service != null) {
        final Weather weather = await _service!.getWeather(searchText);
        setState(() {
          _searchWeather = weather;
          widget.onUpdateIndex(0);
          widget.onUpdateSearchWeather(weather); 
        });
      }
    } catch (e) {
      print('Exception: Failed to load weather data: $e');
      // Handle the exception gracefully
    }
  }



  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Align(
        alignment: const AlignmentDirectional(2, 0.5),
        child: Container(
          height: 400,
          width: 400,
          decoration:
              const BoxDecoration(shape: BoxShape.circle, color: Colors.purple),
        ),
      ),
      Align(
        alignment: const AlignmentDirectional(-3, 0.6),
        child: Container(
          height: 400,
          width: 400,
          decoration:
              const BoxDecoration(shape: BoxShape.circle, color: Colors.purple),
        ),
      ),
      Align(
        alignment: const AlignmentDirectional(0, -1.2),
        child: Container(
          height: 500,
          width: 500,
          decoration: const BoxDecoration(
              shape: BoxShape.rectangle,
              color: Color.fromARGB(255, 208, 108, 14)),
        ),
      ),
      Align(
        alignment: const AlignmentDirectional(-1.3, 1.5),
        child: Container(
          height: 400,
          width: 400,
          decoration: const BoxDecoration(
              shape: BoxShape.circle, color: Color.fromARGB(255, 2, 0, 0)),
        ),
      ),
      Align(
        alignment: const AlignmentDirectional(0, 0),
        child: Container(
          height: 400,
          width: 400,
          decoration: const BoxDecoration(
              shape: BoxShape.circle, color: Color.fromARGB(255, 0, 0, 0)),
        ),
      ),
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
        child: Container(
          decoration: const BoxDecoration(color: Colors.transparent),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: TextField(
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40))),
                prefixIcon: Icon(Icons.search_outlined),
                prefixIconColor: Colors.white,
                hintText: "Enter your location",
                hintStyle: TextStyle(color: Colors.white),
                contentPadding: EdgeInsets.all(10)),
            controller: myContoller,
            onSubmitted: (String searchText) => search(searchText),
          ),
        ),
      ),
    ]);
  }
}
