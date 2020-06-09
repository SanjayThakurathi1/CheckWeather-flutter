import 'package:http/http.dart' as http;
//import 'package:clima/screens/location_screen.dart';
import 'dart:convert';
var jsondata;

class Networking
{
  Networking(this.url);
   final String url;
   String decodedata;
  Future getlivedata() async {
    final response =
        await http.get(url);
     jsondata = jsonDecode(response.body);
     return jsondata;
    }
    
  
  }
  