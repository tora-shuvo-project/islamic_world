import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:searchtosu/helpers/query_helpers.dart';
import 'package:searchtosu/models/quran_sura_models.dart';
import 'package:searchtosu/pages/Al_Quran_Page.dart';

import 'package:searchtosu/utils/add_quran_sura.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {


  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool visitingSign = false;
  _checkLogin() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool alreadyVisited = pref.getBool("isEntered") ?? false;
    setState(() {
      visitingSign = alreadyVisited;
    });
  }

  @override
  void initState() {
    _checkLogin();
    super.initState();
  }
  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: !visitingSign? Introduction(): AlQuranPage(),
    );
  }


}

//setVisitingData() async{
//  SharedPreferences pref = await SharedPreferences.getInstance();
//  pref.setBool("alreadyVisited", true);
//}
//getVisitingData() async{
//  SharedPreferences pref = await SharedPreferences.getInstance();
//  bool alreadyVisited = pref.getBool("alreadyVisited") ?? false;
//  return alreadyVisited;
//}
class Introduction extends StatelessWidget {
  static final route = '/into_page';
  @override
  Widget build(BuildContext context) {
    AddQuranSura addDatabaseData=AddQuranSura();
    _addSuraName(){
      addDatabaseData.allSuraList.forEach((suralist) {
        QueryHelpers.insertquransura(TABLE_SURA_MODELS, suralist.tomap()).then((value){
          print(value.toString());
          print(suralist.paraNo);


        });

      });
    }

    return Scaffold(
      body:

             Center(
               child: Column(
                 mainAxisSize: MainAxisSize.min,
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: <Widget>[
                   Image.asset("images/kuranIcon.png", width:150,
                       height:  150,fit:BoxFit.cover,),
                   SizedBox(height: 25,),
                   ClipRRect(
                     borderRadius: BorderRadius.circular(30),
                     child: Container(
                       width: 100,
                       height: 50,
                       decoration: BoxDecoration(
                         color: Color(0xff178723)
                       ),
                       child: FlatButton(
                           onPressed: (){

                         _addSuraName();
                         setIsLogin();
                         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> AlQuranPage()));
                       }, child: Text("Welcome", style: TextStyle(color: Colors.white),)),
                     ),
                   ),
                 ],
               ),
             ),






    );
  }
}
setIsLogin() async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setBool("isEntered", true);
}