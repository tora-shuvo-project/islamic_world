import 'package:flutter/material.dart';
import 'package:searchtosu/DataBaseHelper/database_helper.dart';

import '../FinalModels/ayat_table_model.dart';

class AyatPage extends StatefulWidget {

  final int ayatNo;
  final String suraname;
  AyatPage(this.ayatNo,this.suraname);

  @override
  _AyatPageState createState() => _AyatPageState();
}

class _AyatPageState extends State<AyatPage> {

  DatabaseHelper suranamedbHelpers=DatabaseHelper.instance;
  List<AyatTableModel> ayatmodels=new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    suranamedbHelpers.getAllAyatFromAyatTable(widget.ayatNo).then((rows){
      setState(() {
        rows.forEach((row) {
          print(row.toString());
          ayatmodels.add(AyatTableModel.formMap(row));
        });
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.suraname}'),
      ),
      body: Center(
        child: ayatmodels.length<=0?
        CircularProgressIndicator():
        ListView.builder(
            itemCount: ayatmodels.length,
            itemBuilder: (context,index)=>ListTile(
              title: Text('${ayatmodels[index].arbiQuran}'),
              subtitle: Text('${ayatmodels[index].banglaTranslator}'),
              leading: CircleAvatar(
                child: Text('${ayatmodels[index].ayatno}'),
              ),
            )),
      ),
    );
  }
}
