import 'package:flutter/material.dart';

import 'package:flutter4_listview/data/main_fetch_data.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.amber,
      ),
      //home: new HomePage(),
      home: new MainFetchData(),
    );
  }
}
