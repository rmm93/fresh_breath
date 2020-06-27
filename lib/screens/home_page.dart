import 'package:flutter/material.dart';
import 'package:freshbreath/data/air_quaity_provider.dart';
import 'package:freshbreath/screens/air_first_page.dart';
import 'package:freshbreath/screens/detail_screen.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with ChangeNotifier {
  @override
  Widget build(BuildContext context) {
    final airData = Provider.of<AirQualityProvider>(context);
    return FutureBuilder(
      future: airData.fetchAndSetData(),
      builder: (context, snapshot) => airData.isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Scaffold(
              body: SafeArea(
                child: PageView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  children: [
                    AirFirstPage(toValue: airData.items.data.aqi.toDouble()),
                    DetailScreen(),
                  ],
                ),
              ),
            ),
    );
  }
}
