import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/weather_models.dart';

class Homepage extends StatelessWidget {
  final Weather? weather;
  final void Function(int) onIndexChanged;

  const Homepage(
      {super.key, required this.weather, required this.onIndexChanged});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

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
      WeatherDetails(weather: weather, date: now),
    ]);
  }
}

class WeatherDetails extends StatelessWidget {
  final Weather? _weather;

  WeatherDetails({
    super.key,
    required DateTime date,
    required Weather? weather,
  })  : _weather = weather,
        _formattedDate = DateFormat.yMMMMd().format(date),
        _formattedTime = DateFormat.jm().format(date);

  final String _formattedDate;
  final String _formattedTime;

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) {
      return "assests/Sunny.json";
    }
    switch (mainCondition.toLowerCase()) {
      case 'clouds':
        return "assests/Clouds.json";
      case 'mist':
      case 'haze':
      case 'fog':
        return "assests/Mist.json";
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assests/Rainy.json';
      case 'clear':
        return "assests/Sunny.json";
    }
    return "assests/Sunny.json";
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 70, 0, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  color: Colors.white,
                ),
                Text(
                  _weather?.cityName ?? "Loading city",
                  style: const TextStyle(fontSize: 25.00, color: Colors.white),
                ),
              ],
            ),
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 30),
              child:
                  Lottie.asset(getWeatherAnimation(_weather?.mainCondition))),
          Text(
            _weather?.mainCondition ?? "Loading Weather",
            style: const TextStyle(fontSize: 60, color: Colors.white),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            _formattedDate,
            style: const TextStyle(
                fontSize: 30, color: Colors.white, fontStyle: FontStyle.italic),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            '${_weather?.temperature.round()}°C',
            style: const TextStyle(fontSize: 80, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
