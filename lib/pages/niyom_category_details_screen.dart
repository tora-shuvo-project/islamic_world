import 'package:flutter/material.dart';
import 'package:searchtosu/FinalModels/niyom_models.dart';
import 'package:searchtosu/pages/home_screen.dart';
import 'package:searchtosu/pages/settings_page.dart';
import 'package:searchtosu/utils/utils.dart';

class NiyomCategoryDetailsScreen extends StatefulWidget {
  final NiyomModels niyomModels;
  NiyomCategoryDetailsScreen(this.niyomModels);

  @override
  _NiyomCategoryDetailsScreenState createState() => _NiyomCategoryDetailsScreenState();
}

class _NiyomCategoryDetailsScreenState extends State<NiyomCategoryDetailsScreen> {

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
  }

  @override
  Widget build(BuildContext context) {
    Widget _appBar(){
      return Container(

        child: ClipRRect(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
          child: Container(
            height:75,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: IconButton(icon: Icon(Icons.arrow_back, color: Colors.white,), onPressed: (){
                      Navigator.of(context).pop();
                    }),
                  ),
                  Expanded(flex: 5,
                    child: Text('${widget.niyomModels.name}',style:  TextStyle(
                        color: Colors.white, fontSize: 18
                    ), ),
                  ),

                Expanded(
                  child: IconButton(icon: Icon(Icons.settings,color: Colors.white,),
                    onPressed: (){
                      Navigator.of(context).push(ScaleRoute(
                          page: SettingsPage()
                      )).then((_){
                        setState(() {
                          Utils.getArabiFontSizeFromPreference().then((value){
                            setState(() {
                              _fontSize=double.parse(value);
                            });
                          });
                        });
                      });
                    },),
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
        appBar: PreferredSize(child: _appBar(),preferredSize: Size(MediaQuery.of(context).size.width, 120),) ,
        body: ListView(
          children: <Widget>[
            Container(

                padding: EdgeInsets.all(16),
                child: Text('${widget.niyomModels.description}',style: TextStyle(
                  fontSize: _fontSize-1,
                ),))
          ],
        ),
      ),
    );
  }
}
