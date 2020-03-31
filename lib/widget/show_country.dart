import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ungcovid/models/country_model.dart';

class ShowCountry extends StatefulWidget {
  @override
  _ShowCountryState createState() => _ShowCountryState();
}

class _ShowCountryState extends State<ShowCountry> {
  // Field
  final String urlAPI = 'https://corona.lmao.ninja/countries';
  List<CountryModel> countryModels = List();

  // Method
  @override
  void initState() {
    super.initState();
    readAllData();
  }

  Future<void> readAllData() async {
    try {
      Response response = await Dio().get(urlAPI);
      print('response = $response');

      // var result = json.decode(response.data);
      for (var map in response.data) {
        CountryModel countryModel = CountryModel.fromJson(map);
        setState(() {
          countryModels.add(countryModel);
        });
      }
    } catch (e) {
      print('e ===>> ${e.toString()}');
    }
  }

  Widget showProcess() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget showImage(int index) {
    var object = countryModels[index].countryInfo;
    String url = object.toJson()['flag'];

    return Container(
      padding: EdgeInsets.all(16.0),
      width: MediaQuery.of(context).size.width * 0.5,
      child: Image.network(url),
    );
  }

  Widget showText(int index) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      child: Column(
        children: <Widget>[
          showCountry(index),
          showCases(index),
          showToday(index),
        ],
      ),
    );
  }

  Text showToday(int index) => Text(countryModels[index].todayCases.toString());

  Text showCases(int index) => Text('Cases = ${countryModels[index].cases.toString()}', style: TextStyle(fontWeight: FontWeight.bold),);

  Widget showCountry(int index) => Text(
        countryModels[index].country,
        style: TextStyle(fontSize: 24.0,color: Colors.blue.shade800),
      );

  Widget showListView() {
    return ListView.builder(
      itemCount: countryModels.length,
      itemBuilder: (BuildContext context, int index) {
        return Row(
          children: <Widget>[
            showImage(index),
            showText(index),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Show Country'),
      ),
      body: countryModels.length == 0 ? showProcess() : showListView(),
    );
  }
}
