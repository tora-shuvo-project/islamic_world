
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:searchtosu/pages/ayat_page.dart';

class List_of_sura extends StatelessWidget {

  final String  ArbiName, banglaMeaning ,banglauccharon, obotirno,suraname;
  final int suraNO;

  List_of_sura(this.ArbiName, this.banglaMeaning, this.banglauccharon, this.obotirno, this.suraNO,this.suraname);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context)=>AyatPage(suraNO,suraname)
        ));
      },
      child: Card(
        elevation: 0,
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: Colors.green,
                      width: 2
                  )
              )
          ),
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
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

              Expanded(
                child: Column(
                  children: <Widget>[
                    Text(ArbiName),
                    Text(banglauccharon)
                  ],

                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text(banglaMeaning),
                    Text("("+obotirno+")")
                  ],

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
