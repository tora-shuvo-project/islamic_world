import 'package:flutter/material.dart';
import 'package:searchtosu/pages/niyom_category_screen.dart';

class NiyomScreen extends StatelessWidget {

  TextStyle textStyle=TextStyle(fontSize: 20);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('নিয়ম'),
      ),
      body: ListView(
        children: <Widget>[
          Card(
            child: Container(
              padding: EdgeInsets.all(16),
              child: InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context)=>NiyomCategoryScreen(1,'নামাজ')
                    ));
                  },
                  child: Text('নামাজ',style: textStyle)),
            ),
          ),
          Card(
            child: Container(
              padding: EdgeInsets.all(16),
              child: InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context)=>NiyomCategoryScreen(2,'ওজু')
                    ));
                  },
                  child: Text('ওজু',style: textStyle,)),
            ),
          ),
          Card(
            child: Container(
              padding: EdgeInsets.all(16),
              child: InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context)=>NiyomCategoryScreen(3,'গোসল')
                    ));
                  },
                  child: Text('গোসল',style: textStyle,)),
            ),
          ),
          Card(
            child: Container(
              padding: EdgeInsets.all(16),
              child: InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context)=>NiyomCategoryScreen(4,'তায়াম্মুম')
                    ));
                  },
                  child: Text('তায়াম্মুম',style: textStyle,)),
            ),
          ),
          Card(
            child: Container(
              padding: EdgeInsets.all(16),
              child: InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context)=>NiyomCategoryScreen(6,'আযান ও একামত')
                    ));
                  },
                  child: Text('আযান ও একামত',style: textStyle,)),
            ),
          ),
          Card(
            child: Container(
              padding: EdgeInsets.all(16),
              child: InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context)=>NiyomCategoryScreen(5,'মূত ব্যাক্তি')
                    ));
                  },
                  child: Text('মূত ব্যাক্তি',style: textStyle,)),
            ),
          ),
        ],
      ),
    );
  }
}
