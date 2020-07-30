


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:searchtosu/FinalModels/doya_details_models.dart';
import 'package:searchtosu/FinalModels/doya_name_models.dart';
import 'package:searchtosu/helpers/database_helper.dart';
import 'package:searchtosu/pages/settings_page.dart';
import 'package:searchtosu/utils/utils.dart';
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
  String fonatFamilyName;
  double fontSizefromPreference;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Utils.getArabiFontFromPreference().then((value){
      setState(() {
        fonatFamilyName=value;
      });
    });

    Utils.getArabiFontSizeFromPreference().then((value){
      setState(() {
        fontSizefromPreference=double.parse(value);
      });
    });

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
                children: <Widget>[
                  Expanded(flex: 1,
                    child: IconButton(icon: Icon(Icons.arrow_back, color: Colors.white,), onPressed: (){
                      Navigator.of(context).pop();
                    }),
                  ),
                  Expanded(flex: 4,
                    child: Text(" ইসলামের দোয়া ",style:  TextStyle(
                        color: Colors.white, fontSize: 20
                    ), ),
                  ),

                  Expanded(flex: 1,
                    child: Row(
                      children: <Widget>[
                        IconButton(icon: Icon(Icons.settings, color: Colors.white,), onPressed:(){
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context)=>SettingsPage()
                          )).then((_){
                            setState(() {
                              Utils.getArabiFontFromPreference().then((value){
                                setState(() {
                                  fonatFamilyName=value;
                                });
                              });
                              Utils.getArabiFontSizeFromPreference().then((value){
                                setState(() {
                                  fontSizefromPreference=double.parse(value);
                                });
                              });

                            });
                          });
                        })
                      ],
                    ),
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
                      color: Colors.green.withOpacity(.1),
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
                            child:
                            SelectableText('${doyaDetailsModels[index].niyom}', style: TextStyle(fontSize: 20),),

                          ),
                          SizedBox(height: 10,),
                          doyaDetailsModels[index].arabic == null?Container(): Container(alignment: Alignment.center,
                              child:
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Expanded(flex:5,
                                    child: Text('${doyaDetailsModels[index].arabic}',
                                        maxLines: 100,style: TextStyle(fontSize: fontSizefromPreference,fontFamily: fonatFamilyName)),
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: IconButton(icon: Icon(Icons.content_copy,), onPressed: (){
                                        setState(() {
                                          Clipboard.setData(ClipboardData(text: "${doyaDetailsModels[index].arabic}"));
                                        });

                                      },),
                                    ),
                                  )
                                ],
                              )

                          ),
                          //SelectableText('${doyaDetailsModels[index].arabic}',style: TextStyle(fontSize: 17)) ,),
                          SizedBox(height: 15,),
                          doyaDetailsModels[index].banglaTranslator == null?Container():Container(alignment: Alignment.center,
                              child:
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Expanded(
                                      flex:5,
                                      child: Text('${doyaDetailsModels[index].banglaTranslator}',maxLines:100,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: fontSizefromPreference))),
                                  Expanded(
                                    child: IconButton(icon: Icon(Icons.content_copy), onPressed: (){
                                      setState(() {
                                        Clipboard.setData(ClipboardData(text: "${doyaDetailsModels[index].banglaTranslator}"));
                                      });

                                    },),
                                  )
                                ],
                              )


                          ),
                          //SelectableText('${doyaDetailsModels[index].banglaTranslator}',style: TextStyle(fontSize: 17)) ,),
                          SizedBox(height: 15,),
                          doyaDetailsModels[index].reference == null?Container():Container(alignment: Alignment.center,
                              child:
                              Row(
                                children: <Widget>[
                                  Expanded(
                                      flex:5,
                                      child: Text('${doyaDetailsModels[index].reference}',maxLines:100,overflow: TextOverflow.ellipsis,)),
                                ],
                              )


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