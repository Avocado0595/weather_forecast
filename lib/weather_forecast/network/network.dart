import 'dart:convert';

import 'package:http/http.dart';
import 'package:weather_application/weather_forecast/model/weather_forecast.model.dart';
import 'package:weather_application/weather_forecast/util/forecast.util.dart';

class NetWork {
  Future<WeatherForecastModel> getWetherForecast(
      {required String cityName}) async {
    var finalUrl =
        'https://api.openweathermap.org/data/2.5/onecall?lat=47.1289771&lon=-84.0832646&exclude=hourly,minutely&appid=${ForecastUtil.myKey}';
    var response = await get(Uri.parse(finalUrl));
    //print(response);
    if (response.statusCode == 200) {
      print(response.body);
      return WeatherForecastModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('error get weather');
    }
  }
}
