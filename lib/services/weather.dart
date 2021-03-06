import 'location.dart';
import 'networking.dart';
const  String Key='9288e04bd920ccec92cf8595a443a07b';
const String OpenMapUrl='https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {

  Future<dynamic> getCityWeather(String City) async {


    NetworkHelper n1 = NetworkHelper('$OpenMapUrl?q=$City&appid=$Key&units=metric');

    var WeatherData = await n1.getData();
    return WeatherData;

  }

  Future<dynamic> getLocationWeather() async {
    Location location= Location();
    await location.getCurrentLocation();

    NetworkHelper n1 = NetworkHelper('$OpenMapUrl?lat=${location.latitude}&lon=${location.longitude}&appid=$Key&units=metric');
    var WeatherData = await n1.getData();
    return WeatherData;

}
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '๐ฉ';
    } else if (condition < 400) {
      return '๐ง';
    } else if (condition < 600) {
      return 'โ๏ธ';
    } else if (condition < 700) {
      return 'โ๏ธ';
    } else if (condition < 800) {
      return '๐ซ';
    } else if (condition == 800) {
      return 'โ๏ธ';
    } else if (condition <= 804) {
      return 'โ๏ธ';
    } else {
      return '๐คทโ';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s ๐ฆ time';
    } else if (temp > 20) {
      return 'Time for shorts and ๐';
    } else if (temp < 10) {
      return 'You\'ll need ๐งฃ and ๐งค';
    } else {
      return 'Bring a ๐งฅ just in case';
    }
  }
}
