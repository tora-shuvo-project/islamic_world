import 'package:flutter/material.dart';
import 'package:searchtosu/FinalModels/niyom_models.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.niyomModels.name}'),
        actions: <Widget>[
          IconButton(
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
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(

              padding: EdgeInsets.all(16),
              child: Text('${widget.niyomModels.description}',style: TextStyle(
                fontSize: _fontSize-1,
              ),))
        ],
      ),
    );
  }
}
