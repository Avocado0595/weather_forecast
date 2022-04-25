class LocationModel {
  String? name;
  LocalNames? localNames;
  double? lat;
  double? lon;
  String? country;

  LocationModel({this.name, this.localNames, this.lat, this.lon, this.country});

  LocationModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    localNames = json['local_names'] != null
        ? new LocalNames.fromJson(json['local_names'])
        : null;
    lat = json['lat'];
    lon = json['lon'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.localNames != null) {
      data['local_names'] = this.localNames!.toJson();
    }
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['country'] = this.country;
    return data;
  }
}

class LocalNames {
  String? vi;
  String? ja;
  String? fr;
  String? ms;
  String? ko;
  String? nl;
  String? zh;
  String? ru;
  String? cs;
  String? en;

  LocalNames(
      {this.vi,
      this.ja,
      this.fr,
      this.ms,
      this.ko,
      this.nl,
      this.zh,
      this.ru,
      this.cs,
      this.en});

  LocalNames.fromJson(Map<String, dynamic> json) {
    vi = json['vi'];
    ja = json['ja'];
    fr = json['fr'];
    ms = json['ms'];
    ko = json['ko'];
    nl = json['nl'];
    zh = json['zh'];
    ru = json['ru'];
    cs = json['cs'];
    en = json['en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vi'] = this.vi;
    data['ja'] = this.ja;
    data['fr'] = this.fr;
    data['ms'] = this.ms;
    data['ko'] = this.ko;
    data['nl'] = this.nl;
    data['zh'] = this.zh;
    data['ru'] = this.ru;
    data['cs'] = this.cs;
    data['en'] = this.en;
    return data;
  }
}
