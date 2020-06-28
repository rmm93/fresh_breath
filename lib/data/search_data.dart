// To parse this JSON data, do
//
//     final searchData = searchDataFromJson(jsonString);

import 'dart:convert';

SearchData searchDataFromJson(String str) =>
    SearchData.fromJson(json.decode(str));

class SearchData {
  SearchData({
    this.status,
    this.data,
  });

  String status;
  List<Datum> data;

  factory SearchData.fromJson(Map<String, dynamic> json) => SearchData(
        status: json["status"] == null ? null : json["status"],
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );
}

class Datum {
  Datum({
    this.uid,
    this.aqi,
    this.time,
    this.station,
  });

  int uid;
  String aqi;
  Time time;
  Station station;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        uid: json["uid"] == null ? null : json["uid"],
        aqi: json["aqi"] == null ? null : json["aqi"],
        time: json["time"] == null ? null : Time.fromJson(json["time"]),
        station:
            json["station"] == null ? null : Station.fromJson(json["station"]),
      );
}

class Station {
  Station({
    this.name,
    this.geo,
    this.url,
    this.country,
  });

  String name;
  List<double> geo;
  String url;
  String country;

  factory Station.fromJson(Map<String, dynamic> json) => Station(
        name: json["name"] == null ? null : json["name"],
        geo: json["geo"] == null
            ? null
            : List<double>.from(json["geo"].map((x) => x.toDouble())),
        url: json["url"] == null ? null : json["url"],
        country: json["country"] == null ? null : json["country"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "geo": geo == null ? null : List<dynamic>.from(geo.map((x) => x)),
        "url": url == null ? null : url,
        "country": country == null ? null : country,
      };
}

class Time {
  Time({
    this.tz,
    this.stime,
    this.vtime,
  });

  String tz;
  DateTime stime;
  int vtime;

  factory Time.fromJson(Map<String, dynamic> json) => Time(
        tz: json["tz"] == null ? null : json["tz"],
        stime: json["stime"] == null ? null : DateTime.parse(json["stime"]),
        vtime: json["vtime"] == null ? null : json["vtime"],
      );
}
