import 'package:flutter/material.dart';
import 'package:searchtosu/pages/quran_word_pages.dart';
import 'package:searchtosu/pages/sura_list_page.dart';

class HomeScreen extends StatefulWidget {

  static final route='/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: ListView(
        children: <Widget>[
          RaisedButton(
            child: Text('কুরআন পরুন'),
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SuraListPage()));
            },
          ),
          RaisedButton(
            child: Text('কোরআনের শব্দ'),
            onPressed: (){
              Navigator.of(context).pushNamed(QuranWordPages.route);
            },
          ),
        ],
      ),
    );
  }
}
