import 'package:flutter/material.dart';
import 'package:freshbreath/data/air_quality.dart';

class AirFirstPage extends StatefulWidget {
  const AirFirstPage({
    Key key,
    this.fromValue = 1,
    @required this.toValue,
    @required this.airQuality,
    this.duration = const Duration(milliseconds: 1500),
  })  : assert(fromValue != null),
        assert(airQuality != null),
        assert(toValue != null),
        assert(fromValue <= toValue),
        assert(duration != null),
        super(key: key);

  final double fromValue;
  final double toValue;
  final Duration duration;
  final AirQuality airQuality;

  @override
  State<StatefulWidget> createState() => _AirFirstPageState();
}

class _AirFirstPageState extends State<AirFirstPage>
    with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _controller;

  String _number;
  Color _aqiColor;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _animation = Tween<double>(begin: widget.fromValue, end: widget.toValue)
        .animate(_controller)
          ..addListener(() {
            setState(() {
              _number = _animation.value.toStringAsFixed(0);
            });
          });
    _controller.forward();
    _aqiColor = getAQIColor(widget.toValue);
  }

  @override
  Future<void> dispose() async {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 50.0),
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  height: 200.0,
                  width: 200.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: _aqiColor, width: 8)),
                ),
                Column(
                  children: <Widget>[
                    Text(
                      'AQI',
                      style: textTheme.headline5
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '$_number',
                      style: textTheme.headline3
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      height: 2.0,
                      color: Colors.white,
                      margin: EdgeInsets.symmetric(horizontal: 120.0,vertical: 10.0),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.cloud_queue),
                        SizedBox(width: 10.0,),
                        Text(
                          '${widget.airQuality.data.iaqi.t.v.toStringAsPrecision(2)}°C',
                          style: textTheme.bodyText1
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Icon(Icons.location_on),
                SizedBox(
                  width: 20.0,
                ),
                Text(widget.airQuality.data.city.name)
              ],
            ),
            getAQIInfo(),
          ],
        ),
      ),
    );
  }

  Widget getAQIInfo() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.0),
      padding: EdgeInsets.all(6.0),
      width: MediaQuery.of(context).size.width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            InfoBox(Colors.green, 'Good'),
            InfoBox(Colors.yellow, 'Moderate'),
            InfoBox(
                Colors.deepOrangeAccent, 'Unhealthy\nfor\nSensitive\nGroup'),
            InfoBox(Colors.red, 'Unhealthy'),
            InfoBox(Colors.deepPurpleAccent, 'Very\nUnhealthy'),
            InfoBox(Colors.brown, 'Hazardous'),
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget InfoBox(color, text) {
    return Container(
      width: (MediaQuery.of(context).size.width / 6) - 2,
      height: MediaQuery.of(context).size.height / 10,
      color: color,
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black54, fontSize: 10.0),
        ),
      ),
    );
  }

  Color getAQIColor(double aqi) {
    Color color = Colors.white;

    if (aqi < 50) {
      color = Colors.green;
    }

    if (aqi >= 50 && aqi < 100) {
      color = Colors.yellow;
    }

    if (aqi >= 100 && aqi < 150) {
      color = Colors.deepOrangeAccent;
    }

    if (aqi >= 150 && aqi < 200) {
      color = Colors.red;
    }

    if (aqi >= 200 && aqi < 300) {
      color = Colors.deepPurpleAccent;
    }
    if (aqi >= 300) {
      color = Colors.brown;
    }

    return color;
  }
}
