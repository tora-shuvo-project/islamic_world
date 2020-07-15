import 'package:flutter/material.dart';
import 'package:searchtosu/FinalModels/doya_details_models.dart';
import 'package:searchtosu/helpers/database_helper.dart';

class DoyaDetailsPage extends StatefulWidget {

  final String id,name;
  DoyaDetailsPage(this.id,this.name);

  @override
  _DoyaDetailsPageState createState() => _DoyaDetailsPageState();
}

class _DoyaDetailsPageState extends State<DoyaDetailsPage> {

  List<DoyaDetailsModels> doyaDetailsModels=new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print(widget.id);

    DatabaseHelper.getDuyaDetailsFromTable(widget.id).then((doyaDetails){
      setState(() {
        doyaDetails.forEach((element) {
          doyaDetailsModels.add(DoyaDetailsModels.fromMap(element));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.name}'),
      ),
      body: ListView.builder(
          itemCount: doyaDetailsModels.length,
          itemBuilder: (context,index)=>Card(
            child: ListTile(
              title: Text('${doyaDetailsModels[index].niyom}\n${doyaDetailsModels[index].arabic}'),
              subtitle: Text('${doyaDetailsModels[index].banglaTranslator}\n\n${doyaDetailsModels[index].reference}'),
            ),
          )),
    );
  }
}
