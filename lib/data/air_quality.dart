// To parse this JSON data, do
//
//     final airQuality = airQualityFromJson(jsonString);

import 'dart:convert';

AirQuality airQualityFromJson(String str) =>
    AirQuality.fromJson(json.decode(str));

class AirQuality {
  AirQuality({
    this.status,
    this.data,
  });

  String status;
  Data data;

  factory AirQuality.fromJson(Map<String, dynamic> json) => AirQuality(
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  Data({
    this.aqi,
    this.idx,
    this.attributions,
    this.city,
    this.dominentpol,
    this.iaqi,
    this.time,
    this.forecast,
    this.debug,
  });

  int aqi;
  int idx;
  List<Attribution> attributions;
  City city;
  String dominentpol;
  Iaqi iaqi;
  Time time;
  Forecast forecast;
  Debug debug;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        aqi: json["aqi"],
        idx: json["idx"],
        attributions: List<Attribution>.from(
            json["attributions"].map((x) => Attribution.fromJson(x))),
        city: City.fromJson(json["city"]),
        dominentpol: json["dominentpol"],
        iaqi: Iaqi.fromJson(json["iaqi"]),
        time: Time.fromJson(json["time"]),
        forecast: Forecast.fromJson(json["forecast"]),
        debug: Debug.fromJson(json["debug"]),
      );
}

class Attribution {
  Attribution({
    this.url,
    this.name,
    this.logo,
  });

  String url;
  String name;
  String logo;

  factory Attribution.fromJson(Map<String, dynamic> json) => Attribution(
        url: json["url"],
        name: json["name"],
        logo: json["logo"] == null ? null : json["logo"],
      );
}

class City {
  City({
    this.geo,
    this.name,
    this.url,
  });

  List<double> geo;
  String name;
  String url;

  factory City.fromJson(Map<String, dynamic> json) => City(
        geo: List<double>.from(json["geo"].map((x) => x.toDouble())),
        name: json["name"],
        url: json["url"],
      );
}

class Debug {
  Debug({
    this.sync,
  });

  DateTime sync;

  factory Debug.fromJson(Map<String, dynamic> json) => Debug(
        sync: DateTime.parse(json["sync"]),
      );
}

class Forecast {
  Forecast({
    this.daily,
  });

  Daily daily;

  factory Forecast.fromJson(Map<String, dynamic> json) => Forecast(
        daily: Daily.fromJson(json["daily"]),
      );
}

class Daily {
  Daily({
    this.o3,
    this.pm10,
    this.pm25,
    this.uvi,
  });

  List<O3> o3;
  List<O3> pm10;
  List<O3> pm25;
  List<O3> uvi;

  factory Daily.fromJson(Map<String, dynamic> json) => Daily(
        o3: List<O3>.from(json["o3"].map((x) => O3.fromJson(x))),
        pm10: List<O3>.from(json["pm10"].map((x) => O3.fromJson(x))),
        pm25: List<O3>.from(json["pm25"].map((x) => O3.fromJson(x))),
        uvi: List<O3>.from(json["uvi"].map((x) => O3.fromJson(x))),
      );
}

class O3 {
  O3({
    this.avg,
    this.day,
    this.max,
    this.min,
  });

  int avg;
  DateTime day;
  int max;
  int min;

  factory O3.fromJson(Map<String, dynamic> json) => O3(
        avg: json["avg"],
        day: DateTime.parse(json["day"]),
        max: json["max"],
        min: json["min"],
      );
}

class Iaqi {
  Iaqi({
    this.co,
    this.dew,
    this.h,
    this.no2,
    this.o3,
    this.pm10,
    this.pm25,
    this.so2,
    this.t,
    this.w,
  });

  Co co;
  Co dew;
  Co h;
  Co no2;
  Co o3;
  Co pm10;
  Co pm25;
  Co so2;
  Co t;
  Co w;

  factory Iaqi.fromJson(Map<String, dynamic> json) => Iaqi(
        co: Co.fromJson(json["co"]),
        dew: Co.fromJson(json["dew"]),
        h: Co.fromJson(json["h"]),
        no2: Co.fromJson(json["no2"]),
        o3: Co.fromJson(json["o3"]),
        pm10: Co.fromJson(json["pm10"]),
        pm25: Co.fromJson(json["pm25"]),
        so2: Co.fromJson(json["so2"]),
        t: Co.fromJson(json["t"]),
        w: Co.fromJson(json["w"]),
      );
}

class Co {
  Co({
    this.v,
  });

  double v;

  factory Co.fromJson(Map<String, dynamic> json) => Co(
        v: json["v"].toDouble(),
      );
}

class Time {
  Time({
    this.s,
    this.tz,
    this.v,
  });

  DateTime s;
  String tz;
  int v;

  factory Time.fromJson(Map<String, dynamic> json) => Time(
        s: DateTime.parse(json["s"]),
        tz: json["tz"],
        v: json["v"],
      );
}
