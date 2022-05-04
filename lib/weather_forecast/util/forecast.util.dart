import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_icons/weather_icons.dart';

class ForecastUtil {
  static String myKey = 'e358abeeb6acddcd484cba258580f713';
  static String getFromattedDate(DateTime dateTime) {
    return new DateFormat("EEE, MMM d, yyyy").format(dateTime);
  }

  static Widget getWeatherIcon(String weather) {
    final double size = 80;
    switch (weather.toLowerCase()) {
      case 'clouds':
        return Icon(
          Icons.cloud,
          size: 10,
        );
      case 'rain':
        return Icon(Icons.water_drop, size: size);
      case 'sunny':
      case 'clear':
        return Icon(Icons.sunny, size: size);
      case 'haze':
        return Icon(Icons.area_chart_sharp, size: size);
      default:
        return Icon(Icons.question_mark, size: size);
    }
  }

  static double KtoC(double Kdeg) {
    return Kdeg - 273.15;
  }

  static double KtoF(double Kdeg) {
    return ((Kdeg - 273.15) - 32) * 5 / 9;
  }
}
