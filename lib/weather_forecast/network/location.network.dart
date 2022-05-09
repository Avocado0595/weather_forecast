import 'dart:convert';
import 'package:http/http.dart';
import 'package:weather_application/weather_forecast/model/location.model.dart';

class LocationNetWork {
  Future<LocationModel> getCoordinate({required String cityName}) async {
    var finalUrl =
        'https://api.openweathermap.org/geo/1.0/direct?q=$cityName&limit=5&appid=e358abeeb6acddcd484cba258580f713';
    var response = await get(Uri.parse(finalUrl));
    if (response.statusCode == 200) {
      return LocationModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('error get location');
    }
  }
}
