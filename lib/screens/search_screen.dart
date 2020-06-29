import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import 'package:freshbreath/data/air_quaity_provider.dart';
import 'package:freshbreath/data/confidential.dart';
import 'package:freshbreath/data/search_data.dart';

// ignore: must_be_immutable
class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();

  SearchData searchData;

  final searchUrl = 'https://api.waqi.info/search/?token=$apiKey&keyword=';

  StreamController _streamController;
  Stream _stream;

  Timer _debounce;

  _search() async {
    if (_controller.text == null || _controller.text.isEmpty) {
      _streamController.add(null);
      return;
    }

    _streamController.add("waiting");
    final Response response = await get(searchUrl + _controller.value.text.trim());
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
          preferredSize: const Size.fromHeight(48.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 12.0, bottom: 8.0),
                  decoration: BoxDecoration(
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
                    decoration: const InputDecoration(
                      hintText: "Search for a city",
                      contentPadding: EdgeInsets.only(left: 24.0),
                      border: InputBorder.none,
                    ),
                    cursorColor: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: StreamBuilder(
        stream: _stream,
        // ignore: missing_return
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(
              child: Text("Enter a search word preferably a district."),
            );
          }

          if (snapshot.data == "waiting") {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            final data = snapshot.data;
            if (data["data"].length == 0) {
              return const Text('Type a nearby place');
            }
            return ListView.builder(
              itemCount: data["data"].length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: const Icon(Icons.location_city),
                  title: Text(data["data"][index]["station"]["name"]),
                  onTap: () async {
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
