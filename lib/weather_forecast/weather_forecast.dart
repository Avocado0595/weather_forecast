import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_application/weather_forecast/network/network.dart';
import 'package:weather_application/weather_forecast/ui/mid_view.dart';
import 'package:weather_application/weather_forecast/util/forecast.util.dart';

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
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                            '${snapshot.data?.city.toString()}, ${snapshot.data?.country.toString()}',
                            style:
                                TextStyle(color: Colors.black, fontSize: 20)),
                      ),
                      Text(
                          'Today: ${ForecastUtil.getFromattedDate(new DateTime.fromMillisecondsSinceEpoch((snapshot.data?.current?.dt?.toInt() ?? 0) * 1000))}',
                          style: TextStyle(color: Colors.black, fontSize: 16)),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: ForecastUtil.getWeatherIcon(
                            snapshot.data?.current?.weather[0].main
                                    .toString() ??
                                '',
                            180),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${ForecastUtil.KtoC(snapshot.data?.current?.temp?.toDouble() ?? 0).toStringAsFixed(2)}\u2103',
                            style: TextStyle(fontSize: 28),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              '${snapshot.data?.current?.weather[0].main.toString()}',
                              style: TextStyle(fontSize: 20),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 80),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Column(
                                  children: [
                                    Text(
                                        "${ForecastUtil.getMeterPerHour(snapshot.data?.current?.windSpeed ?? 0)}km/h"),
                                    Icon(FontAwesomeIcons.wind)
                                  ],
                                ),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      Text(
                                          "${snapshot.data?.current?.humidity}%"),
                                      Icon(FontAwesomeIcons.droplet)
                                    ],
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      Text("${snapshot.data?.current?.uvi}"),
                                      Icon(FontAwesomeIcons.sun)
                                    ],
                                  ))
                            ]),
                      ),
                      Container(
                        child: Text("Weather in next 7 days"),
                        margin: EdgeInsets.only(
                            left: 8, right: 8, top: 50, bottom: 20),
                      ),
                      Container(
                        height: 200,
                        child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    height: 50,
                                    child: Column(
                                      children: [
                                        Text(ForecastUtil.getDayFromDate(
                                            new DateTime
                                                    .fromMillisecondsSinceEpoch(
                                                (snapshot.data?.daily?[index].dt
                                                            ?.toInt() ??
                                                        0) *
                                                    1000))),
                                        ForecastUtil.getWeatherIcon(
                                            snapshot.data?.daily?[index]
                                                    .weather?[0].main
                                                    .toString() ??
                                                '',
                                            60),
                                        Text(
                                            "${ForecastUtil.KtoC(snapshot.data?.daily?[index].temp?.min?.toDouble() ?? 0).toStringAsFixed(1)}\u2103/${ForecastUtil.KtoC(snapshot.data?.daily?[index].temp?.max?.toDouble() ?? 0).toStringAsFixed(1)}\u2103")
                                      ],
                                    ))),
                            separatorBuilder: (context, index) =>
                                SizedBox(width: 8),
                            itemCount: snapshot.data?.daily?.length ?? 0),
                      )
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
