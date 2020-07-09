
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:searchtosu/FinalModels/sura_name_table_model.dart';
import 'package:searchtosu/pages/ayat_page.dart';

class List_of_sura extends StatelessWidget {

  final SuraNameTableModel suraNameTableModel;
  final String qareName;
  List_of_sura(this.suraNameTableModel,this.qareName);


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context)=>AyatPage(suraNameTableModel,qareName)
        ));
      },
      child: Card(
        elevation: 0,
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Container(

          padding: EdgeInsets.all(10),
          child: 
          Column(
            children: <Widget>[
              Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[

                      Stack(
                        children: <Widget>[
                          Image.asset("images/NumberIcon.png", height: 50, width: 50, fit: BoxFit.cover,),
                          Container(
                              width: 50,
                              height: 50,
                              alignment: Alignment.center,
                              child: Text(suraNameTableModel.suraNo.toString(),))
                        ],
                      ),

                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Text(suraNameTableModel.arbiSuraNam),
                            Text(suraNameTableModel.banglaTranslator)
                          ],

                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Text(suraNameTableModel.banglaMeaning),
                            Text("("+suraNameTableModel.obotirno+")")
                          ],

                        ),
                      ),
                    ],
                  ),
             SizedBox(height: 5,),
             Container(
                   height: 3,
                   decoration: BoxDecoration(
                       gradient: LinearGradient(colors: [
                         const Color(0xffffffff),
                         const Color(0xff178723),
                         const Color(0xffffffff),
                       ]))

             )

            ],
          ),
            
        ),
      ),
    );
  }
}


