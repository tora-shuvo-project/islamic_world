import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:searchtosu/Widgets/ListOfSura.dart';
import 'package:searchtosu/helpers/query_helpers.dart';
import 'package:searchtosu/models/quran_sura_models.dart';

class AlQuranPage extends StatefulWidget {
  @override
  _AlQuranPageState createState() => _AlQuranPageState();
}

class _AlQuranPageState extends State<AlQuranPage> {
  List<QuranSuraModels> quranSuralist = new List();
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
        body: Column(
          children: <Widget>[
            Container(
                      height: 70,
                      width: MediaQuery.of(context).size.width,
                     child: Center(child: Text("بسم الله الرحمن الرحيم",
                       style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),),),
                    ),


            Expanded(
              child: FutureBuilder(
                  future: QueryHelpers.getAllQuranSuraName(),
                  builder: (context,AsyncSnapshot<List<QuranSuraModels>> snapshot){
                    if(snapshot.hasData){
                      return ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context,index)=> List_of_sura(
                          suraNO: snapshot.data[index].suraNo,
                          obotirno: snapshot.data[index].obotirno,
                          ArbiName: snapshot.data[index].arabisuraName,
                          banglaMeaning:snapshot.data[index].banglaMeaning ,

                        ), itemCount: snapshot.data.length,);
                    }

                    if(snapshot.hasError){
                      return Text('Data Fetch problems');
                    }
                    return CircularProgressIndicator();
                  }
              ),
            ),
          ],
        )
        
      ),
    );
  }
}