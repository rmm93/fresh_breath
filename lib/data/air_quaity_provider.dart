import 'package:flutter/foundation.dart';
import 'package:freshbreath/data/air_quality.dart';

class AirQualityProvider with ChangeNotifier {
  AirQuality _items = AirQuality(
      status: "ok",
      data: Data(
        aqi: 140,
        idx: 12428,
        attributions: [
          Attribution(
              url: "http://cpcb.nic.in/",
              name: "CPCB - India Central Pollution Control Board",
              logo: "India-CPCB.png"),
          Attribution(
              url: "https://waqi.info/",
              name: "World Air Quality Index Project")
        ],
        city: City(
            geo: [30.751462, 76.762879],
            name: "Sector-25, Chandigarh, India",
            url: "https://aqicn.org/city/india/chandigarh/sector-25"),
        dominentpol: "pm25",
        iaqi: Iaqi(
            co: Co(v: 2.3),
            dew: Co(v: 27.1),
            h: Co(v: 75.05),
            no2: Co(v: 5.2),
            o3: Co(v: 15),
            pm10: Co(v: 56),
            pm25: Co(v: 90),
            so2: Co(v: 4),
            t: Co(v: 33.4),
            w: Co(v: 0.625)),
        time: Time(
            s: DateTime(2020, 06, 27, 21, 00, 00), tz: "+05:30", v: 1593291600),
        forecast: Forecast(
          daily: Daily(o3: [
            O3(avg: 31, day: DateTime(2020 - 06 - 25), max: 43, min: 24),
            O3(avg: 34, day: DateTime(2020 - 06 - 26), max: 59, min: 15),
            O3(avg: 41, day: DateTime(2020 - 06 - 27), max: 61, min: 23),
            O3(avg: 38, day: DateTime(2020 - 06 - 28), max: 60, min: 29),
            O3(avg: 44, day: DateTime(2020 - 06 - 29), max: 72, min: 31),
            O3(avg: 47, day: DateTime(2020 - 06 - 30), max: 73, min: 34),
            O3(avg: 46, day: DateTime(2020 - 07 - 01), max: 72, min: 31),
            O3(avg: 27, day: DateTime(2020 - 07 - 02), max: 47, min: 27)
          ], pm10: [
            O3(avg: 54, day: DateTime(2020 - 06 - 25), max: 56, min: 51),
            O3(avg: 103, day: DateTime(2020 - 06 - 26), max: 122, min: 61),
            O3(avg: 107, day: DateTime(2020 - 06 - 27), max: 122, min: 75),
            O3(avg: 117, day: DateTime(2020 - 06 - 28), max: 122, min: 73),
            O3(avg: 114, day: DateTime(2020 - 06 - 29), max: 122, min: 80),
            O3(avg: 55, day: DateTime(2020 - 06 - 30), max: 72, min: 45),
            O3(avg: 46, day: DateTime(2020 - 07 - 01), max: 57, min: 45),
            O3(avg: 51, day: DateTime(2020 - 07 - 02), max: 61, min: 45),
            O3(avg: 97, day: DateTime(2020 - 07 - 03), max: 122, min: 48)
          ], pm25: [
            O3(avg: 137, day: DateTime(2020 - 06 - 25), max: 137, min: 137),
            O3(avg: 142, day: DateTime(2020 - 06 - 26), max: 156, min: 137),
            O3(avg: 149, day: DateTime(2020 - 06 - 27), max: 158, min: 137),
            O3(avg: 137, day: DateTime(2020 - 06 - 28), max: 137, min: 137),
            O3(avg: 137, day: DateTime(2020 - 06 - 29), max: 137, min: 137),
            O3(avg: 137, day: DateTime(2020 - 06 - 30), max: 137, min: 137),
            O3(avg: 137, day: DateTime(2020 - 07 - 01), max: 137, min: 137),
            O3(avg: 133, day: DateTime(2020 - 07 - 02), max: 137, min: 89),
            O3(avg: 141, day: DateTime(2020 - 07 - 03), max: 156, min: 133)
          ], uvi: [
            O3(avg: 2, day: DateTime(2020 - 06 - 27), max: 7, min: 0),
            O3(avg: 1, day: DateTime(2020 - 06 - 28), max: 8, min: 0),
            O3(avg: 1, day: DateTime(2020 - 06 - 29), max: 8, min: 0),
            O3(avg: 1, day: DateTime(2020 - 06 - 30), max: 7, min: 0),
            O3(avg: 1, day: DateTime(2020 - 07 - 01), max: 6, min: 0),
            O3(avg: 0, day: DateTime(2020 - 07 - 02), max: 0, min: 0)
          ]),
        ),
        // debug: Debug(
        //     sync: 2020-06-28T01:13:41+09:00
        // )
      ));

  AirQuality get items {
    return _items;
  }
}
