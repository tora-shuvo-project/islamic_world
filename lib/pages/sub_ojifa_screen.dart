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
    Widget _appBar(){
      return Container(

        child: ClipRRect(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
          child: Container(
            height:70,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  const Color(0xff178723),
                  const Color(0xff27AB4B)
                ])
            ),
            padding: EdgeInsets.symmetric(horizontal: 17, vertical: 10),
            child: Container(

              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(icon: Icon(Icons.arrow_back, color: Colors.white,), onPressed: (){
                    Navigator.of(context).pop();
                  }),
                  FittedBox(
                    child: Text('${widget.topicName}',style:  TextStyle(
                        color: Colors.white, fontSize: 20
                    ), ),
                  ),

                ],
              ),
            ),

          ),

        ),
      );
    }
    return SafeArea(
      child: Scaffold(
        appBar:  PreferredSize(child: _appBar(),preferredSize: Size(MediaQuery.of(context).size.width, 135),),
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
      ),
    );
  }
}
