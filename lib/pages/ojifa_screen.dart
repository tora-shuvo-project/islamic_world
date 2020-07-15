import 'package:flutter/material.dart';
import 'package:searchtosu/pages/ojifa_details_screen.dart';
import 'package:searchtosu/pages/sub_ojifa_screen.dart';

class OjifaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('অজিফা'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(child: Container(
                  child: FlatButton(
                    child: Text('কালেমা'),
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context)=>SubOjifaScreen(1,'কালেমা')
                      ));
                    },
                  ),
                )),
                Expanded(child: Container(
                  child: FlatButton(
                    child: Text('দরূদ'),
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context)=>SubOjifaScreen(2,'দরূদ')
                      ));
                    },
                  ),
                )),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(child: Container(
                  child: FlatButton(
                    child: Text('খতম'),
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context)=>SubOjifaScreen(3,'খতম')
                      ));
                    },
                  ),
                )),
                Expanded(child: Container(
                  child: FlatButton(
                    child: Text('ইসমে আজম'),
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context)=>OjifaDetailsScreen(4,1,'ইসমে আজম')
                      ));
                    },
                  ),
                )),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(child: Container(
                  child: FlatButton(
                    child: Text('আসমায়ে হুসনা'),
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context)=>OjifaDetailsScreen(5,1,'আসমায়ে হুসনা')
                      ));
                    },
                  ),
                )),
                Expanded(child: Container(
                  child: FlatButton(
                    child: Text('সাইয়েদুল ইস্তিখফার'),
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context)=>OjifaDetailsScreen(6,1,'সাইয়েদুল ইস্তিখফার')
                      ));
                    },
                  ),
                )),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(child: Container(
                  child: FlatButton(
                    child: Text('আয়াতে শিফা'),
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context)=>OjifaDetailsScreen(7,1,'আয়াতে শিফা')
                      ));
                    },
                  ),
                )),
                Expanded(child: Container(
                  child: FlatButton(
                    child: Text('৭ ছালাম'),
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context)=>OjifaDetailsScreen(8,1,'৭ ছালাম')
                      ));
                    },
                  ),
                )),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(child: Container(
                  child: FlatButton(
                    child: Text('আল হাশর'),
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context)=>OjifaDetailsScreen(9,1,'আল হাশর')
                      ));
                    },
                  ),
                )),
                Expanded(child: Container(
                  child: FlatButton(
                    child: Text('আয়তুল কুরসি'),
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context)=>OjifaDetailsScreen(10,1,'আয়তুল কুরসি')
                      ));
                    },
                  ),
                )),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(child: Container(
                  child: FlatButton(
                    child: Text('দোয়া'),
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context)=>SubOjifaScreen(11,'দোয়া')
                      ));
                    },
                  ),
                )),
              ],
            ),
          ],
        )
      ),
    );
  }
}
