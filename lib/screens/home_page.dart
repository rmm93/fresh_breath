import 'package:flutter/material.dart';
import 'package:freshbreath/screens/search_screen.dart';
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
      builder: (context, snapshot) => snapshot.connectionState ==
              ConnectionState.waiting
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Scaffold(
              body: SafeArea(
                child: PageView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  children: [
                    // Text(airData.items[0].status),
                    AirFirstPage(toValue: airData.items[0].data.aqi.toDouble()),
                    DetailScreen(),
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchScreen()));
                },
                child: Icon(Icons.search),
              ),
            ),
    );
  }
}
