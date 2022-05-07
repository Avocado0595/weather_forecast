import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ForecastUtil {
  static String myKey = 'e358abeeb6acddcd484cba258580f713';
  static String getFromattedDate(DateTime dateTime) {
    return new DateFormat("EEE, MMM d, yyyy").format(dateTime);
  }

  static String getDayFromDate(DateTime dateTime) {
    return new DateFormat("EEE").format(dateTime);
  }

  static double getMeterPerHour(double mps) {
    // 1 meter/ 1 second = 1 /1000 km / 1/3600hour = 3600/1000 = 3.6
    return 3.6 * mps;
  }

  static Widget getWeatherIcon(String weather, double size) {
    switch (weather.toLowerCase()) {
      case 'clouds':
        return Icon(
          FontAwesomeIcons.cloud,
          color: Colors.lightBlueAccent,
          size: size,
        );
      case 'rain':
        return Icon(FontAwesomeIcons.cloudRain,
            color: Colors.lightBlueAccent, size: size);
      case 'sunny':
      case 'clear':
        return Icon(FontAwesomeIcons.sun, color: Colors.amber[900], size: size);
      case 'haze':
        return Icon(FontAwesomeIcons.smog, color: Colors.grey[400], size: size);
      default:
        return Icon(FontAwesomeIcons.question,
            color: Colors.red[500], size: size);
    }
  }

  static double KtoC(double Kdeg) {
    return Kdeg - 273.15;
  }

  static double KtoF(double Kdeg) {
    return ((Kdeg - 273.15) - 32) * 5 / 9;
  }
}
