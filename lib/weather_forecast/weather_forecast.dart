import 'package:flutter/material.dart';
import 'package:weather_application/weather_forecast/network/network.dart';

import 'model/weather_forecast.model.dart';

class WeatherForecast extends StatefulWidget {
  const WeatherForecast({Key? key}) : super(key: key);

  @override
  State<WeatherForecast> createState() => _WeatherForecastState();
}

class _WeatherForecastState extends State<WeatherForecast> {
  late Future<WeatherForecastModel> forecastOject;
  String _cityName = "HCM";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    forecastOject = NetWork().getWetherForecast(cityName: _cityName);
    forecastOject.then((weather) {
      print(weather.daily?[0].clouds);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('WeatherForecast')),
    );
  }
}
