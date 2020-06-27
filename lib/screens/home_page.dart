import 'package:flutter/material.dart';
import 'package:freshbreath/data/air_quaity_provider.dart';
import 'package:freshbreath/screens/air_first_page.dart';
import 'package:freshbreath/screens/detail_screen.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final airData = Provider.of<AirQualityProvider>(context).items;
    return Scaffold(
      body: SafeArea(
        child: PageView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          children: [
            AirFirstPage(toValue: airData.data.aqi.toDouble()),
            DetailScreen(),
          ],
        ),
      ),
    );
  }
}
