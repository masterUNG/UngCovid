import 'package:flutter/material.dart';
import 'package:ungcovid/widget/show_country.dart';


void main(){runApp(MyApp());}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ShowCountry(),
    );
  }
}