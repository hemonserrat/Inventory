import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

import 'package:flutter4_listview/model/UpdateRecord.dart';
import 'package:flutter4_listview/model/SimpleObject.dart';
import 'package:flutter4_listview/util/logger.dart';

class MainFetchData extends StatefulWidget {
  @override
  _MainFetchDataState createState() => _MainFetchDataState();
}

class _MainFetchDataState extends State<MainFetchData> {
  static const channel =
      const MethodChannel("exampleflutter.mfs.com.flutter3listview");

  Future<Null> _openNewPage() async {

    Catalog item = _allRecords[selectedIndex];

    logMessage('_openNewPage with index ' + selectedIndex.toString());

    _updateData(item);

    final response =
        await channel.invokeMethod("openPage", <String, dynamic>{
      'item': item.item.value,
      'cost': item.cost.value,
      'stock': "1",
      'category': item.category.value
    });
    print(response);
  }

  static final String getAllRecordsUrl =
      "https://yourapp.kintone.com/k/v1/records.json?app=2&id=1";

  static final String updateRecordUrl =
      "https://yourapp.kintone.com/k/v1/record.json";

  static final String sampleUrl = "https://jsonplaceholder.typicode.com/photos";

  Map<String, String> requestHeaders = {
    'X-Cybozu-API-token': 'yourtoken'
  };

  List<Catalog> _allRecords = List();
  int selectedIndex = 0;

  var isLoading = false;

  // Fetch from Kintone Database
  _fetchData() async {
    setState(() {
      isLoading = true;
    });

    final response = await http.get(getAllRecordsUrl, headers: requestHeaders);

    if (response.statusCode == 200) {
      logMessage('Fetched Data Now parsing');
      final parsedJson = json.decode(response.body);
      logMessage('Got Parsed Json ');
      final recordsData = SimpleObject.fromJson(parsedJson);
      _allRecords = (recordsData.records as List);
      logMessage('Parsed Data and have list now');
      setState(() {
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load catalog2');
    }
  }

  Map<String, String> updateRequestHeaders = {
    'X-Cybozu-API-token': 'SrropGaww4HxLoicvqz7NWfrVcDFrO0nh91oV0di'
  };

  var stockMap = {
    "app": 2,
    "id": 1,
    "record": {
      "stock": {"value": "32"}
    }
  };

  // Update Kintone Database
  _updateData(Catalog item) async {

    logMessage('_updateData record with index ' + selectedIndex.toString());

    //String currentStockValue = _allRecords[selectedIndex].stock.value;
    int currentStockValue = int.parse(_allRecords[selectedIndex].stock.value);
    --currentStockValue;

    var stockMap1 = new UpdateRecord(2,
        int.parse(_allRecords[selectedIndex].Record_number.value),
        new URecord(new UStock(currentStockValue.toString())));

    String jsonString = jsonEncode(stockMap);

    final response = await http.put(updateRecordUrl,
        body: jsonString, headers: updateRequestHeaders);

    if (response.statusCode == 200) {
      logMessage('Succesfully updated record');
    } else {
      throw Exception('Failed to update record');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          // Here we take the value from the MyHomePage object that
          // was created by the App.build method, and use it to set
          // our appbar title.
          title: new Center(child: new Text("Catalog", textAlign: TextAlign.center)),
          leading: new IconButton(
            icon: new Icon(Icons.replay),
            onPressed: _fetchData,
          ),
        ),

        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add_shopping_cart),
          onPressed: _openNewPage,
          backgroundColor: Colors.red,
          foregroundColor: Colors.black,
        ),

        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : getHomePageBody(context));
  }

  // Build List of UI
  getHomePageBody(BuildContext context) {
    return ListView.builder(
      itemCount: _allRecords.length,
      itemBuilder: _getItemUI,
      padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
    );
  }

  // Build UI Widget
  Widget _getItemUI(BuildContext context, int index) {
    return new Card(
        child: new Column(
      children: <Widget>[
        new ListTile(
          leading: new Image.network(
            _allRecords[index].imgurl.value,
            fit: BoxFit.contain,
            height: 60.0,
            width: 60.0,
          ),
          title: new Text(
            _allRecords[index].item.value,
            style: new TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
          subtitle: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(_allRecords[index].category.value,
                    style: new TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.normal)),
                new Text('Stock: ${_allRecords[index].stock.value}',
                    style: new TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.normal)),
              ]),
          onTap: () {
            selectedIndex = index;
            _showSnackBar(context, _allRecords[index]);
          },
        )
      ],
    ));
  }

  _showSnackBar(BuildContext context, Catalog item) {
    final SnackBar objSnackbar = new SnackBar(
      content: new Text("1 ${item.item.value} ${item.category.value} is "
          "selected"),
      backgroundColor: Colors.amber,
    );
    Scaffold.of(context).showSnackBar(objSnackbar);
  }
}
