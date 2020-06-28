import 'package:flutter/material.dart';
import 'package:freshbreath/data/app_images.dart';
import 'package:provider/provider.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:freshbreath/data/air_quaity_provider.dart';
import 'package:freshbreath/screens/air_first_page.dart';
import 'package:freshbreath/screens/detail_screen.dart';

class HomePage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final airData = Provider.of<AirQualityProvider>(context);
    final future = useMemoized(() => airData.fetchAndSetData());
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
              ? loadingScreen()
              : Scaffold(
                  floatingActionButton: FloatingActionButton(
                    onPressed: () {},
                    backgroundColor: Colors.blueGrey,
                    child: Icon(Icons.bubble_chart),
                  ),
                  body: SafeArea(
                    child: PageView(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      children: [
                        AirFirstPage(
                          toValue: airData.items[0].data.aqi.toDouble(),
                          airQuality: airData.items[0],
                        ),
                        DetailScreen(),
                      ],
                    ),
                  ),
                ),
    );
  }

  Widget loadingScreen() {
    return Scaffold(
      body: Container(
        child: Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            Image.asset(
              splash,
              fit: BoxFit.fill,
            ),
            Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    splash_title,
                    width: 300.0,
                  ),
                  SizedBox(height: 50.0,),
                  CircularProgressIndicator()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
