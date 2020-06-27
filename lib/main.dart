import 'package:flutter/material.dart';
import 'package:freshbreath/data/air_quaity_provider.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AirQualityProvider(),
      child: MaterialApp(
        title: 'Material App',
        home: Scaffold(
          appBar: AppBar(
            title: Text('Material App Bar'),
          ),
          body: Center(
            child: Container(
              child: Text('Hello World'),
            ),
          ),
        ),
      ),
    );
  }
}
