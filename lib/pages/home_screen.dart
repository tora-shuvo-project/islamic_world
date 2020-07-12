

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:searchtosu/pages/quran_word_pages.dart';
import 'package:searchtosu/pages/shomoy_shuchi_page.dart';
import 'package:searchtosu/pages/sura_list_page.dart';

class HomeScreen extends StatefulWidget {

  static final route='/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: Text('Home Page'),
//      ),
    body:SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child:
                Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(" রবিবার, ২০ জিলহাজ, ১৪৪১ ", style: TextStyle( fontSize: 18, fontWeight: FontWeight.w500),),
                          FlatButton(onPressed: (){}, child: Row(children: <Widget>[
                            Icon(Icons.location_on), Text("|"),Text("Location")
                          ],))
                        ],
                      ),
                    SizedBox(height: 5,),
                     ClipRRect(
                       borderRadius: BorderRadius.circular(20),
                       child: Container(
                              height: 170,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                 // borderRadius: BorderRadius.circular(20),
                                  gradient: LinearGradient(colors: [
                                    const Color(0xff178723),
                                    const Color(0xff27AB4B)
                                  ])
                              ),
                            child: Stack(
                              children: <Widget>[


                                Positioned(
                                  right: 10,
                                    top: 11,
                                    child: Image(image: AssetImage('images/mausque.png'),width: 100, height: 200,))
                              ],
                            ),
                          ),
                     ),
                    SizedBox(height: 10,),
                     Row(
                       children: <Widget>[
                         InkWell(
                           onTap: (){
                             Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SuraListPage()));
                           },
                           child: Container(
                             padding: EdgeInsets.all(6),
                             decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                               border: Border.all(
                                   color: Colors.white
                               ),
                             ),
                             child: Column(
                               children: <Widget>[
                               Image(image: AssetImage('images/kuranIcon.png'),width: 50, height: 50,),
                                 Text("Read Quran")
                               ],
                             ),
                           ),
                         ),
                         SizedBox(width: 10,),
                         InkWell(
                           onTap:(){
                             Navigator.of(context).pushNamed(QuranWordPages.route);
                           },
                           child: Container(
                             padding: EdgeInsets.all(6),
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(20),
                                 border: Border.all(
                                     color: Colors.white
                                 ),
                               ),
                             child: Column(
                               children: <Widget>[
                                 Image(image: AssetImage('images/kuranIcon.png'),width: 50, height: 50,),
                                 Text("Quran Words")
                               ],
                             ),
                           ),

                         ),
                         InkWell(
                           onTap:(){
                             Navigator.of(context).pushNamed(ShomoyShuchi.route);
                           },
                           child: Container(
                             padding: EdgeInsets.all(6),
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(20),
                               border: Border.all(
                                   color: Colors.white
                               ),
                             ),
                             child: Column(
                               children: <Widget>[
                                 Image(image: AssetImage('images/kuranIcon.png'),width: 50, height: 50,),
                                 Text("Shomoy-Shuchi"),
                               ],
                             ),
                           ),

                         )
                       ],
                     )
                  ],
                ),




      ),
    )
//      body: ListView(
//        children: <Widget>[
//          RaisedButton(
//            child: Text('কুরআন পরুন'),
//            onPressed: (){
//              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SuraListPage()));
//            },
//          ),
//          RaisedButton(
//            child: Text('কোরআনের শব্দ'),
//            onPressed: (){
//              Navigator.of(context).pushNamed(QuranWordPages.route);
//            },
//          ),
//        ],
//      ),
    );
  }
}
