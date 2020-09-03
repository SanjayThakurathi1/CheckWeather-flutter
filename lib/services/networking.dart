import 'package:http/http.dart' as http;
//import 'package:clima/screens/location_screen.dart';
import 'dart:convert';
var jsondata;

/*class Networking
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
  */

  class Networking
{
  Networking(this.url);
   final String url;
   String decodedata;
  Future<dynamic> getlivedata() async {
    http.Response response = await http.get(url);
    if(response.statusCode==200)
    {
      String data = response.body;
      return jsonDecode(data);
    }
    else 
    {
      print(response.statusCode);
    }
    }
    
  
  }