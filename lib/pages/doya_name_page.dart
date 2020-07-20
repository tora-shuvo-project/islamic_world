
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:searchtosu/FinalModels/doya_name_models.dart';
import 'package:searchtosu/helpers/database_helper.dart';
import 'package:searchtosu/pages/doya_details_page.dart';
import 'package:searchtosu/pages/doya_subcategory_screen.dart';

class DoyaNameScren extends StatefulWidget {
  @override
  _DoyaNameScrenState createState() => _DoyaNameScrenState();
}

class _DoyaNameScrenState extends State<DoyaNameScren> {

  List<DoyaNameModels> doyaNameModels=new List();
  TextEditingController searchController = new TextEditingController();
  bool isSearch=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DatabaseHelper.getDuyaNameFromTable().then((duyaName){
      setState(() {
        duyaName.forEach((element) {
          doyaNameModels.add(DoyaNameModels.fromMap(element));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        initialIndex: 1,
        child: Scaffold(
          appBar:PreferredSize(child: Container(

            child: ClipRRect(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
              child: Container(
                height:145,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      const Color(0xff178723),
                      const Color(0xff27AB4B)
                    ])
                ),
                padding: EdgeInsets.symmetric(horizontal: 17, vertical: 10),
                child: Container(

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          IconButton(icon: Icon(Icons.arrow_back, color: Colors.white,), onPressed: (){
                            Navigator.of(context).pop();
                          }),
                          FittedBox(
                            child: Text("ইসলামিক দোয়া",style:  TextStyle(
                                color: Colors.white, fontSize: 20
                            ), ),
                          ),

                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0xfff5f8fd),
                            borderRadius: BorderRadius.circular(30)
                        )
                        ,
                        margin: EdgeInsets.symmetric(horizontal: 17),
                        padding: EdgeInsets.symmetric(horizontal: 17),
                        child: Row(
                          children: <Widget>[
                            Expanded(child: TextField(
                              controller: searchController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "search",
                              ),
                              onChanged: (value)async{
                                setState(() {
                                  isSearch=true;
                                  doyaNameModels.clear();
                                  DatabaseHelper.searchDoyaFromDoyaNameTable(value).then((rows){
                                    setState(() {
                                      rows.forEach((row) {
                                        print(row.toString());
                                        doyaNameModels.add(DoyaNameModels.fromMap(row));
                                      });
                                    });
                                  });
                                });
                              },
                            )),

                            Container(
                                child: InkWell(
                                    onTap: (){
                                      setState(() {
                                        if(isSearch){
                                          searchController.text='';
                                          isSearch=false;
                                          FocusScope.of(context).requestFocus(FocusNode());
                                          doyaNameModels.clear();
                                          DatabaseHelper.getDuyaNameFromTable().then((rows){
                                            setState(() {
                                              rows.forEach((row) {
                                                print(row.toString());
                                                doyaNameModels.add(DoyaNameModels.fromMap(row));
                                              });
                                            });
                                          });
                                        }
                                      });
                                    },
                                    child: Icon(isSearch?Icons.cancel:Icons.search))),

                          ],
                        ),

                      ),
                      SizedBox(height: 4,),
                      TabBar(
                          tabs:  [new Text("বিষয় ভিত্তিক"),
                            new Text("সকল দোয়াসমূহ")],

                      )
                    ],
                  ),
                ),

              ),

            ),
          ), preferredSize: Size(MediaQuery.of(context).size.width, 200,)),
          body: TabBarView(
        children: <Widget>[
          Container(
            child:
            SingleChildScrollView(
              child: Container(
                child: Column(
                  children: <Widget>[
                    MediaQuery.of(context).orientation==Orientation.portrait ? Container(
                     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                     height: 200,
                     width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
child:   RotateAnimatedTextKit(
    onTap: () {
      print("Tap Event");
    },
  duration: Duration(milliseconds: 6000),
    text: [
      " প্রতিশ্রুতি ভঙ্গ করো না। [সূরা বাকারা ২:১৭৭]",
      "সৎপরায়ণ হও। [সূরা মায়িদা ৫:৮]",
      "তোমরা সত্যকে মিথ্যার সাথে মিশিয়ে দিও না।[সূরা বাকারা ২:৪২]",
        "মানুষকে প্রতারণা দেওয়ার জন্য ওজনে কম দিও না। [সূরা আন’আম ৬:১৫২]",
      "অহংকার করো না। [সূরা আ’রাফ ৭:১৩]",
      "ঘুসে লিপ্ত হয়ো না। [সূরা বাকারা ২:১৮৮]",
      " সৎগুণ দেখে শাসক নির্বাচন করো। [সূরা বাকারা ২:২৪৭]",
      "পুরুষ ও নারী উভয়ই তাদের কৃতকর্মের সমান প্রতিদান পাবে। [সূরা আল-ইমরান ৩:১৯৫]",
      "মৃতের সম্পদ তার পরিবারের সদস্যসের মাঝে বন্টন করতে হবে। [সূরা নিসা ৪:৭]",
      "একে অপরকে হত্যা করো না। [সূরা নিসা ৪:৯২]",
      "অর্থ অপচয় করো না। [সূরা ইসরা ১৭:২৯]",
      'যে বিষয়ে জ্ঞান নেই তার অনুবর্তী হয়ো না।[সূরা ইসরা ১৭:৩৬]'
      "ভিন্ন ধর্মাবলম্বীদের উপাস্যদের গালমন্দ করো না। [সূরা মায়িদা ৫:১০৮]",
      "পিতামাতাকে অশ্রদ্ধা করে কোনো কথা বলো না। [সূরা ইসরা১৭:২৩]",
  "অমুসলিমদের সাথে সদয় ও ন্যায় আচরণ করো। [সূরা মুমতাহিনাহ্ ৬০:৮]",
    "অভাবগ্রস্তকে খাদ্যদানের প্রতি উৎসাহ প্রদান করো। [সূরা মা’ঊন ১০৭:৩]",
    "কারো মসজিদ যাওয়ার পথে বাধা সৃষ্টি করো না। [সূরা বাকারা ২:১১৪]"],
  isRepeatingAnimation: true,
    textStyle: TextStyle(fontSize: 16.0),
    textAlign: TextAlign.start,
   // or Alignment.topLeft
),
//                     child: Text("তিনি চিরঞ্জীব , তিনি ব্যাতিত কোন ম'বূদ নেই। "
//                         "সুতরাং তোমরা তাঁকেই ডাক, তার অনুগত্য একনিষ্ঠ হয়ে। প্রশংসা জগতসমূহের রাব্ব আল্লাহর প্রাপ্য"),
                   ): Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child:   RotateAnimatedTextKit(
                    onTap: () {
                      print("Tap Event");
                    },
                    duration: Duration(milliseconds: 6000),
                    text: [
                      " প্রতিশ্রুতি ভঙ্গ করো না। [সূরা বাকারা ২:১৭৭]",
                      "সৎপরায়ণ হও। [সূরা মায়িদা ৫:৮]",
                      "তোমরা সত্যকে মিথ্যার সাথে মিশিয়ে দিও না।[সূরা বাকারা ২:৪২]",
                      "মানুষকে প্রতারণা দেওয়ার জন্য ওজনে কম দিও না। [সূরা আন’আম ৬:১৫২]",
                      "অহংকার করো না। [সূরা আ’রাফ ৭:১৩]",
                      "ঘুসে লিপ্ত হয়ো না। [সূরা বাকারা ২:১৮৮]",
                      " সৎগুণ দেখে শাসক নির্বাচন করো। [সূরা বাকারা ২:২৪৭]",
                      "পুরুষ ও নারী উভয়ই তাদের কৃতকর্মের সমান প্রতিদান পাবে। [সূরা আল-ইমরান ৩:১৯৫]",
                      "মৃতের সম্পদ তার পরিবারের সদস্যসের মাঝে বন্টন করতে হবে। [সূরা নিসা ৪:৭]",
                      "একে অপরকে হত্যা করো না। [সূরা নিসা ৪:৯২]",
                      "অর্থ অপচয় করো না। [সূরা ইসরা ১৭:২৯]",
                      'যে বিষয়ে জ্ঞান নেই তার অনুবর্তী হয়ো না।[সূরা ইসরা ১৭:৩৬]'
                          "ভিন্ন ধর্মাবলম্বীদের উপাস্যদের গালমন্দ করো না। [সূরা মায়িদা ৫:১০৮]",
                      "পিতামাতাকে অশ্রদ্ধা করে কোনো কথা বলো না। [সূরা ইসরা১৭:২৩]",
                      "অমুসলিমদের সাথে সদয় ও ন্যায় আচরণ করো। [সূরা মুমতাহিনাহ্ ৬০:৮]",
                      "অভাবগ্রস্তকে খাদ্যদানের প্রতি উৎসাহ প্রদান করো। [সূরা মা’ঊন ১০৭:৩]",
                      "কারো মসজিদ যাওয়ার পথে বাধা সৃষ্টি করো না। [সূরা বাকারা ২:১১৪]"],
                    isRepeatingAnimation: true,
                    textStyle: TextStyle(fontSize: 16.0),
                    textAlign: TextAlign.start,
                    // or Alignment.topLeft
                  ),
//                     child: Text("তিনি চিরঞ্জীব , তিনি ব্যাতিত কোন ম'বূদ নেই। "
//                         "সুতরাং তোমরা তাঁকেই ডাক, তার অনুগত্য একনিষ্ঠ হয়ে। প্রশংসা জগতসমূহের রাব্ব আল্লাহর প্রাপ্য"),
                ),
                    Container(
                      color: Colors.orange,
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.white
                                        ),
                                        gradient: LinearGradient(colors: [
                                          const Color(0xff178723),
                                          const Color(0xff27AB4B)
                                        ])
                                    ),
                                    height: MediaQuery.of(context).size.width/3,
                                    width: MediaQuery.of(context).size.width/3,
                                    child:  InkWell(
                                      onTap: (){
                                        Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context)=>DoyaSubcategoryScreen(1,'নিত্যদিন')
                                        ));
                                      },
                                      child: Center(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Icon(Icons.book,color: Colors.white, size: 20,),
                                            Text("নিত্যদিন", style: TextStyle(color: Colors.white), )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white
                                      ),
                                        gradient: LinearGradient(colors: [
                                          const Color(0xff178723),
                                          const Color(0xff27AB4B)
                                        ])
                                    ),
                                    height: MediaQuery.of(context).size.width/3,
                                    width: MediaQuery.of(context).size.width/3,
                                    child:  InkWell(
                                      onTap: (){
                                        Navigator.of(context).push(MaterialPageRoute(
                                            builder: (context)=>DoyaSubcategoryScreen(2,'যিকর-ঘুম')
                                        ));
                                      },

                                      child: Center(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Icon(Icons.book,color: Colors.white, size: 20,),
                                            Text("যিকর-ঘুম", style: TextStyle(color: Colors.white), )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white
                                      ),
                                        gradient: LinearGradient(colors: [
                                          const Color(0xff178723),
                                          const Color(0xff27AB4B)
                                        ])
                                    ),
                                    height: MediaQuery.of(context).size.width/3,
                                    width: MediaQuery.of(context).size.width/3,
                                    child:  InkWell(
                                      onTap: (){
                                        Navigator.of(context).push(MaterialPageRoute(
                                            builder: (context)=>DoyaSubcategoryScreen(3,'সামাজিক')
                                        ));
                                      },
                                      child: Center(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Icon(Icons.book,color: Colors.white, size: 20,),
                                            Text("সামাজিক", style: TextStyle(color: Colors.white), )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                          Row(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.white
                                  ),
                                    gradient: LinearGradient(colors: [
                                      const Color(0xff178723),
                                      const Color(0xff27AB4B)
                                    ])
                                ),
                                height: MediaQuery.of(context).size.width/3,
                                width: MediaQuery.of(context).size.width/3,
                                child:  InkWell(
                                  onTap: (){
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context)=>DoyaSubcategoryScreen(4,'হজ - সিয়াম')
                                    ));
                                  },
                                  child: Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Icon(Icons.book,color: Colors.white, size: 20,),
                                        Text("হজ - সিয়াম", style: TextStyle(color: Colors.white), )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.white
                                  ),
                                    gradient: LinearGradient(colors: [
                                      const Color(0xff178723),
                                      const Color(0xff27AB4B)
                                    ])
                                ),
                                height: MediaQuery.of(context).size.width/3,
                                width: MediaQuery.of(context).size.width/3,
                                child:  InkWell(
                                  onTap: (){
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context)=>DoyaSubcategoryScreen(5,'কুরআন')
                                    ));
                                  },
                                  child: Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Icon(Icons.book,color: Colors.white, size: 20,),
                                        Text("কুরআন", style: TextStyle(color: Colors.white), )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.white
                                  ),
                                    gradient: LinearGradient(colors: [
                                      const Color(0xff178723),
                                      const Color(0xff27AB4B)
                                    ])
                                ),
                                height: MediaQuery.of(context).size.width/3,
                                width: MediaQuery.of(context).size.width/3,
                                child:  InkWell(
                                  onTap: (){
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context)=>DoyaSubcategoryScreen(6,'সালাত')
                                    ));
                                  },
                                  child: Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Icon(Icons.book,color: Colors.white, size: 20,),
                                        Text("সালাত", style: TextStyle(color: Colors.white), )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.white
                                  ),
                                    gradient: LinearGradient(colors: [
                                      const Color(0xff178723),
                                      const Color(0xff27AB4B)
                                    ])
                                ),
                                height: MediaQuery.of(context).size.width/3,
                                width: MediaQuery.of(context).size.width/3,
                                child:  InkWell(
                                  onTap: (){
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context)=>DoyaSubcategoryScreen(7,'অনুভূতি')
                                    ));
                                  },
                                  child: Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Icon(Icons.book,color: Colors.white, size: 20,),
                                        Text("অনুভূতি", style: TextStyle(color: Colors.white), )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.white
                                  ),
                                    gradient: LinearGradient(colors: [
                                      const Color(0xff178723),
                                      const Color(0xff27AB4B)
                                    ])
                                ),
                                height: MediaQuery.of(context).size.width/3,
                                width: MediaQuery.of(context).size.width/3,
                                child:  InkWell(
                                  onTap: (){
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context)=>DoyaSubcategoryScreen(8,'ইমান-সুরক্ষা')
                                    ));
                                  },
                                  child: Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Icon(Icons.book,color: Colors.white, size: 20,),
                                        Text("ইমান-সুরক্ষা", style: TextStyle(color: Colors.white), )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.white
                                  ),
                                    gradient: LinearGradient(colors: [
                                      const Color(0xff178723),
                                      const Color(0xff27AB4B)
                                    ])
                                ),
                                height: MediaQuery.of(context).size.width/3,
                                width: MediaQuery.of(context).size.width/3,
                                child:  InkWell(
                                  onTap: (){
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context)=>DoyaSubcategoryScreen(9,'অসুস্থতা')
                                    ));
                                  },
                                  child: Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Icon(Icons.book,color: Colors.white, size: 20,),
                                        Text("অসুস্থতা", style: TextStyle(color: Colors.white), )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )

          ),
          Container(
            child: ListView.builder(
                itemCount: doyaNameModels.length,
                itemBuilder: (context,index)=>Card(
                  child: ListTile(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context)=>DoyaDetailsPage(id:doyaNameModels[index].id , name: doyaNameModels[index].name,)
                      ));
                    },
                    title: Text('${doyaNameModels[index].name}'),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    leading: CircleAvatar(
                      child: Text('${doyaNameModels[index].globalId}'),
                    ),
                  ),
                )),
          ),
        ],
          ),
        ),
      ),
    );
  }
}
