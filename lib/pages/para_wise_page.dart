import 'package:flutter/material.dart';
import 'package:searchtosu/DataBaseHelper/database_helper.dart';
import 'package:searchtosu/FinalModels/para_models.dart';
import 'package:searchtosu/pages/para_wise_quran_details_screen.dart';

class ParaWiseListPage extends StatefulWidget {
  @override
  _ParaWiseListPageState createState() => _ParaWiseListPageState();
}

class _ParaWiseListPageState extends State<ParaWiseListPage> {
  List<ParaModels> paraModels=new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DatabaseHelper.getAllParaNameFromTable().then((rows){
      setState(() {
        rows.forEach((element) {
          paraModels.add(ParaModels.fromMap(element));
        });
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('পারা ক্রমে'),
      ),
      body: Center(
        child: paraModels.length<0?
        CircularProgressIndicator():
        ListView.builder(
            itemCount: paraModels.length,
            itemBuilder: (context,index)=>Card(
              child: ListTile(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context)=>ParaWiseQuranDetailsScreen(paraModels[index].paraNo)
                  ));
                },
                leading: CircleAvatar(
                  child: Text('${paraModels[index].paraNo}'),
                ),
                subtitle: Text('${paraModels[index].nameBangla}'),
                title: Text('${paraModels[index].nameArabi}'),
              ),
            )),
      ),
    );
  }
}
