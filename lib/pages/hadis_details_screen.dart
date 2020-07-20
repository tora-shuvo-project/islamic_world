import 'package:flutter/material.dart';
import 'package:searchtosu/FinalModels/hadis_models.dart';
import 'package:searchtosu/pages/doya_subcategory_screen.dart';
import 'package:share/share.dart';

class HadisDetailsScreen extends StatelessWidget {
  final HadisModels hadisModels;
  HadisDetailsScreen(this.hadisModels);

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
                  IconButton(icon: Icon(Icons.arrow_back, color: Colors.white,), onPressed: (){
                    Navigator.of(context).pop();
                  }),
                  FittedBox(
                    child: Text('হাদিসঃ ${convertEngToBangla(hadisModels.hadisNo)}',style:  TextStyle(
                        color: Colors.white, fontSize: 20
                    ), ),
                  ),
//            IconButton(icon: Icon(Icons.share, color: Colors.white,), onPressed:() {
//              setState(() {
//                Share.share(' ${hadisModels.arabyHadis}\n ${widget
//                    .doyaDetailsModels.arabic}'
//                    '\n${hadisModels.banglaMeaning}\n${widget
//                    .doyaDetailsModels.reference} ');
//              });
//            }
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
              Text('${hadisModels.arabyHadis}',style: TextStyle(
                fontSize: 20,
                fontFamily: 'QalamMajid'
              ),),
              Text('${hadisModels.banglaMeaning}',style: TextStyle(
                fontSize: 16,
                fontFamily: 'kalpurus'
              ),),
            ],
          ),
        ),
      ),
    );
  }
}

