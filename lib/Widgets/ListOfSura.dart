
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class List_of_sura extends StatelessWidget {
  final String  ArbiName, banglaMeaning , obotirno;
  final int suraNO;

  List_of_sura({@required this.suraNO, @required this.ArbiName,@required this.banglaMeaning,@required this.obotirno});

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
