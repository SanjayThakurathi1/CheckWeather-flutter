import 'package:clima/services/networking.dart';
 import 'package:clima/services/location.dart';
 

  const apikey = '2299661cdb9b4d1c6f24be48dc8f0167';
 //const openWeatheerUrl ='https://api.openweathermap.org/data/2.5/?lat=${loc.latitude}&lon=${loc.longitude}&appid=$apikey&units=metric';

class WeatherModel {
    
  double latitude;
  double longitude;
 var weatherData;

  Future<dynamic>  getweatherdatafromcity( String cityname) async
   {
     Networking ntw = Networking("https://api.openweathermap.org/data/2.5/weather?q=$cityname&appid=$apikey&units=metric");
     var wdata =  await ntw.getlivedata();
     return wdata;
   }
   
 Future<dynamic> getweatherdata() async
{
   Location loc = Location();
    await loc.getcurrentloc();
     latitude =loc.latitude;
     longitude =loc.longitude;
  
    

    Networking networking =  Networking(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apikey&units=metric');
         weatherData = await networking.getlivedata();
         return weatherData;
         
        
}
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}