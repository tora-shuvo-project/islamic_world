
import 'package:flutter/material.dart';
import 'package:searchtosu/pages/SplashScreen.dart';
import 'package:searchtosu/pages/home_screen.dart';
import 'package:searchtosu/pages/quran_word_pages.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Islamic World',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen() ,
      routes: {
        SplashScreen.route:(context)=>SplashScreen(),
        HomeScreen.route:(context)=>HomeScreen(),
        QuranWordPages.route:(context)=>QuranWordPages(),
      },
    );
  }
}



