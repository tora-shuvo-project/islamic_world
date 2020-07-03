
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:searchtosu/pages/Al_Quran_Page.dart';

class SplashScreen extends StatefulWidget {


  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Introduction(),
    );
  }
}

class Introduction extends StatelessWidget {
  static final route = '/into_page';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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