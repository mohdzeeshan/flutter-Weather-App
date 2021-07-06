import 'package:clima/screens/city_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:geolocator/geolocator.dart';
import 'package:clima/screens/loading_screen.dart';
import 'package:clima/services/weather.dart';

class LocationScreen extends StatefulWidget {

  LocationScreen({@required this.locationWeather});
  final locationWeather;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();

  int temprature;
  String WeatherIcon;
  String cityName;
  String message;


  @override
  void initState() {
    super.initState();
    return UpdateUI(widget.locationWeather);
  }

  void UpdateUI(dynamic weatherData)
  {
    setState(() {
      if(weatherData == null){
        temprature =0;
        WeatherIcon ='Error';
        message = 'Failed to get Weather Data';
        cityName='';
        return;
      }
      double temp = weatherData['main']['temp'];
    temprature=temp.toInt();
    message = weather.getMessage(temprature);

    int condition = weatherData['weather'][0]['id'];

    WeatherIcon = weather.getWeatherIcon(condition);

    cityName =weatherData['name'];
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // ignore: deprecated_member_use
                  FlatButton(
                    onPressed: () async {
                      var WeatherData = await weather.getLocationWeather();
                      UpdateUI(WeatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {

                      var typedName = await Navigator.push(context, MaterialPageRoute(builder: (context){
                        return CityScreen();})
                      );

                      print(typedName);
                      if(typedName != null)
                        {
                           var WeatherData = await weather.getCityWeather(typedName);
                           UpdateUI(WeatherData);

                        }

                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temprature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      WeatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$message in $cityName!',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//

//