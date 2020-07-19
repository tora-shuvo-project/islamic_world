
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:searchtosu/FinalModels/doya_details_models.dart';
import 'package:searchtosu/FinalModels/doya_name_models.dart';
import 'package:searchtosu/helpers/database_helper.dart';
import 'package:share/share.dart';
class DoyaDetailsPage extends StatefulWidget {

  final String id,name;
  final DoyaDetailsModels doyaDetailsModels;
  DoyaDetailsPage({@required this.id,@required this.name,this.doyaDetailsModels});

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

//              IconButton(icon: Icon(Icons.content_copy, color: Colors.white,), onPressed: (){
//                Clipboard.setData(ClipboardData(text: '${doyaDetailsModels[index].niyom}\n'
//                    '${doyaDetailsModels[index].arabic}\n${doyaDetailsModels[index].banglaTranslator}\n${doyaDetailsModels[index].reference}'));
//              },),
//              IconButton(icon: Icon(Icons.share, color: Colors.white,), onPressed:(){
//                Share.share('বিভাগঃ ${doyaDetailsModels[index].niyom}\n ${doyaDetailsModels[index].arabic}'
//                    '\n${doyaDetailsModels[index].banglaTranslator}\n${doyaDetailsModels[index].reference} ');
//              })

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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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

                Row(
                  children: <Widget>[
                IconButton(icon: Icon(Icons.content_copy, color: Colors.white,), onPressed: (){
                  setState(() {
                    Clipboard.setData(ClipboardData(text: "${widget.doyaDetailsModels.niyom}\n"
                        "${widget.doyaDetailsModels.arabic}\n${widget.doyaDetailsModels.banglaTranslator}"
                        "\n${widget.doyaDetailsModels.reference}"));
                  });

              },),
              IconButton(icon: Icon(Icons.share, color: Colors.white,), onPressed:(){
                setState(() {
                  Share.share(' ${widget.doyaDetailsModels.niyom}\n ${widget.doyaDetailsModels.arabic}'
                      '\n${widget.doyaDetailsModels.banglaTranslator}\n${widget.doyaDetailsModels.reference} ');
                });

              })
                  ],
                )


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
            itemBuilder: (context,index)=>
                Container(
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
                      child:SelectableText('${doyaDetailsModels[index].niyom}', style: TextStyle(fontSize: 20),) ,),
                      SizedBox(height: 10,),
                      doyaDetailsModels[index].arabic == null?Container(): Container(alignment: Alignment.center,
                        child:
                          SelectableText('${doyaDetailsModels[index].arabic}',style: TextStyle(fontSize: 17)),

                      ),
                        //SelectableText('${doyaDetailsModels[index].arabic}',style: TextStyle(fontSize: 17)) ,),
                      SizedBox(height: 15,),
                      doyaDetailsModels[index].banglaTranslator == null?Container():Container(alignment: Alignment.center,
                        child:
                          SelectableText('${doyaDetailsModels[index].banglaTranslator}',style: TextStyle(fontSize: 17)),


                        ),
                        //SelectableText('${doyaDetailsModels[index].banglaTranslator}',style: TextStyle(fontSize: 17)) ,),
                      SizedBox(height: 15,),
                      doyaDetailsModels[index].reference == null?Container():Container(alignment: Alignment.center,
                        child:
                            SelectableText('${doyaDetailsModels[index].reference}'),


                       )
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
