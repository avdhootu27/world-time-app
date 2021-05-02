import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime {

  String location;
  String time;
  String flag;
  String url;
  bool isDayTime;

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    try{
      Response response = await http.get(Uri.https('worldtimeapi.org','api/timezone/$url'));
      Map data = jsonDecode(response.body);

      // get properties from data
      String dateTime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);
      String offsetm = data['utc_offset'].substring(4,6);

      DateTime now = DateTime.parse(dateTime);
      now = now.add(Duration(hours: int.parse(offset)));
      now = now.add(Duration(minutes: int.parse(offsetm)));

      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);

    }
    catch(e){
      print('Caught error: $e');
      time = 'Could not get time data';
    }

  }

}