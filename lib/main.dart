

import 'dart:async';



import 'package:flutter/material.dart';
import 'package:searchtosu/helpers/query_helpers.dart';
import 'package:searchtosu/models/quran_sura_models.dart';
import 'package:searchtosu/pages/Al_Quran_Page.dart';

import 'package:searchtosu/pages/IntoPage.dart';
import 'package:searchtosu/pages/add_database_table_pages.dart';
import 'package:searchtosu/utils/add_database_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:searchtosu/pages/add_sura_list_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  List<QuranSuraModels> quranSuralist = new List();



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Future<bool> hasVisited() async {
      await getVisitingData();
      setVisitingData();
    }
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      home:  hasVisited() != null? AlQuranPage(): IntroPage(),

    );
  }
}
setVisitingData() async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setBool("alreadyVisited", true);
}
getVisitingData() async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  bool alreadyVisited = pref.getBool("alreadyVisited") ?? false;
  return alreadyVisited;
}


      home: AddSuraListScreen(),
    );
  }
}


