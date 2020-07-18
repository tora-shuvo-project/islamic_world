
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
    TextEditingController searchController = new TextEditingController();
    return SafeArea(
      child: DefaultTabController(
        length: 2,
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

                                });
                              },
                            )),

                            Container(
                                child: InkWell(
                                    onTap: (){
                                      setState(() {

                                      });
                                    },
                                    child: Icon(isSearch?Icons.cancel:Icons.search))),

                          ],
                        ),

                      ),
                      SizedBox(height: 4,),
                      TabBar(tabs:  [new Text("বিষয় ভিত্তিক"), new Text("সকল দোয়াসমূহ")])
                    ],
                  ),
                ),

              ),

            ),
          ), preferredSize: Size(MediaQuery.of(context).size.width, 200,)),
          body: TabBarView(
        children: <Widget>[
          Container(
            child: MediaQuery.of(context).orientation==Orientation.portrait ? 
            SingleChildScrollView(
              child: Container(
                child: Column(
                  children: <Widget>[
                   Container(
                     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                     height: 256,
                     width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
child:   RotateAnimatedTextKit(
    onTap: () {
      print("Tap Event");
    },
  duration: Duration(milliseconds: 6000),
    text: ["তোমরা সত্যকে মিথ্যার সাথে মিশিয়ে দিও না।[সূরা বাকারা ২:৪২]",
        "মানুষকে প্রতারণা দেওয়ার জন্য ওজনে কম দিও না। [সূরা আন’আম ৬:১৫২]",
      "অহংকার করো না। [সূরা আ’রাফ ৭:১৩]",
      "পিতামাতাকে অশ্রদ্ধা করে কোনো কথা বলো না। [সূরা ইসরা১৭:২৩]",
  "অমুসলিমদের সাথে সদয় ও ন্যায় আচরণ করো। [সূরা মুমতাহিনাহ্ ৬০:৮]",
    "অভাবগ্রস্তকে খাদ্যদানের প্রতি উৎসাহ প্রদান করো। [সূরা মা’ঊন ১০৭:৩]"],
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
            ): SingleChildScrollView(
              child: Container(
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
                          child:  Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Icon(Icons.book,color: Colors.white, size: 20,),
                                Text("কুরআন", style: TextStyle(color: Colors.white), )
                              ],
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
                          child:  Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Icon(Icons.book,color: Colors.white, size: 20,),
                                Text("কুরআন", style: TextStyle(color: Colors.white), )
                              ],
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
                              ])                          ),
                          height: MediaQuery.of(context).size.width/3,
                          width: MediaQuery.of(context).size.width/3,
                          child:  Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Icon(Icons.book,color: Colors.white, size: 20,),
                                Text("কুরআন", style: TextStyle(color: Colors.white), )
                              ],
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
                          child:  Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Icon(Icons.book,color: Colors.white, size: 20,),
                                Text("কুরআন", style: TextStyle(color: Colors.white), )
                              ],
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
                          child:  Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Icon(Icons.book,color: Colors.white, size: 20,),
                                Text("কুরআন", style: TextStyle(color: Colors.white), )
                              ],
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
                          child:  Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Icon(Icons.book,color: Colors.white, size: 20,),
                                Text("কুরআন", style: TextStyle(color: Colors.white), )
                              ],
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
                          child:  Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Icon(Icons.book,color: Colors.white, size: 20,),
                                Text("কুরআন", style: TextStyle(color: Colors.white), )
                              ],
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
                          child:  Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Icon(Icons.book,color: Colors.white, size: 20,),
                                Text("কুরআন", style: TextStyle(color: Colors.white), )
                              ],
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
                          child:  Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Icon(Icons.book,color: Colors.white, size: 20,),
                                  Text("কুরআন", style: TextStyle(color: Colors.white), )
                                ],
                              ),
                          ),

                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            child: ListView.builder(
                itemCount: doyaNameModels.length,
                itemBuilder: (context,index)=>Card(
                  child: ListTile(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context)=>DoyaDetailsPage(doyaNameModels[index].id,doyaNameModels[index].name)
                      ));
                    },
                    title: Text('${doyaNameModels[index].name}'),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    leading: CircleAvatar(
                      child: Text('${index+1}'),
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
