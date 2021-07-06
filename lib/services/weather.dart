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
