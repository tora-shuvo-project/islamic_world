import 'package:flutter/material.dart';

import 'package:searchtosu/pages/home_screen.dart';
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
        appBar: PreferredSize(child: _appBar(),preferredSize: Size(MediaQuery.of(context).size.width, 120),) ,
       
        body: ListView(
          children: <Widget>[
            Card(
              child: Container(
                padding: EdgeInsets.all(16),
                child: InkWell(
                    onTap: (){
                      Navigator.of(context).push(ScaleRoute(
                        page :NiyomCategoryScreen(1,'নামাজ')
                      ));
                    },
                    child: Text('নামাজ',style: textStyle)),
              ),
            ),
            Card(
              child: Container(
                padding: EdgeInsets.all(16),
                child: InkWell(
                    onTap: (){
                      Navigator.of(context).push(ScaleRoute(
                          page :NiyomCategoryScreen(7,'নামাজের পরে দোয়াসমূহ')
                      ));
                    },
                    child: Text('নামাজের পরে দোয়াসমূহ',style: textStyle)),
              ),
            ),
            Card(
              child: Container(
                padding: EdgeInsets.all(16),
                child: InkWell(
                    onTap: (){
                      Navigator.of(context).push(ScaleRoute(
                          page: NiyomCategoryScreen(2,'ওজু')
                      ));
                    },
                    child: Text('ওজু',style: textStyle,)),
              ),
            ),
            Card(
              child: Container(
                padding: EdgeInsets.all(16),
                child: InkWell(
                    onTap: (){
                      Navigator.of(context).push(ScaleRoute(
                          page: NiyomCategoryScreen(3,'গোসল')
                      ));
                    },
                    child: Text('গোসল',style: textStyle,)),
              ),
            ),
            Card(
              child: Container(
                padding: EdgeInsets.all(16),
                child: InkWell(
                    onTap: (){
                      Navigator.of(context).push(ScaleRoute(
                          page: NiyomCategoryScreen(4,'তায়াম্মুম')
                      ));
                    },
                    child: Text('তায়াম্মুম',style: textStyle,)),
              ),
            ),
            Card(
              child: Container(
                padding: EdgeInsets.all(16),
                child: InkWell(
                    onTap: (){
                      Navigator.of(context).push(ScaleRoute(
                          page: NiyomCategoryScreen(6,'আযান ও একামত')
                      ));
                    },
                    child: Text('আযান ও একামত',style: textStyle,)),
              ),
            ),
            Card(
              child: Container(
                padding: EdgeInsets.all(16),
                child: InkWell(
                    onTap: (){
                      Navigator.of(context).push(ScaleRoute(
                          page: NiyomCategoryScreen(5,'মূত ব্যাক্তি')
                      ));
                    },
                    child: Text('মূত ব্যাক্তি',style: textStyle,)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
