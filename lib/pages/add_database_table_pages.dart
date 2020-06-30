import 'dart:async';

import 'package:flutter/material.dart';
import 'package:searchtosu/helpers/query_helpers.dart';
import 'package:searchtosu/models/quran_sura_models.dart';
import 'package:searchtosu/pages/Al_Quran_Page.dart';
import 'package:searchtosu/utils/add_database_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddDatabaseTablePages extends StatefulWidget {
  @override
  _AddDatabaseTablePagesState createState() => _AddDatabaseTablePagesState();
}

class _AddDatabaseTablePagesState extends State<AddDatabaseTablePages> {

  AddDatabaseData addDatabaseData=AddDatabaseData();



  _addSuraName(){
    addDatabaseData.allSuraList.forEach((suralist) {
      setState(() {
        QueryHelpers.insertquransura(TABLE_SURA_MODELS, suralist.tomap()).then((value){
          print(value.toString());
          print(suralist.paraNo);



        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Data'),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            width: double.infinity,
            color: Colors.blue,
            child: FlatButton(
              child: Text('Add Sura Name'),
              onPressed: _addSuraName,
            ),
          )
        ],
      ),
    );
  }
}
