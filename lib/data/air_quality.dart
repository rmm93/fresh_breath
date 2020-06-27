// To parse this JSON data, do
//
//     final airQuality = airQualityFromJson(jsonString);

import 'dart:convert';

AirQuality airQualityFromJson(String str) =>
    AirQuality.fromJson(json.decode(str));

String airQualityToJson(AirQuality data) => json.encode(data.toJson());

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

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };
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

  Map<String, dynamic> toJson() => {
        "aqi": aqi,
        "idx": idx,
        "attributions": List<dynamic>.from(attributions.map((x) => x.toJson())),
        "city": city.toJson(),
        "dominentpol": dominentpol,
        "iaqi": iaqi.toJson(),
        "time": time.toJson(),
        "forecast": forecast.toJson(),
        "debug": debug.toJson(),
      };
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

  Map<String, dynamic> toJson() => {
        "url": url,
        "name": name,
        "logo": logo == null ? null : logo,
      };
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

  Map<String, dynamic> toJson() => {
        "geo": List<dynamic>.from(geo.map((x) => x)),
        "name": name,
        "url": url,
      };
}

class Debug {
  Debug({
    this.sync,
  });

  DateTime sync;

  factory Debug.fromJson(Map<String, dynamic> json) => Debug(
        sync: DateTime.parse(json["sync"]),
      );

  Map<String, dynamic> toJson() => {
        "sync": sync.toIso8601String(),
      };
}

class Forecast {
  Forecast({
    this.daily,
  });

  Daily daily;

  factory Forecast.fromJson(Map<String, dynamic> json) => Forecast(
        daily: Daily.fromJson(json["daily"]),
      );

  Map<String, dynamic> toJson() => {
        "daily": daily.toJson(),
      };
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

  Map<String, dynamic> toJson() => {
        "o3": List<dynamic>.from(o3.map((x) => x.toJson())),
        "pm10": List<dynamic>.from(pm10.map((x) => x.toJson())),
        "pm25": List<dynamic>.from(pm25.map((x) => x.toJson())),
        "uvi": List<dynamic>.from(uvi.map((x) => x.toJson())),
      };
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

  Map<String, dynamic> toJson() => {
        "avg": avg,
        "day":
            "${day.year.toString().padLeft(4, '0')}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}",
        "max": max,
        "min": min,
      };
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

  Map<String, dynamic> toJson() => {
        "co": co.toJson(),
        "dew": dew.toJson(),
        "h": h.toJson(),
        "no2": no2.toJson(),
        "o3": o3.toJson(),
        "pm10": pm10.toJson(),
        "pm25": pm25.toJson(),
        "so2": so2.toJson(),
        "t": t.toJson(),
        "w": w.toJson(),
      };
}

class Co {
  Co({
    this.v,
  });

  double v;

  factory Co.fromJson(Map<String, dynamic> json) => Co(
        v: json["v"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "v": v,
      };
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

  Map<String, dynamic> toJson() => {
        "s": s.toIso8601String(),
        "tz": tz,
        "v": v,
      };
}
