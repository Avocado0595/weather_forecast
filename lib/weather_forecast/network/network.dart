import 'dart:convert';

import 'package:http/http.dart';
import 'package:weather_application/weather_forecast/model/location.model.dart';
import 'package:weather_application/weather_forecast/model/weather_forecast.model.dart';
import 'package:weather_application/weather_forecast/network/location.network.dart';
import 'package:weather_application/weather_forecast/util/forecast.util.dart';

class NetWork {
  Future<WeatherForecastModel> getWetherForecast(
      {required String cityName}) async {
    late Future<LocationModel> locationOject;
    num? lat = 0;
    num? lon = 0;
    String? city = cityName;
    String? country = '';
    locationOject = LocationNetWork().getCoordinate(cityName: cityName);
    await locationOject.then((location) {
      lat = location.lat;
      lon = location.lon;
      city = location.name;
      country = location.country;
    });
    var finalUrl =
        'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&exclude=hourly,minutely&appid=${ForecastUtil.myKey}';
    var response = await get(Uri.parse(finalUrl));
    //print(response);
    if (response.statusCode == 200) {
      return WeatherForecastModel.fromJson(
          json.decode(response.body), city, country);
    } else {
      throw Exception('error get weather');
    }
  }
}
