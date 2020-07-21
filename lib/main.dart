
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:searchtosu/helpers/place_provider.dart';
import 'package:searchtosu/helpers/provider_helpers.dart';
import 'package:searchtosu/pages/SplashScreen.dart';
import 'package:searchtosu/pages/home_screen.dart';
import 'package:searchtosu/pages/quran_word_pages.dart';
import 'package:searchtosu/pages/shomoy_shuchi_page.dart';


void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create:(context)=>LocationProvider() ,
          ),
          ChangeNotifierProvider(
            create:(context)=>PlaceProvider() ,
          ),
      ],

      child: MaterialApp(

        title: 'Islamic World',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'kalpurus',
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SplashScreen() ,
        routes: {
          SplashScreen.route:(context)=>SplashScreen(),
          HomeScreen.route:(context)=>HomeScreen(),
          QuranWordPages.route:(context)=>QuranWordPages(),
          ShomoyShuchi.route: (context)=> ShomoyShuchi(),
        },
      ),
    );
  }
}



