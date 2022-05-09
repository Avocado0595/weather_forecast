// ignore_for_file: unnecessary_this

class LocationModel {
  String? name;
  double? lat;
  double? lon;
  String? country;
  String? state;
  LocationModel({this.name, this.lat, this.lon, this.country});

  LocationModel.fromJson(List<dynamic> jsonList) {
    if (jsonList.isEmpty) {
      throw Exception('Cannot get location');
    }
    Map<String, dynamic> json = jsonList[0];
    name = json['name'];
    lat = json['lat'];
    lon = json['lon'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = this.name;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['country'] = this.country;
    return data;
  }
}
