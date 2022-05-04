import 'package:flutter/material.dart';
import 'package:weather_application/weather_forecast/network/network.dart';
import 'package:weather_application/weather_forecast/ui/mid_view.dart';
import 'package:weather_application/weather_forecast/util/forecast.util.dart';
import 'package:weather_icons/weather_icons.dart';

import 'model/weather_forecast.model.dart';

class WeatherForecast extends StatefulWidget {
  const WeatherForecast({Key? key}) : super(key: key);

  @override
  State<WeatherForecast> createState() => _WeatherForecastState();
}

class _WeatherForecastState extends State<WeatherForecast> {
  late Future<WeatherForecastModel> forecastOject;
  String _cityName = "hcm";
  @override
  void initState() {
    super.initState();
    forecastOject = getWeather(_cityName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        textFieldView(),
        Container(
          child: FutureBuilder(
              future: forecastOject,
              builder: (BuildContext context,
                  AsyncSnapshot<WeatherForecastModel> snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Text(
                          '${snapshot.data?.city.toString()}, ${snapshot.data?.country.toString()}'),
                      Text(
                          'Today: ${ForecastUtil.getFromattedDate(new DateTime.fromMillisecondsSinceEpoch((snapshot.data?.current?.dt?.toInt() ?? 0) * 1000))}'),
                      ForecastUtil.getWeatherIcon(
                          snapshot.data?.current?.weather[0].main.toString() ??
                              ''),
                      Text(
                          '${ForecastUtil.KtoF(snapshot.data?.current?.temp?.toDouble() ?? 0).toStringAsFixed(2)}\u2109/${ForecastUtil.KtoC(snapshot.data?.current?.temp?.toDouble() ?? 0).toStringAsFixed(2)}\u2103 ${snapshot.data?.current?.weather[0].main.toString()}')
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text('Invalid city');
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
              }),
        )
      ],
    ));
  }

  textFieldView() {
    return Container(
      child: TextField(
        decoration: InputDecoration(
            hintText: "enter city name",
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            contentPadding: EdgeInsets.all(8)),
        onSubmitted: (value) {
          setState(() {
            _cityName = value;
            forecastOject = getWeather(_cityName);
          });
        },
      ),
    );
  }

  Future<WeatherForecastModel> getWeather(String _cityName) =>
      NetWork().getWetherForecast(cityName: _cityName);
}
