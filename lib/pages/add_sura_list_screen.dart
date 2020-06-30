import 'package:flutter/material.dart';
import 'package:searchtosu/helpers/query_helpers.dart';
import 'package:searchtosu/models/quran_ayat_models.dart';
import 'package:searchtosu/models/quran_sura_models.dart';
import 'package:searchtosu/utils/add_quran_sura.dart';
import 'package:searchtosu/utils/add_quran_sura_details.dart';

class AddSuraListScreen extends StatefulWidget {
  @override
  _AddSuraListScreenState createState() => _AddSuraListScreenState();
}

class _AddSuraListScreenState extends State<AddSuraListScreen> {

  AddQuranSura addDatabaseData=AddQuranSura();
  AddQuranSuraDetails addQuranSuraDetails=AddQuranSuraDetails();

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

  _addSuraHumajah(){
    addQuranSuraDetails.getSurahumajah.forEach((humajahList) {
      setState(() {
        QueryHelpers.insertQuranSuraDetails(TABLE_QURAN_AYAT, humajahList.toMap()).then((value){
          print('${humajahList.ayatNo}     ${humajahList.suraNo}');
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
          ),

          SizedBox(height: 10,),

          Container(
            width: double.infinity,
            color: Colors.blue,
            child: FlatButton(
              child: Text('Add Sura Humajah'),
              onPressed: _addSuraHumajah,
            ),
          ),
        ],
      ),
    );
  }
}
