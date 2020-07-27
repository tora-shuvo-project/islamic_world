
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:searchtosu/FinalModels/prayer_time_models.dart';
import 'package:searchtosu/pages/home_screen.dart';

class SplashScreen extends StatefulWidget {

  static final route='/launch';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  int fojorHour_start,aoyabinHour,johaurHour,asorHour,magribHour,esaHour,sunriseHour;
  int date1;
  PrayerTimeModels prayerTimeModels;
  String zilaName;

  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
            (){
              Navigator.pushReplacementNamed(context, HomeScreen.route);
            });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Stack(
        fit: StackFit.passthrough,
        children: <Widget>[
          Image.asset('images/splash.png',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,fit: BoxFit.fill,),

          Align(
            alignment: Alignment.center,
            child: AnimatedContainer(
              duration: Duration(seconds: 13),
              child: Image.asset('images/app_logo.png',width: 200,height: 200,),
            ),
          ),

          Positioned(
            bottom: 30,
            left: 10,
            right: 10,
            child: Image.asset('images/splash_text.png',width: 20,height: 40,),
          ),
        ],
      ),
    );
  }
}