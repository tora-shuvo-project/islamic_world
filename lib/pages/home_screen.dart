

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:searchtosu/pages/quran_word_pages.dart';
import 'package:searchtosu/pages/shomoy_shuchi_page.dart';
import 'package:searchtosu/pages/sura_list_page.dart';

class HomeScreen extends StatefulWidget {

  static final route='/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  Widget _appBar(){
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
        child: Container(
          height:70,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 17),
          child:
              Expanded(
                child: Container(

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(Icons.menu,color:Color(0xff06AB00)),
                      Text("আল-কোরআন ও বিভিন্ন দোয়া ", style: TextStyle(color:Color(0xff06AB00), fontSize: 17),),
                      Row(
                        children: <Widget>[
                          Icon(Icons.location_on,color:Color(0xff06AB00),),
                          Text("|",style: TextStyle(color:Color(0xff06AB00), fontSize: 17),),
                          Text("ঢাকা",style: TextStyle(color:Color(0xff06AB00), fontSize: 17), )
                        ],
                      ),




                    ],
                  ),
                ),
              ),


        ),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(child: _appBar(),preferredSize: Size(MediaQuery.of(context).size.width, 120),) ,
        body: SingleChildScrollView(
          child: Container(
            color: Color(0xffEFFAFC),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            color:Color(0xff06AB00),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text("তারিখ",style: TextStyle(color:Colors.white, fontSize: 17),),
                      Text("নামাজ",style: TextStyle(color:Colors.white, fontSize: 17),),
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          color: Color(0xff015605),
                          width: (MediaQuery.of(context).size.width/2)-1,
                          child: Column(
                            children: <Widget>[
                              Text("ইংরেজী",style: TextStyle(color:Colors.white, fontSize: 17),),
                              Text("21/03/2020",style: TextStyle(color:Colors.white, fontSize: 17),)
                            ],
                          ),
                          //color: Color(0xff026104),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          color: Color(0xff026104),
                          width: (MediaQuery.of(context).size.width/2)-1,
                          child: Column(
                            children: <Widget>[
                              Text("হিজরি",style: TextStyle(color:Colors.white, fontSize: 17),),
                              Text("21/03/2020",style: TextStyle(color:Colors.white, fontSize: 17),)
                            ],
                          ),
                          //color: Color(0xff026104),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          color: Color(0xff026C03),
                          width: (MediaQuery.of(context).size.width/2)-1,
                          child: Column(
                            children: <Widget>[
                              Text("বঙ্গাব্দ",style: TextStyle(color:Colors.white, fontSize: 17),),
                              Text("21/03/2020",style: TextStyle(color:Colors.white, fontSize: 17),)
                            ],
                          ),
                          //color: Color(0xff026104),
                        ),
                      ],
                    ),
                    Container(
                      width: 2,
                      height:30 ,
                      color: Colors.white,
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          color: Color(0xff015605),
                          width: (MediaQuery.of(context).size.width/2)-1,
                          child: Column(
                            children: <Widget>[
                              Text("ইংরেজী",style: TextStyle(color:Colors.white, fontSize: 17),),
                              Text("21/03/2020",style: TextStyle(color:Colors.white, fontSize: 17),)
                            ],
                          ),
                          //color: Color(0xff026104),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          color: Color(0xff026104),
                          width: (MediaQuery.of(context).size.width/2)-1,
                          child: Column(
                            children: <Widget>[
                              Text("ইংরেজী",style: TextStyle(color:Colors.white, fontSize: 17),),
                              Text("21/03/2020",style: TextStyle(color:Colors.white, fontSize: 17),)
                            ],
                          ),
                          //color: Color(0xff026104),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          color: Color(0xff026C03),
                          width: (MediaQuery.of(context).size.width/2)-1,
                          child: Column(
                            children: <Widget>[
                              Text("ইংরেজী",style: TextStyle(color:Colors.white, fontSize: 17),),
                              Text("21/03/2020",style: TextStyle(color:Colors.white, fontSize: 17),)
                            ],
                          ),
                          //color: Color(0xff026104),
                        ),

                      ],
                    ),
                  ],
                ),
               Column(
                   children: <Widget>[
                     Container(
                       padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                         children: <Widget>[
                           InkWell(
                             onTap:(){
                               Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SuraListPage()));
                             },
                             child: Card(
                               child:Container(
                                 padding: EdgeInsets.all(6),
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                   children: <Widget>[
                                     Image.asset("images/kuranShorif.png", height: 80,width: 80,),
                                     Text("Al Quran", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500),)
                                   ],
                                 ),
                               ),
                             ),
                           ),
                           InkWell(
                             onTap:(){

                             },
                             child: Card(
                               child:Container(
                                 padding: EdgeInsets.all(6),
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                   children: <Widget>[

                                     Image.asset("images/namjerShomoy.png", height: 80,width: 80,),
                                     Text("Namajer Waqt",style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500),)
                                   ],
                                 ),
                               ),
                             ),
                           ),
                           InkWell(
                             onTap:(){
                               Navigator.of(context).pushNamed(QuranWordPages.route);
                             },
                             child: Card(
                               child:Container(
                                 padding: EdgeInsets.all(6),
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                   children: <Widget>[
                                     Image.asset("images/shahihAfija.png", height: 80,width: 80,),
                                     Text("Quran Words",style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500),)
                                   ],
                                 ),
                               ),
                             ),
                           ),
                         ],
                       ),
                     ),
                     Container(
                       padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                         children: <Widget>[
                           InkWell(
                             onTap:(){
                               Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SuraListPage()));
                             },
                             child: Card(
                               child:Container(
                                 padding: EdgeInsets.all(6),
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                   children: <Widget>[
                                     Image.asset("images/kuranShorif.png", height: 80,width: 80,),
                                     Text("Al Quran", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500),)
                                   ],
                                 ),
                               ),
                             ),
                           ),
                           InkWell(
                             onTap:(){

                             },
                             child: Card(
                               child:Container(
                                 padding: EdgeInsets.all(6),
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                   children: <Widget>[

                                     Image.asset("images/namjerShomoy.png", height: 80,width: 80,),
                                     Text("Namajer Waqt",style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500),)
                                   ],
                                 ),
                               ),
                             ),
                           ),
                           InkWell(
                             onTap:(){
                               Navigator.of(context).pushNamed(QuranWordPages.route);
                             },
                             child: Card(
                               child:Container(
                                 padding: EdgeInsets.all(6),
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                   children: <Widget>[
                                     Image.asset("images/shahihAfija.png", height: 80,width: 80,),
                                     Text("Quran Words",style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500),)
                                   ],
                                 ),
                               ),
                             ),
                           ),
                         ],
                       ),
                     ),
                     Container(
                       padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                         children: <Widget>[
                           InkWell(
                             onTap:(){
                               Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SuraListPage()));
                             },
                             child: Card(
                               child:Container(
                                 padding: EdgeInsets.all(6),
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                   children: <Widget>[
                                     Image.asset("images/kuranShorif.png", height: 80,width: 80,),
                                     Text("Al Quran", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500),)
                                   ],
                                 ),
                               ),
                             ),
                           ),
                           InkWell(
                             onTap:(){

                             },
                             child: Card(
                               child:Container(
                                 padding: EdgeInsets.all(6),
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                   children: <Widget>[

                                     Image.asset("images/namjerShomoy.png", height: 80,width: 80,),
                                     Text("Namajer Waqt",style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500),)
                                   ],
                                 ),
                               ),
                             ),
                           ),
                           InkWell(
                             onTap:(){
                               Navigator.of(context).pushNamed(QuranWordPages.route);
                             },
                             child: Card(
                               child:Container(
                                 padding: EdgeInsets.all(6),
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                   children: <Widget>[
                                     Image.asset("images/shahihAfija.png", height: 80,width: 80,),
                                     Text("Quran Words",style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500),)
                                   ],
                                 ),
                               ),
                             ),
                           ),
                         ],
                       ),
                     ),
                   ],
                 ),
               
                
              ],
            ),
          ),
        ),
      ),
    );



//      appBar: AppBar(
//        title: Text('Home Page'),
//      ),

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

  }
}
