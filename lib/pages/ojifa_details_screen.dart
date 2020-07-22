import 'package:flutter/material.dart';
import 'package:searchtosu/FinalModels/ojifa_models.dart';
import 'package:searchtosu/helpers/database_helper.dart';
import 'package:searchtosu/pages/settings_page.dart';
import 'package:searchtosu/utils/utils.dart';

class OjifaDetailsScreen extends StatefulWidget {

  final int topicNo,subtopicNo;
  final String topicName;
  OjifaDetailsScreen(this.topicNo, this.subtopicNo,this.topicName);

  @override
  _OjifaDetailsScreenState createState() => _OjifaDetailsScreenState();
}

class _OjifaDetailsScreenState extends State<OjifaDetailsScreen> {

  OjifaModels ojifaModels=OjifaModels();

  double _fontSize=17;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Utils.getArabiFontSizeFromPreference().then((value){
      setState(() {
        _fontSize=double.parse(value);
      });
    });
    DatabaseHelper.getAllOjifaFromOjifaTable(widget.topicNo, widget.subtopicNo).then((ojifaModel){
      setState(() {
        ojifaModels=ojifaModel;
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
                  Expanded(
                    child: IconButton(icon: Icon(Icons.arrow_back, color: Colors.white,), onPressed: (){
                      Navigator.of(context).pop();
                    }),
                  ),
                  Expanded(flex: 5,
                    child: Text('${widget.topicName}',style:  TextStyle(
                        color: Colors.white, fontSize: 20
                    ), ),
                  ),
                  Expanded(
                    child: IconButton(
                      icon: Icon(Icons.settings,color: Colors.white,),
                      onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context)=>SettingsPage()
                        )).then((_){
                          setState(() {
                            Utils.getArabiFontSizeFromPreference().then((value){
                              setState(() {
                                _fontSize=double.parse(value);
                              });
                            });
                          });
                        });
                      },
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
        appBar: PreferredSize(child: _appBar(),preferredSize: Size(MediaQuery.of(context).size.width, 135),),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
          child: ListView(
            children: <Widget>[
              Container( alignment: Alignment.center,child: ojifaModels.name== "null"?Container():Text('${ojifaModels.name}', style: TextStyle(fontSize: 25),
              )),
              Container(
                  height: 3,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        const Color(0xffffffff),
                        const Color(0xff178723),
                        const Color(0xffffffff),
                      ]))
              ),
              SizedBox(height: 10,),
              Container(alignment: Alignment.center,
                  child: ojifaModels.araby==null?Container():
                  Text('${ojifaModels.araby}',style: TextStyle(fontSize: _fontSize+2))),
              Container( alignment: Alignment.center,
                  child: ojifaModels.banglaTranslator== null?Container():
              Text(' ${ojifaModels.banglaTranslator}',
                  style: TextStyle(fontSize: _fontSize,fontWeight: FontWeight.bold))),
              SizedBox(height: 10,),
              Container(alignment:Alignment.center,
                  child: ojifaModels.banglaMeaning == null?Container():
                  Text('বাংলা অর্থঃ ${ojifaModels.banglaMeaning}',style: TextStyle(fontSize: _fontSize-1)))
            ],
          ),
        ),
      ),
    );
  }
}
