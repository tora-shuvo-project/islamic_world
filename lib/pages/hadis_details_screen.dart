import 'package:flutter/material.dart';
import 'package:searchtosu/FinalModels/hadis_models.dart';
import 'package:searchtosu/pages/doya_subcategory_screen.dart';
import 'package:searchtosu/pages/settings_page.dart';
import 'package:searchtosu/utils/utils.dart';
import 'package:share/share.dart';

class HadisDetailsScreen extends StatefulWidget {
  final HadisModels hadisModels;
  HadisDetailsScreen(this.hadisModels);

  @override
  _HadisDetailsScreenState createState() => _HadisDetailsScreenState();
}

class _HadisDetailsScreenState extends State<HadisDetailsScreen> {

  double _fontSize;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Utils.getArabiFontSizeFromPreference().then((value){
      setState(() {
        _fontSize=double.parse(value);
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
              color: Colors.green.withOpacity(.1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: IconButton(icon: Icon(Icons.arrow_back, color: Colors.white,), onPressed: (){
                      Navigator.of(context).pop();
                    }),
                  ),
                  Expanded(flex: 5,
                    child: Text('হাদিসঃ ${convertEngToBangla(widget.hadisModels.hadisNo)}',style:  TextStyle(
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
          appBar:PreferredSize(child: _appBar(),preferredSize: Size(MediaQuery.of(context).size.width, 120),) ,
        body: Container(
          padding: EdgeInsets.all(16),
          child: ListView(
            children: <Widget>[
              Text('${widget.hadisModels.arabyHadis}',style: TextStyle(
                fontSize: _fontSize,
                fontFamily: 'QalamMajid'
              ),),
              Text('${widget.hadisModels.banglaMeaning}',style: TextStyle(
                fontSize: _fontSize-3,
                fontFamily: 'kalpurus'
              ),),
            ],
          ),
        ),
      ),
    );
  }
}

