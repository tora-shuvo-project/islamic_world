import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:searchtosu/DataBaseHelper/database_helper.dart';
import 'package:searchtosu/FinalModels/sura_name_table_model.dart';
import 'package:searchtosu/Widgets/ListOfSura.dart';

class SuraListPage extends StatefulWidget {

  @override
  _SuraListPageState createState() => _SuraListPageState();
}

class _SuraListPageState extends State<SuraListPage> {

  DatabaseHelper suranamedbHelpers=DatabaseHelper.instance;
  List<SuraNameTableModel> suranamesmodel=new List();

  @override
  void initState() {
    super.initState();

    suranamedbHelpers.getAllSuraFromSuraNameTable().then((rows){
      setState(() {
        rows.forEach((row) {
          print(row.toString());
          suranamesmodel.add(SuraNameTableModel.formMap(row));
        });
      });
    });
  }

  TextEditingController searchController = new TextEditingController();
  Widget _appBar(){
    return Container(
      color: Colors.green,
      child: ClipRRect(
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
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar:PreferredSize(child: _appBar(),preferredSize: Size(MediaQuery.of(context).size.width, 120),),
          body: Stack(
            children: <Widget>[
              Container(
                color: Colors.green,
                height:100,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  alignment: Alignment.topCenter,
                  child: Text("بسم الله الرحمن الرحيم",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),),),
              ),
              Container(
                margin: EdgeInsets.only(top: 50,left: 10,right: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.only(top: 20),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context,index)=>
                          List_of_sura(

                            suranamesmodel[index].arbiSuraNam,
                            suranamesmodel[index].banglaMeaning,
                            suranamesmodel[index].banglaTranslator,
                            suranamesmodel[index].obotirno,
                            suranamesmodel[index].suraNo,
                            suranamesmodel[index].banglaTranslator,

                          ),
                      itemCount: suranamesmodel.length,),

                  ),
                ),
              ),


            ],
          )

      ),
    );
  }


}