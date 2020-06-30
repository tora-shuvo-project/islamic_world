

import 'package:flutter/material.dart';
import 'package:searchtosu/helpers/query_helpers.dart';
import 'package:searchtosu/main.dart';
import 'package:searchtosu/models/quran_sura_models.dart';
import 'package:searchtosu/pages/Al_Quran_Page.dart';
import 'package:searchtosu/utils/add_database_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroPage extends StatelessWidget {
  static final route = '/into_page';
  @override
  Widget build(BuildContext context) {
    AddDatabaseData addDatabaseData=AddDatabaseData();
    _addSuraName(){
      addDatabaseData.allSuraList.forEach((suralist) {
        QueryHelpers.insertquransura(TABLE_SURA_MODELS, suralist.tomap()).then((value){
          print(value.toString());
          print(suralist.paraNo);

        });

      });
    }

    return Scaffold(
      body: Center(
        child: FlatButton(onPressed: (){
          _addSuraName();
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> AlQuranPage()));
        }, child: null),
      ),
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