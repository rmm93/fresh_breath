import 'package:flutter/foundation.dart';
import 'package:freshbreath/data/air_quality.dart';

class AirQualityProvider with ChangeNotifier {
  AirQuality _items = AirQuality();

  AirQuality get items {
    return _items;
  }
  
}
