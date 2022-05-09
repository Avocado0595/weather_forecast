import 'package:flutter/material.dart';
import 'package:weather_application/weather_forecast/network/network.dart';
import 'package:weather_application/weather_forecast/ui/mid_view.dart';
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
          FutureBuilder(
              future: forecastOject,
              builder: (BuildContext context,
                  AsyncSnapshot<WeatherForecastModel> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return const Text('Press button to start');
                  case ConnectionState.waiting:
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  default:
                    if (snapshot.hasError) {
                      return Column(
                        children: const [
                          Text(
                            'No result found!',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text('Try searching for a valid city.')
                        ],
                      );
                    } else {
                      return midView(snapshot);
                    }
                }
              })
        ],
      ),
    );
  }

  textFieldView() {
    return Container(
      padding: const EdgeInsets.only(top: 8, left: 4, right: 4),
      child: TextField(
        decoration: InputDecoration(
            hintText: "Enter city name",
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            contentPadding: const EdgeInsets.all(8)),
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
