import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';



class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
    @override
  void initState() {
   getLocationData();
    // TODO: implement initState
    super.initState();
  }

 void getLocationData() async {


      var WeatherData = await WeatherModel().getLocationWeather();

     Navigator.push(context, MaterialPageRoute(builder: (context){
       return LocationScreen(locationWeather: WeatherData,);

     }));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
     backgroundColor: Colors.green,
      body: Center(
        child: SpinKitChasingDots(
          color: Colors.white,
          size: 100.0,
        ),
      ),

    );
  }
}
