
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:searchtosu/FinalModels/doya_name_models.dart';
import 'package:searchtosu/helpers/database_helper.dart';
import 'package:searchtosu/pages/doya_details_page.dart';

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
                     child: Text("তিনি চিরঞ্জীব , তিনি ব্যাতিত কোন ম'বূদ নেই। "
                         "সুতরাং তোমরা তাঁকেই ডাক, তার অনুগত্য একনিষ্ঠ হয়ে। প্রশংসা জগতসমূহের রাব্ব আল্লাহর প্রাপ্য"),
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
