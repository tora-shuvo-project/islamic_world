import 'package:flutter/material.dart';
import 'package:searchtosu/DataBaseHelper/database_helper.dart';
import 'package:searchtosu/FinalModels/ayat_table_model.dart';
import 'package:searchtosu/pages/para_wise_page.dart';

class ParaWiseQuranDetailsScreen extends StatefulWidget {

  final int paraNo;
  ParaWiseQuranDetailsScreen(this.paraNo);

  @override
  _ParaWiseQuranDetailsScreenState createState() => _ParaWiseQuranDetailsScreenState();
}

class _ParaWiseQuranDetailsScreenState extends State<ParaWiseQuranDetailsScreen> {

  List<AyatTableModel> ayatmodels=new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DatabaseHelper.getAllAyatFromParaTable(widget.paraNo).then((rows){
      setState(() {
        rows.forEach((element) {
          ayatmodels.add(AyatTableModel.formMap(element));
        });
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context)=>ParaWiseListPage()
        ));
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Para No ${widget.paraNo}'),
        ),
        body: Center(
          child: ayatmodels.length<0?
          CircularProgressIndicator():
          ListView.builder(
              itemCount: ayatmodels.length,
              itemBuilder: (context,index){
                return Card(
                  child: ListTile(
                    title: Text('${ayatmodels[index].arbi_indopak}'),
                    subtitle: Text('${ayatmodels[index].banglaTranslator}'),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
