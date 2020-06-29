import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AlQuranPage extends StatefulWidget {
  @override
  _AlQuranPageState createState() => _AlQuranPageState();
}

class _AlQuranPageState extends State<AlQuranPage> {
  TextEditingController searchController = new TextEditingController();
  Widget _appBar(){
    return ClipRRect(
      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
      child: Container(
        height:120,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              const Color(0xff178723),
              const Color(0xff27AB4B)
            ])
        ),
        padding: EdgeInsets.symmetric(horizontal: 17),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(Icons.arrow_back, color: Colors.white,),
                  Text("আল-কোরআন", style: TextStyle(color: Colors.white, fontSize: 20),),

                  PopupMenuButton(
                      icon: Icon(Icons.more_vert, color: Colors.white,),
                      onSelected: (value){
                        if(value == 0){
                          //go to profile menu
                        }
                      }
                      ,
                      itemBuilder: (context)=>[
                        PopupMenuItem(
                          child: Text('পারাক্রমে'),
                          value: 0,
                        ),

                      ]),


                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Color(0xfff5f8fd),
                  borderRadius: BorderRadius.circular(30)
              )
              ,
              margin: EdgeInsets.symmetric(horizontal: 17),
              padding: EdgeInsets.symmetric(horizontal: 17),
              child: Row(
                children: <Widget>[
                  Expanded(child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "search"
                    ),
                  )),

                  Container(
                      child: Icon(Icons.search)),

                ],
              ),

            ),
          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:PreferredSize(child: _appBar(),preferredSize: Size(MediaQuery.of(context).size.width, 120),),
      ),
    );
  }
}