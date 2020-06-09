import 'dart:io';
import 'package:clima/screens/location_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clima/services/weather.dart';

import 'package:connectivity/connectivity.dart';

const apikey = '2299661cdb9b4d1c6f24be48dc8f0167';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double latitude;
  double longitude;
  var weatherdata;
  ConnectivityResult previous;

  void checkinternet() {
    try {
      InternetAddress.lookup("www.google.com").then((result) {
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          getlocationdata();
        } else {
          showdialog();
        }
      }).catchError((error) {
        showdialog();
      });
    } on SocketDirection catch (_) {
      showdialog();
    }
    Connectivity().onConnectivityChanged.listen((ConnectivityResult conn) {
      if (conn == ConnectivityResult.none) {
        showdialog();
      } else if (previous == ConnectivityResult.none) {
        getlocationdata();
      }
      previous = conn;
    });
  }
  @override
  void dispose()
  {
    super.dispose();
  }

  void showdialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Check your Internet Connection"),
              backgroundColor: Colors.black,
              elevation: 30,
              content: Text("No internet Detected"),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      SystemChannels.platform
                          .invokeMethod("Systemnavigator.pop");
                    },
                    child: Text(
                      "Exit",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ))
              ],
            ));
  }

  Future<void> getlocationdata() async {
    WeatherModel wb = WeatherModel();
    weatherdata = await wb.getweatherdata();

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LocationScreen(
                  locationweather: weatherdata,
                )));
  }

  @override
  void initState() {
    super.initState();
    checkinternet();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SpinKitDoubleBounce(
                color: Colors.amber,
                size: 90,
              ),
            ),
            CircularProgressIndicator(
              backgroundColor: Colors.red,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text("Loading.."),
            ),
          ],
        ),
      ),
    );
  }
}
