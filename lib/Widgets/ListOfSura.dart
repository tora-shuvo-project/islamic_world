
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:searchtosu/pages/ayat_page.dart';

class List_of_sura extends StatelessWidget {

  final String  ArbiName, banglaMeaning , obotirno,suraname;
  final int suraNO;

  List_of_sura(this.ArbiName, this.banglaMeaning, this.obotirno, this.suraNO,this.suraname);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context)=>AyatPage(suraNO,suraname)
        ));
      },
      child: Container(
        child: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[

              Stack(
                children: <Widget>[
                  Image.asset("images/NumberIcon.png", height: 50, width: 50, fit: BoxFit.cover,),
                  Container(
                      width: 50,
                      height: 50,
                      alignment: Alignment.center,
                      child: Text(suraNO.toString(),))
                ],
              ),

              Column(
                children: <Widget>[
                  Text(ArbiName),
                  Text(banglaMeaning)
                ],

              ),
              Text(obotirno),
            ],
          ),
        ),
      ),
    );
  }
}
