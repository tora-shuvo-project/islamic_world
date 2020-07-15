import 'package:flutter/material.dart';
import 'package:searchtosu/FinalModels/ojifa_models.dart';
import 'package:searchtosu/helpers/database_helper.dart';

class OjifaDetailsScreen extends StatefulWidget {

  final int topicNo,subtopicNo;
  final String topicName;
  OjifaDetailsScreen(this.topicNo, this.subtopicNo,this.topicName);

  @override
  _OjifaDetailsScreenState createState() => _OjifaDetailsScreenState();
}

class _OjifaDetailsScreenState extends State<OjifaDetailsScreen> {

  OjifaModels ojifaModels=OjifaModels();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DatabaseHelper.getAllOjifaFromOjifaTable(widget.topicNo, widget.subtopicNo).then((ojifaModel){
      setState(() {
        ojifaModels=ojifaModel;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.topicName}'),
      ),
      body: ListView(
        children: <Widget>[
          Text('${ojifaModels.name}'),
          Text('${ojifaModels.araby}'),
          Text('${ojifaModels.banglaTranslator}'),
          Text('${ojifaModels.banglaMeaning}'),
        ],
      ),
    );
  }
}
