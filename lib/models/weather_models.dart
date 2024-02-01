
class Weather {
  final String cityName;
  final String mainCondition;
  final double temperature;

  Weather(
      {required this.cityName,
      required this.mainCondition,
      required this.temperature});
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
        cityName: json["name"],
        mainCondition: json["weather"][0]['main'],
        temperature: json["main"]['temp'].toDouble());
  }
}
