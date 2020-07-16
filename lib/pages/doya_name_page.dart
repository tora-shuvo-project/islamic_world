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
                    child: Text("ইসলামিক দোয়া",style:  TextStyle(
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
        appBar:PreferredSize(child: _appBar(),preferredSize: Size(MediaQuery.of(context).size.width, 135),),
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
      ),
    );
  }
}
