
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

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{

  int fojorHour_start,aoyabinHour,johaurHour,asorHour,magribHour,esaHour,sunriseHour;
  int date1;
  PrayerTimeModels prayerTimeModels;
  String zilaName;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController=AnimationController(
      duration:  const Duration(seconds: 1),
      vsync: this,
    )..repeat();
    Timer(
        Duration(seconds: 3),
            (){
              Navigator.pushReplacementNamed(context, HomeScreen.route);
            });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Stack(
        alignment: Alignment.center,
        fit: StackFit.passthrough,
        children: <Widget>[
          Image.asset('images/splash.png',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,fit: BoxFit.fill,),
          AnimatedBuilder(
            animation: _animationController,
            builder: (_,__)=>Container(
              height: 1000,
              decoration: BoxDecoration(
                  gradient: RadialGradient(
                      radius:1.5,
                      colors: [
                        Colors.yellow,
                        Colors.transparent
                      ]
                      , stops: [0,_animationController.value]
                  )
              ),
            ),

          ),
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