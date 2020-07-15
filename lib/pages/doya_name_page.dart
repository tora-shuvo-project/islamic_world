import 'package:flutter/material.dart';
import 'package:searchtosu/FinalModels/doya_name_models.dart';
import 'package:searchtosu/helpers/database_helper.dart';
import 'package:searchtosu/pages/doya_details_page.dart';

class DoyaNameScren extends StatefulWidget {
  @override
  _DoyaNameScrenState createState() => _DoyaNameScrenState();
}

class _DoyaNameScrenState extends State<DoyaNameScren> {

  List<DoyaNameModels> doyaNameModels=new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DatabaseHelper.getDuyaNameFromTable().then((duyaName){
      setState(() {
        duyaName.forEach((element) {
          doyaNameModels.add(DoyaNameModels.fromMap(element));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ইসলামিক দোয়া'),
      ),
      body: ListView.builder(
          itemCount: doyaNameModels.length,
          itemBuilder: (context,index)=>Card(
            child: ListTile(
              onTap: (){
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context)=>DoyaDetailsPage(doyaNameModels[index].id,doyaNameModels[index].name)
              ));
              },
              title: Text('${doyaNameModels[index].name}'),
              trailing: Icon(Icons.keyboard_arrow_right),
              leading: CircleAvatar(
                child: Text('${index+1}'),
              ),
            ),
          )),
    );
  }
}
