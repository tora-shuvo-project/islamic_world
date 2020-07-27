import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:searchtosu/pages/niyom_category_screen.dart';

class NiyomScreen extends StatelessWidget {

  TextStyle textStyle=TextStyle(fontSize: 18);

  @override
  Widget build(BuildContext context) {
    Widget _appBar(){
      return Container(

        child: ClipRRect(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
          child: Container(
            height:70,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  const Color(0xff178723),
                  const Color(0xff27AB4B)
                ])
            ),
            padding: EdgeInsets.symmetric(horizontal: 17, vertical: 10),
            child: Container(
              color: Colors.green.withOpacity(.1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(icon: Icon(Icons.arrow_back, color: Colors.white,), onPressed: (){
                    Navigator.of(context).pop();
                  }),
                  FittedBox(
                    child: Text('নিয়ম',style:  TextStyle(
                        color: Colors.white, fontSize: 20
                    ), ),
                  ),


                ],
              ),
            ),

          ),

        ),
      );
    }
    return SafeArea(
      child: Scaffold(
        appBar:PreferredSize(child: _appBar(),preferredSize: Size(MediaQuery.of(context).size.width, 120),) ,
        body:  ListView(
            children: <Widget>[
              Card(
                child: Container(
                  padding: EdgeInsets.all(16),
                  child:
                     OpenContainer( closedElevation:0 ,openElevation:0 ,closedBuilder:(context,action)=>
                         Text('নামাজ',style: textStyle),
                       openBuilder:(context,action)=> NiyomCategoryScreen(1,'নামাজ'),),

                ),
              ),
              Card(
                child: Container(
                  //NiyomCategoryScreen(2,'ওজু')
                  padding: EdgeInsets.all(16),
                  child:  OpenContainer(closedElevation:0 ,openElevation:0 ,closedBuilder:(context,action)=>
  Text('ওজু',style: textStyle,),
                    openBuilder:(context,action)=> NiyomCategoryScreen(2,'ওজু'),),
              )),
              Card(
                child: Container(
                  //NiyomCategoryScreen()
                  padding: EdgeInsets.all(16),
                  child:  OpenContainer(closedElevation:0 ,openElevation:0 ,closedBuilder:(context,action)=>
                      Text('গোসল',style: textStyle,),
                    openBuilder:(context,action)=> NiyomCategoryScreen(3,'গোসল'),),
                ),
              ),
              Card(
                child: Container(
      //4,'তায়াম্মুম'
                  padding: EdgeInsets.all(16),
                  child:
                       OpenContainer(closedElevation:0 ,openElevation:0 ,closedBuilder:(context,action)=>
                           Text('তায়াম্মুম',style: textStyle,),
                         openBuilder:(context,action)=> NiyomCategoryScreen(4,'তায়াম্মুম'),),
                ),
              ),
              Card(
                child: Container(
                  //6,'আযান ও একামত'
                  padding: EdgeInsets.all(16),
                  child:OpenContainer(closedElevation:0 ,openElevation:0 ,closedBuilder:(context,action)=>
                  Text('আযান ও একামত',style: textStyle,),
                    openBuilder:(context,action)=> NiyomCategoryScreen(6,'আযান ও একামত'),),
                ),
              ),
              Card(
                //5,'মূত ব্যাক্তি'
                child: Container(
                  padding: EdgeInsets.all(16),
                  child:OpenContainer(closedElevation:0 ,openElevation:0 ,closedBuilder:(context,action)=>
                       Text('মূত ব্যাক্তি',style: textStyle,),
                    openBuilder:(context,action)=> NiyomCategoryScreen(6,'আযান ও একামত'),),
                ),
              ),
            ],
          ),

      ),
    );
  }
}
