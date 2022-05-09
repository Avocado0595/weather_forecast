// ignore_for_file: non_constant_identifier_names, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_application/weather_forecast/util/forecast.util.dart';

import '../model/weather_forecast.model.dart';

Widget midView(AsyncSnapshot<WeatherForecastModel> snapshot) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Text(
            '${snapshot.data?.city.toString()}, ${snapshot.data?.country.toString()}',
            style: TextStyle(color: Colors.black, fontSize: 20)),
      ),
      Text(
          'Today: ${ForecastUtil.getFromattedDate(DateTime.fromMillisecondsSinceEpoch((snapshot.data?.current?.dt?.toInt() ?? 0) * 1000))}',
          style: TextStyle(color: Colors.black, fontSize: 16)),
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: ForecastUtil.getWeatherIcon(
            snapshot.data?.current?.weather[0].main.toString() ?? '', 180),
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
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 80),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                  Text("${snapshot.data?.current?.humidity}%"),
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
        margin: EdgeInsets.only(left: 8, right: 8, top: 50, bottom: 20),
      ),
      Container(
        height: 200,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                child: SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    height: 50,
                    child: Column(
                      children: [
                        Text(ForecastUtil.getDayFromDate(
                            DateTime.fromMillisecondsSinceEpoch(
                                (snapshot.data?.daily?[index].dt?.toInt() ??
                                        0) *
                                    1000))),
                        ForecastUtil.getWeatherIcon(
                            snapshot.data?.daily?[index].weather?[0].main
                                    .toString() ??
                                '',
                            60),
                        Text(
                            "${ForecastUtil.KtoC(snapshot.data?.daily?[index].temp?.min?.toDouble() ?? 0).toStringAsFixed(1)}\u2103/${ForecastUtil.KtoC(snapshot.data?.daily?[index].temp?.max?.toDouble() ?? 0).toStringAsFixed(1)}\u2103")
                      ],
                    ))),
            separatorBuilder: (context, index) => SizedBox(width: 8),
            itemCount: snapshot.data?.daily?.length ?? 0),
      )
    ],
  );
}
