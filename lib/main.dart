import 'package:flutter/material.dart';
import 'package:freshbreath/data/air_quaity_provider.dart';
import 'package:freshbreath/screens/home_page.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AirQualityProvider(),
      child: MaterialApp(
        home: HomePage(),
      ),
    );
  }
}
