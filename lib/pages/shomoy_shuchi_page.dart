

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ShomoyShuchi extends StatefulWidget {
  static final route='/shomoyShuchi';
  @override
  _ShomoyShuchiState createState() => _ShomoyShuchiState();
}



class _ShomoyShuchiState extends State<ShomoyShuchi> {


  Widget _appBar(){
    return Container(
      color: Colors.green,
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

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                   IconButton(icon: Icon(Icons.arrow_back, color: Colors.white,), onPressed: (){
                        Navigator.of(context).pop();
                      }),
                    Text("সময়সূচী",style:  TextStyle(
                      color: Colors.white, fontSize: 20
                    ), ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.location_on, color: Colors.white,),
                        Text("|", style: TextStyle(color: Colors.white, fontSize: 17),),
                        Text("Location", style: TextStyle(color: Colors.white, fontSize: 17),),
                      ],
                    )
                  ],
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
        appBar:PreferredSize(child: _appBar(),preferredSize: Size(MediaQuery.of(context).size.width, 120),) ,
        body: Stack(
          children: <Widget>[
            Container(
              color: Colors.green,
              height: 280,
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              width: MediaQuery.of(context).size.width,
              child: Container(
                child: Column(
                  children: <Widget>[

                    Row(
                      children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text("পরবর্তি ওয়াক্ত",style: TextStyle(fontSize: 17,color: Colors.white),),
                                Row(
                                  children: <Widget>[
                                    Text("Magrib", style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),),
                                    SizedBox(width: 10,),
                                    Text("6.59 PM",style: TextStyle(fontSize: 20,color: Colors.white),),


                                  ],
                                ),
                                SizedBox(height: 10,),
                                Text("১ ঘন্টা ৪৫ মিনিট পর",style: TextStyle(fontSize: 17,color: Colors.white),),
                            //    VerticalDivider(width: 2,thickness: 2, color: Colors.white,),
                                SizedBox(height: 10,),



                              ],
                            ),
                        SizedBox(width: 20,),
                        Container(
                          width: 2,
                          height: 100,
                          color: Colors.white,
                        ),
                        SizedBox(width: 20,),
                        Text("Asar", style: TextStyle(color: Colors.white,fontSize: 30, fontWeight: FontWeight.bold),)
                      ],
                    ),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Image.asset("images/sunrise.png", width: 50, height:50 ,),
                            Text("Sunrise", style: TextStyle(color: Colors.white)),
                            Text("5.00 AM",style: TextStyle(color: Colors.white))

                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Image.asset("images/sunset.png", width: 50, height:50 ,),
                            Text("Sunset",style: TextStyle(color: Colors.white)),
                            Text("6.00 PM",style: TextStyle(color: Colors.white))

                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 210,left: 10,right: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                  child: Column(
                    children: <Widget>[
                      Container(
                        child:Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.event),
                            SizedBox(width: 5,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text("Robibar", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),

                                Text("26,May,2020/ 20 Ramdan 1440"),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Fazar"),
                          Row(
                            children: <Widget>[
                              Text("03.54 AM"),
                              IconButton(icon: Icon(Icons.notifications), onPressed: (){}),

                            ],
                          )
                        ],
                      ),
                      Container(
                        height: 1,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.black87,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Fazar"),
                          Row(
                            children: <Widget>[
                              Text("03.54 AM"),
                              IconButton(icon: Icon(Icons.notifications), onPressed: (){}),

                            ],
                          )
                        ],
                      ),
                      Container(
                        height: 1,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.black87,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Fazar"),
                          Row(
                            children: <Widget>[
                              Text("03.54 AM"),
                              IconButton(icon: Icon(Icons.notifications), onPressed: (){}),

                            ],
                          )
                        ],
                      ),
                      Container(
                        height: 1,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.black87,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Fazar"),
                          Row(
                            children: <Widget>[
                              Text("03.54 AM"),
                              IconButton(icon: Icon(Icons.notifications), onPressed: (){}),

                            ],
                          )
                        ],
                      ),
                      Container(
                        height: 1,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.black87,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Fazar"),
                          Row(
                            children: <Widget>[
                              Text("03.54 AM"),
                              IconButton(icon: Icon(Icons.notifications), onPressed: (){}),

                            ],
                          )
                        ],
                      ),
                      Container(
                        height: 1,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.black87,
                      )
                    ],
                  )

                ),
              ),
            ),
          ],
        ),
      ),

    );
  }
}
