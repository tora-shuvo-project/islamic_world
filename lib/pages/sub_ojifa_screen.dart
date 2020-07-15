import 'package:flutter/material.dart';
import 'package:searchtosu/FinalModels/ojifa_models.dart';
import 'package:searchtosu/helpers/database_helper.dart';
import 'package:searchtosu/pages/ojifa_details_screen.dart';

class SubOjifaScreen extends StatefulWidget {

  final int topicNo;
  final String topicName;
  SubOjifaScreen(this.topicNo,this.topicName);

  @override
  _SubOjifaScreenState createState() => _SubOjifaScreenState();
}

class _SubOjifaScreenState extends State<SubOjifaScreen> {

  List<OjifaModels> ojifaModels=new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DatabaseHelper.getAllSubOjifaFromOjifaTable(widget.topicNo).then((ojifaname) {
      setState(() {
        ojifaname.forEach((element) {
          ojifaModels.add(OjifaModels.fromMap(element));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.topicName}'),
      ),
      body: ListView.builder(
          itemCount: ojifaModels.length,
          itemBuilder: (context,index)=>Card(
            child: ListTile(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context)=>OjifaDetailsScreen(
                      ojifaModels[index].topicNo,
                      ojifaModels[index].subtopicNo,
                      ojifaModels[index].name)
                ));
              },
              title: Text('${ojifaModels[index].name}'),
              trailing: Icon(Icons.keyboard_arrow_right,color: Colors.green,),
            ),
          )),
    );
  }
}
