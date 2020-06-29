import 'package:flutter/material.dart';
import 'package:freshbreath/data/air_quality.dart';
import 'package:freshbreath/data/app_images.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_icons/weather_icons.dart';

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
  String _aqiStatus;
  String _aqiImage;
  double screenWidth, screenHeight;

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
    _aqiColor = getAQIUpdate(widget.toValue);
  }

  @override
  Future<void> dispose() async {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: double.infinity,
      child: SingleChildScrollView(
        child: getNewHome(),
      ),
    );
  }

  Widget getNewHome() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 30.0,
        ),
        getTopLocationRow(),
        getMainAQIInfo(),
        getTemperatureRow(),
        SizedBox(
          height: 30.0,
        ),
        getBottomDetailsRow(),
      ],
    );
  }

  Widget getBottomDetailsRow() {
    return Wrap(
      direction: Axis.horizontal,
      alignment: WrapAlignment.spaceAround,
      runAlignment: WrapAlignment.start,
      children: <Widget>[
        getDetailsRowItem(
            color: _aqiColor,
            num: widget.airQuality.data.iaqi.pm25.toString() == "null"
                ? 'N/A'
                : widget.airQuality.data.iaqi.pm25.v.toString(),
            label: "PM 2.5"),
        getDetailsRowItem(
            color: Colors.green,
            num: widget.airQuality.data.iaqi.o3.toString() == "null"
                ? 'N/A'
                : widget.airQuality.data.iaqi.o3.v.toString(),
            label: "O3"),
        getDetailsRowItem(
            color: Colors.green,
            num: widget.airQuality.data.iaqi.no2.toString() == "null"
                ? 'N/A'
                : widget.airQuality.data.iaqi.no2.v.toString(),
            label: "NO2"),
        getDetailsRowItem(
            color: Colors.green,
            num: widget.airQuality.data.iaqi.so2.toString() == "null"
                ? 'N/A'
                : widget.airQuality.data.iaqi.so2.v.toString(),
            label: "SO2"),
        getDetailsRowItem(
            color: Colors.green,
            num: widget.airQuality.data.iaqi.co.toString() == "null"
                ? 'N/A'
                : widget.airQuality.data.iaqi.co.v.toString(),
            label: "CO"),
      ],
    );
  }

  Widget getDetailsRowItem({Color color, String num, String label}) {
    return Container(
      margin: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.3),
            offset: Offset(-6.0, -6.0),
            blurRadius: 16.0,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: Offset(6.0, 6.0),
            blurRadius: 16.0,
          ),
        ],
        color: Color(0xFFEFEEEE),
        borderRadius: BorderRadius.circular(50.0),
      ),
      width: screenWidth / 6,
      height: screenHeight / 6,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          CircleAvatar(
            backgroundColor: color,
            child: Text(
              num,
              style: GoogleFonts.saira(
                  color: Colors.black54,
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Text(label)
        ],
      ),
    );
  }

  Widget getTemperatureRow() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        tempRowItem(
            iconData: WeatherIcons.cloud,
            num: widget.airQuality.data.iaqi.t.v.toString(),
            unit: "°C"),
        tempRowItem(
            iconData: WeatherIcons.humidity,
            num: widget.airQuality.data.iaqi.h.v.toStringAsFixed(2),
            unit: "%"),
        tempRowItem(
            iconData: WeatherIcons.wind,
            num: widget.airQuality.data.iaqi.w.v.toStringAsFixed(2),
            unit: "km/h"),
      ],
    );
  }

  Widget tempRowItem({IconData iconData, String num, String unit}) {
    return Container(
      width: screenWidth / 4,
      height: screenWidth / 8,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.3),
            offset: Offset(-6.0, -6.0),
            blurRadius: 16.0,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: Offset(6.0, 6.0),
            blurRadius: 16.0,
          ),
        ],
        color: Color(0xFFEFEEEE),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          BoxedIcon(
            iconData,
            size: 20.0,
            color: Colors.black38,
          ),
          Text(
            num,
            style: GoogleFonts.openSans(),
          ),
          Text(
            unit,
            style: GoogleFonts.openSans(fontSize: 12.0),
          ),
        ],
      ),
    );
  }

  Widget getMainAQIInfo() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(20.0),
          width: screenWidth,
          height: screenHeight / 8,
//          decoration: BoxDecoration(
//            color: _aqiColor,
//            shape: BoxShape.rectangle,
//            borderRadius: BorderRadius.all(
//              Radius.circular(10.0),
//            ),
//          ),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: _aqiColor.withOpacity(0.3),
                offset: Offset(-6.0, -6.0),
                blurRadius: 16.0,
              ),
              BoxShadow(
                color: _aqiColor.withOpacity(0.2),
                offset: Offset(6.0, 6.0),
                blurRadius: 16.0,
              ),
            ],
            color: _aqiColor,
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Image.asset(
                _aqiImage,
                width: screenWidth / 5,
              ),
              Column(
                children: <Widget>[
                  Text(
                    '$_number',
                    style: GoogleFonts.saira(
                        fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'AQI',
                    style: GoogleFonts.saira(fontSize: 12.0),
                  )
                ],
              ),
              Text(
                '$_aqiStatus',
                textAlign: TextAlign.center,
                style: GoogleFonts.saira(
                    fontSize: 14.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget getTopLocationRow() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(Icons.location_on),
        Text(widget.airQuality.data.city.name)
      ],
    );
  }

  Color getAQIUpdate(double aqi) {
    Color color = Colors.white;

    if (aqi < 50) {
      color = Colors.green;
      _aqiStatus = "Good";
      _aqiImage = aqi_1;
    }

    if (aqi >= 50 && aqi < 100) {
      color = Colors.yellow;
      _aqiStatus = "Moderate";
      _aqiImage = aqi_2;
    }

    if (aqi >= 100 && aqi < 150) {
      color = Colors.deepOrangeAccent;
      _aqiStatus = "Unhealthy\nfor\nSensitive Groups";
      _aqiImage = aqi_3;
    }

    if (aqi >= 150 && aqi < 200) {
      color = Colors.red;
      _aqiStatus = "Unhealthy";
      _aqiImage = aqi_4;
    }

    if (aqi >= 200 && aqi < 300) {
      color = Colors.deepPurpleAccent;
      _aqiStatus = "Very Unhealthy";
      _aqiImage = aqi_5;
    }
    if (aqi >= 300) {
      color = Colors.brown;
      _aqiStatus = "Hazardous";
      _aqiImage = aqi_6;
    }

    return color;
  }

/*
  Below this is the First Home Screen
   */
/*
  Widget getFirstTopHomePage() {
    return Column(
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
                  style: GoogleFonts.openSans(),
                ),
                Text(
                  '$_number',
                  style: GoogleFonts.openSans(),
                ),
                Container(
                  height: 2.0,
                  color: Colors.black45,
                  margin:
                      EdgeInsets.symmetric(horizontal: 120.0, vertical: 10.0),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.cloud_queue),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      '${widget.airQuality.data.iaqi.t.v.toStringAsPrecision(2)}°C',
                      style: GoogleFonts.openSans(),
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
*/
}
