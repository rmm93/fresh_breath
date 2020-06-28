import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freshbreath/data/air_quaity_provider.dart';
import 'package:freshbreath/data/confidential.dart';
import 'package:freshbreath/data/search_data.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _controller = TextEditingController();

  SearchData searchData;

  SearchData recentCities = SearchData(
    status: "ok",
    data: [
      Datum(
          uid: 11276,
          aqi: "68",
          time: Time(
              tz: "+05:30",
              stime: DateTime(2020 - 06 - 28, 13, 00, 00),
              vtime: 1593329400),
          station: Station(
            name: "bangalore; Jayanagar 5th Block, Bengaluru, India",
            geo: [12.920984, 77.584908],
            url: "india/bengaluru/jayanagar-5th-block",
            country: "IN",
          )),
      Datum(
          uid: 3758,
          aqi: "68",
          time: Time(
              tz: "+05:30",
              stime: DateTime(2020 - 06 - 28, 13, 00, 00),
              vtime: 1593329400),
          station: Station(
            name: "Peenya, Bangalore, India",
            geo: [13.0339, 77.51321111],
            url: "india/bangalore/peenya",
            country: "IN",
          )),
      Datum(
          uid: 11293,
          aqi: "63",
          time: Time(
              tz: "+05:30",
              stime: DateTime(2020 - 06 - 26, 08, 00, 00),
              vtime: 1593138600),
          station: Station(
            name: "bangalore; Silk Board, Bengaluru, India",
            geo: [12.917348, 77.622813],
            url: "india/bengaluru/silk-board",
            country: "IN",
          )),
      Datum(
          uid: 11270,
          aqi: "61",
          time: Time(
              tz: "+05:30",
              stime: DateTime(2020 - 06 - 28, 13, 00, 00),
              vtime: 1593329400),
          station: Station(
            name: "bangalore; Hombegowda Nagar, Bengaluru, India",
            geo: [12.938539, 77.5901],
            url: "india/bengaluru/hombegowda-nagar",
            country: "IN",
          )),
    ],
  );
  final searchUrl = 'https://api.waqi.info/search/?token=$apiKey&keyword=';

  StreamController _streamController;
  Stream _stream;

  Timer _debounce;

  _search() async {
    if (_controller.text == null || _controller.text.length == 0) {
      _streamController.add(null);
      return;
    }

    _streamController.add("waiting");
    Response response = await get(searchUrl + _controller.value.text.trim());
    _streamController.add(json.decode(response.body));
  }

  @override
  void initState() {
    super.initState();

    _streamController = StreamController();
    _stream = _streamController.stream;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 12.0, bottom: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  child: TextFormField(
                    onChanged: (String text) async {
                      if (_debounce?.isActive ?? false) _debounce.cancel();
                      _debounce = Timer(const Duration(milliseconds: 1000), () {
                        _search();
                      });
                    },
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Search for a city",
                      contentPadding: const EdgeInsets.only(left: 24.0),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: StreamBuilder(
        stream: _stream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Center(
              child: Text("Enter a search word preferably a district."),
            );
          }

          if (snapshot.data == "waiting") {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            final data = snapshot.data;
            print(data["data"][0]["station"]["name"]);
            if (data["data"].length == 0) {
              return Text('Type a nearby place');
            }
            return ListView.builder(
              itemCount: data["data"].length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Icon(Icons.location_city),
                  title: Text(data["data"][index]["station"]["name"]),
                  onTap: () async {
                    print(data["data"][index]["station"]["url"]);
                    await Provider.of<AirQualityProvider>(context, listen: false)
                        .dataFromSearch(
                            data["data"][index]["station"]["url"]);
                    Navigator.of(context).pop();
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
