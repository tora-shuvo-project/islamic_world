
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
                    child: Expanded(
                      child: Text(" ইসলামের দোয়া ",style:  TextStyle(
                          color: Colors.white, fontSize: 20
                      ), ),
                    ),
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
            itemCount: doyaDetailsModels.length,
            itemBuilder: (context,index)=> Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  child: Column(
                    children: <Widget>[
                      Text("${widget.name}", style: TextStyle(fontSize: 17),),
                      Container(
                          height: 3,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                const Color(0xffffffff),
                                const Color(0xff178723),
                                const Color(0xffffffff),
                              ]))
                      ),
                      doyaDetailsModels[index].niyom == null?Container(): Container(alignment: Alignment.center,
                      child:Text('${doyaDetailsModels[index].niyom}', style: TextStyle(fontSize: 20),) ,),
                      SizedBox(height: 10,),
                      doyaDetailsModels[index].arabic == null?Container(): Container(alignment: Alignment.center,
                        child:Text('${doyaDetailsModels[index].arabic}',style: TextStyle(fontSize: 17)) ,),
                      SizedBox(height: 15,),
                      doyaDetailsModels[index].banglaTranslator == null?Container():Container(alignment: Alignment.center,
                        child:Text('${doyaDetailsModels[index].banglaTranslator}',style: TextStyle(fontSize: 17)) ,),
                      SizedBox(height: 15,),
                      doyaDetailsModels[index].reference == null?Container():Container(alignment: Alignment.center,
                        child:Text('${doyaDetailsModels[index].reference}',style: TextStyle(fontSize: 17)),)
                    ],
                  ),
                )
              ),
//              child: ListTile(
//                title: Text('${doyaDetailsModels[index].niyom}\n${doyaDetailsModels[index].arabic}'),
//                subtitle: Text('${doyaDetailsModels[index].banglaTranslator}\n\n${doyaDetailsModels[index].reference}'),
//              ),
        )
      ),
    );
  }
}
