import 'package:flutter/cupertino.dart';

import '../model/weather_forecast.model.dart';

Widget midView(AsyncSnapshot<WeatherForecastModel> snapshot) {
  if (snapshot.hasData)
    // ignore: curly_braces_in_flow_control_structures
    return Container(
      child: Text(' '),
    );
  return Text('');
}
