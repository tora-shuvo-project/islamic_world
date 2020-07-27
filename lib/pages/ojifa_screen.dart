import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:searchtosu/pages/ojifa_details_screen.dart';
import 'package:searchtosu/pages/sub_ojifa_screen.dart';

class OjifaScreen extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    Widget _appBar(){
      return Container(

        child: ClipRRect(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
          child: Container(
            height:70,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  const Color(0xff178723),
                  const Color(0xff27AB4B)
                ])
            ),
            padding: EdgeInsets.symmetric(horizontal: 17, vertical: 10),
            child: Container(

              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(icon: Icon(Icons.arrow_back, color: Colors.white,), onPressed: (){
                    Navigator.of(context).pop();
                  }),
                  FittedBox(
                    child: Text("অজিফা",style:  TextStyle(
                        color: Colors.white, fontSize: 20
                    ), ),
                  ),

                ],
              ),
            ),

          ),

        ),
      );
    }

    return SafeArea(
      child: Scaffold(
      appBar: PreferredSize(child: _appBar(),preferredSize: Size(MediaQuery.of(context).size.width, 135),),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: ListView(
          children: <Widget>[
            Container(
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Image.asset("images/ojifapageIcon.png", height: 50, width: 50,),
                      FlatButton(
                                            child: Text('কালেমা',style: TextStyle(color: Colors.black,fontSize: 20),),
                                            onPressed: (){
                                              Navigator.of(context).push(MaterialPageRoute(
                                                  builder: (context)=>SubOjifaScreen(1,'কালেমা')
                                              ));
                                            },
                                          ),
                          Image.asset("images/ojifapageIcon.png", height: 50, width: 50,),
                        ],
                      ),
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
            SizedBox(height: 5,),
            Container(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Image.asset("images/ojifapageIcon.png", height: 50, width: 50,),
                      FlatButton(
                        child:  Text('দুরূদ পড়ার নিয়ম',style: TextStyle(color: Colors.black,fontSize: 20),),
                        onPressed: (){
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context)=>OjifaDetailsScreen(2,1,'দুরূদ  পড়ার নিয়ম')
                          ));
                        },
                      ),
                      Image.asset("images/ojifapageIcon.png", height: 50, width: 50,),
                    ],
                  ),
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
            SizedBox(height: 5,),
            Container(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Image.asset("images/ojifapageIcon.png", height: 50, width: 50,),
                      FlatButton(
                        child: Text('দরূদে ইব্রাহিম',style: TextStyle(color: Colors.black,fontSize: 20),),
                                    onPressed: (){
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context)=>OjifaDetailsScreen(2,2,'দরূদে ইব্রাহিম')
                                      ));
                        },
                      ),
                      Image.asset("images/ojifapageIcon.png", height: 50, width: 50,),
                    ],
                  ),
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
            SizedBox(height: 5,),
            Container(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Image.asset("images/ojifapageIcon.png", height: 50, width: 50,),
                      FlatButton(
                        child:  Text('ইসমে আজম',style: TextStyle(color: Colors.black,fontSize: 20),),
                                    onPressed: (){
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context)=>OjifaDetailsScreen(4,1,'ইসমে আজম')
                                      ));
                        },
                      ),
                      Image.asset("images/ojifapageIcon.png", height: 50, width: 50,),
                    ],
                  ),
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
            SizedBox(height: 5,),
            Container(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Image.asset("images/ojifapageIcon.png", height: 50, width: 50,),
                      FlatButton(
                        child:  Text('আসমায়ে হুসনা',style: TextStyle(color: Colors.black,fontSize: 20),),
                        onPressed: (){
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context)=>OjifaDetailsScreen(5,1,'আসমায়ে হুসনা')
                          ));
                        },
                      ),
                      Image.asset("images/ojifapageIcon.png", height: 50, width: 50,),
                    ],
                  ),
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
            SizedBox(height: 5,),
            Container(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Image.asset("images/ojifapageIcon.png", height: 50, width: 50,),
                      FlatButton(
                        child:  Text('সাইয়েদুল ইস্তিখফার',style: TextStyle(color: Colors.black,fontSize: 20),),
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context)=>OjifaDetailsScreen(6,1,'সাইয়েদুল ইস্তিখফার')
                      ));
                        },
                      ),
                      Image.asset("images/ojifapageIcon.png", height: 50, width: 50,),
                    ],
                  ),
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
            SizedBox(height: 5,),
            Container(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Image.asset("images/ojifapageIcon.png", height: 50, width: 50,),
                      FlatButton(
                        child:  Text('আয়াতে শিফা',style: TextStyle(color: Colors.black,fontSize: 20),),
                                    onPressed: (){
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context)=>OjifaDetailsScreen(7,1,'আয়াতে শিফা')
                                      ));
                        },
                      ),
                      Image.asset("images/ojifapageIcon.png", height: 50, width: 50,),
                    ],
                  ),
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
            SizedBox(height: 5,),
            Container(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Image.asset("images/ojifapageIcon.png", height: 50, width: 50,),
                      FlatButton(
                        child:  Text('৭ ছালাম',style: TextStyle(color: Colors.black,fontSize: 20),),
                                    onPressed: (){
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context)=>OjifaDetailsScreen(8,1,'৭ ছালাম')
                                      ));
                        },
                      ),
                      Image.asset("images/ojifapageIcon.png", height: 50, width: 50,),
                    ],
                  ),
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
            SizedBox(height: 5,),
            Container(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Image.asset("images/ojifapageIcon.png", height: 50, width: 50,),
                      FlatButton(
                        child:  Text('আল হাশর',style: TextStyle(color: Colors.black,fontSize: 20),),
                                    onPressed: (){
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context)=>OjifaDetailsScreen(9,1,'আল হাশর')
                                      ));
                        },
                      ),
                      Image.asset("images/ojifapageIcon.png", height: 50, width: 50,),
                    ],
                  ),
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
            SizedBox(height: 5,),
            Container(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Image.asset("images/ojifapageIcon.png", height: 50, width: 50,),
                      FlatButton(
                        child:  Text('আয়তুল কুরসি',style: TextStyle(color: Colors.black,fontSize: 20),),
                                    onPressed: (){
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context)=>OjifaDetailsScreen(10,1,'আয়তুল কুরসি')
                                      ));
                        },
                      ),
                      Image.asset("images/ojifapageIcon.png", height: 50, width: 50,),
                    ],
                  ),
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
            SizedBox(height: 5,),
            Container(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Image.asset("images/ojifapageIcon.png", height: 50, width: 50,),
                      FlatButton(
                        child:  Text('দোয়া',style: TextStyle(color: Colors.black,fontSize: 20),),
                                    onPressed: (){
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context)=>SubOjifaScreen(11,'দোয়া')
                                      ));
                        },
                      ),
                      Image.asset("images/ojifapageIcon.png", height: 50, width: 50,),
                    ],
                  ),
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
          ],
        ),
      )  ,
      ),
    );

//    return Scaffold(
//      body: Stack(
//        children: <Widget>[
//          Container(
//            child: Image.asset("images/bg.png", width: MediaQuery.of(context).size.width,),
//          ),
//          SafeArea(
//            child: SingleChildScrollView(
//              child: Container(
//                child: Column(
//                  children: <Widget>[
//                    Row(
//                      mainAxisAlignment: MainAxisAlignment.start,
//                      children: <Widget>[
//                        IconButton(icon: Icon(Icons.arrow_back, color: Colors.white,), onPressed: (){
//                          Navigator.of(context).pop();
//                        }),
//                        Text("অজিফা", style: TextStyle(color: Colors.white, fontSize: 20),),
//
//                      ],
//                    ),
//                    SizedBox(height: 20,),
//                    SingleChildScrollView(
//                      child: Container(
//                        child: Column(
//                          children: <Widget>[
//                            Row(
//                              children: <Widget>[
//                                Expanded(child: Container(
//                                  margin: EdgeInsets.all(10),
//                                  height: 80,
//                                  width: 100,
//                                  decoration: BoxDecoration(
//                                      border: Border.all(
//                                          color: Colors.white
//                                      ),
//                                      borderRadius: BorderRadius.circular(10.0),
//                                      gradient: LinearGradient(colors: [
//                                        const Color(0xff178723),
//                                        const Color(0xff27AB4B)
//                                      ])
//                                  ),
//                                  child: FlatButton(
//                                    child: Text('কালেমা',style: TextStyle(color: Colors.white,fontSize: 20),),
//                                    onPressed: (){
//                                      Navigator.of(context).push(MaterialPageRoute(
//                                          builder: (context)=>SubOjifaScreen(1,'কালেমা')
//                                      ));
//                                    },
//                                  ),
//                                )),
//                                Expanded(child: Container(
//                                  margin: EdgeInsets.all(8),
//                                  height: 80,
//                                  width: 100,
//                                  decoration: BoxDecoration(
//                                      border: Border.all(
//                                          color: Colors.white
//                                      ),
//                                      borderRadius: BorderRadius.circular(10.0),
//                                      gradient: LinearGradient(colors: [
//                                        const Color(0xff178723),
//                                        const Color(0xff27AB4B)
//                                      ])
//                                  ),
//                                  child: FlatButton(
//                                    child: Text('দরূদ',style: TextStyle(color: Colors.white,fontSize: 20),),
//                                    onPressed: (){
//                                      Navigator.of(context).push(MaterialPageRoute(
//                                          builder: (context)=>SubOjifaScreen(2,'দরূদ')
//                                      ));
//                                    },
//                                  ),
//                                )),
//                              ],
//                            ),
//                            Row(
//                              children: <Widget>[
//                                Expanded(child: Container(
//                                  height: 80,
//                                  width: 100,
//                                  margin: EdgeInsets.all(10),
//                                  decoration: BoxDecoration(
//                                      border: Border.all(
//                                          color: Colors.white
//                                      ),
//                                      borderRadius: BorderRadius.circular(10.0),
//                                      gradient: LinearGradient(colors: [
//                                        const Color(0xff178723),
//                                        const Color(0xff27AB4B)
//                                      ])
//                                  ),
//                                  child: FlatButton(
//                                    child: Text('খতম',style: TextStyle(color: Colors.white,fontSize: 20),),
//                                    onPressed: (){
//                                      Navigator.of(context).push(MaterialPageRoute(
//                                          builder: (context)=>SubOjifaScreen(3,'খতম')
//                                      ));
//                                    },
//                                  ),
//                                )),
//                                Expanded(child: Container(
//                                  height: 80,
//                                  width: 100,
//                                  margin: EdgeInsets.all(8),
//                                  decoration: BoxDecoration(
//                                      border: Border.all(
//                                          color: Colors.white
//                                      ),
//                                      borderRadius: BorderRadius.circular(10.0),
//                                      gradient: LinearGradient(colors: [
//                                        const Color(0xff178723),
//                                        const Color(0xff27AB4B)
//                                      ])
//                                  ),
//                                  child: FlatButton(
//                                    child: Text('ইসমে আজম',style: TextStyle(color: Colors.white,fontSize: 20),),
//                                    onPressed: (){
//                                      Navigator.of(context).push(MaterialPageRoute(
//                                          builder: (context)=>OjifaDetailsScreen(4,1,'ইসমে আজম')
//                                      ));
//                                    },
//                                  ),
//                                )),
//                              ],
//                            ),
//                            Row(
//                              children: <Widget>[
//                                Expanded(child: Container(
//                                  height: 80,
//                                  width: 100,
//                                  margin: EdgeInsets.all(10),
//                                  decoration: BoxDecoration(
//                                      border: Border.all(
//                                          color: Colors.white
//                                      ),
//                                      borderRadius: BorderRadius.circular(10.0),
//                                      gradient: LinearGradient(colors: [
//                                        const Color(0xff178723),
//                                        const Color(0xff27AB4B)
//                                      ])
//                                  ),
//                                  child: FlatButton(
//                                    child: Text('আসমায়ে হুসনা',style: TextStyle(color: Colors.white,fontSize: 20),),
//                                    onPressed: (){
//                                      Navigator.of(context).push(MaterialPageRoute(
//                                          builder: (context)=>OjifaDetailsScreen(5,1,'আসমায়ে হুসনা')
//                                      ));
//                                    },
//                                  ),
//                                )),
//                                Expanded(child: Container(
//                                  height: 80,
//                                  width: 100,
//                                  margin: EdgeInsets.all(8),
//                                  decoration: BoxDecoration(
//                                      border: Border.all(
//                                          color: Colors.white
//                                      ),
//                                      borderRadius: BorderRadius.circular(10.0),
//                                      gradient: LinearGradient(colors: [
//                                        const Color(0xff178723),
//                                        const Color(0xff27AB4B)
//                                      ])
//                                  ),
//                                  child: FlatButton(
//                                    child: Text('সাইয়েদুল ইস্তিখফার',style: TextStyle(color: Colors.white,fontSize: 20),),
//                                    onPressed: (){
//                                      Navigator.of(context).push(MaterialPageRoute(
//                                          builder: (context)=>OjifaDetailsScreen(6,1,'সাইয়েদুল ইস্তিখফার')
//                                      ));
//                                    },
//                                  ),
//                                )),
//                              ],
//                            ),
//                            Row(
//                              children: <Widget>[
//                                Expanded(child: Container(
//                                  margin: EdgeInsets.all(10),
//                                  height: 80,
//                                  width: 100,
//                                  decoration: BoxDecoration(
//                                      border: Border.all(
//                                          color: Colors.white
//                                      ),
//                                      borderRadius: BorderRadius.circular(10.0),
//                                      gradient: LinearGradient(colors: [
//                                        const Color(0xff178723),
//                                        const Color(0xff27AB4B)
//                                      ])
//                                  ),
//                                  child: FlatButton(
//                                    child: Text('আয়াতে শিফা',style: TextStyle(color: Colors.white,fontSize: 20),),
//                                    onPressed: (){
//                                      Navigator.of(context).push(MaterialPageRoute(
//                                          builder: (context)=>OjifaDetailsScreen(7,1,'আয়াতে শিফা')
//                                      ));
//                                    },
//                                  ),
//                                )),
//                                Expanded(child: Container(
//                                  margin: EdgeInsets.all(8),
//                                  height: 80,
//                                  width: 100,
//                                  decoration: BoxDecoration(
//                                      border: Border.all(
//                                          color: Colors.white
//                                      ),
//                                      borderRadius: BorderRadius.circular(10.0),
//                                      gradient: LinearGradient(colors: [
//                                        const Color(0xff178723),
//                                        const Color(0xff27AB4B)
//                                      ])
//                                  ),
//                                  child: FlatButton(
//                                    child: Text('৭ ছালাম',style: TextStyle(color: Colors.white,fontSize: 20),),
//                                    onPressed: (){
//                                      Navigator.of(context).push(MaterialPageRoute(
//                                          builder: (context)=>OjifaDetailsScreen(8,1,'৭ ছালাম')
//                                      ));
//                                    },
//                                  ),
//                                )),
//                              ],
//                            ),
//                            Row(
//                              children: <Widget>[
//                                Expanded(child: Container(
//                                  margin: EdgeInsets.all(10),
//                                  height: 80,
//                                  width: 100,
//                                  decoration: BoxDecoration(
//                                      border: Border.all(
//                                          color: Colors.white
//                                      ),
//                                      borderRadius: BorderRadius.circular(10.0),
//                                      gradient: LinearGradient(colors: [
//                                        const Color(0xff178723),
//                                        const Color(0xff27AB4B)
//                                      ])
//                                  ),
//                                  child: FlatButton(
//                                    child: Text('আল হাশর',style: TextStyle(color: Colors.white,fontSize: 20),),
//                                    onPressed: (){
//                                      Navigator.of(context).push(MaterialPageRoute(
//                                          builder: (context)=>OjifaDetailsScreen(9,1,'আল হাশর')
//                                      ));
//                                    },
//                                  ),
//                                )),
//                                Expanded(child: Container(
//                                  height: 80,
//                                  width: 100,
//                                  margin: EdgeInsets.all(8),
//                                  decoration: BoxDecoration(
//                                      border: Border.all(
//                                          color: Colors.white
//                                      ),
//                                      borderRadius: BorderRadius.circular(10.0),
//                                      gradient: LinearGradient(colors: [
//                                        const Color(0xff178723),
//                                        const Color(0xff27AB4B)
//                                      ])
//                                  ),
//                                  child: FlatButton(
//                                    child: Text('আয়তুল কুরসি',style: TextStyle(color: Colors.white,fontSize: 20),),
//                                    onPressed: (){
//                                      Navigator.of(context).push(MaterialPageRoute(
//                                          builder: (context)=>OjifaDetailsScreen(10,1,'আয়তুল কুরসি')
//                                      ));
//                                    },
//                                  ),
//                                )),
//                              ],
//                            ),
//                            Row(
//                              children: <Widget>[
//                                Expanded(child: Container(
//                                  height: 80,
//                                  width: 100,
//                                  margin: EdgeInsets.all(10),
//                                  decoration: BoxDecoration(
//                                      border: Border.all(
//                                          color: Colors.white
//                                      ),
//                                      borderRadius: BorderRadius.circular(10.0),
//                                      gradient: LinearGradient(colors: [
//                                        const Color(0xff178723),
//                                        const Color(0xff27AB4B)
//                                      ])
//                                  ),
//                                  child: FlatButton(
//                                    child: Text('দোয়া',style: TextStyle(color: Colors.white,fontSize: 20),),
//                                    onPressed: (){
//                                      Navigator.of(context).push(MaterialPageRoute(
//                                          builder: (context)=>SubOjifaScreen(11,'দোয়া')
//                                      ));
//                                    },
//                                  ),
//                                )),
//                              ],
//                            ),
//                          ],
//                        ),
//                      ),
//                    )
//
//                  ],
//                ),
//              ),
//            ),
//          )
//        ],
//      )
//      ,
//    );


//    return Scaffold(
//      appBar: AppBar(
//        title: Text('অজিফা'),
//      ),
//      body: Container(
//        child: Column(
//          children: <Widget>[
//            Row(
//              children: <Widget>[
//                Expanded(child: Container(
//                  child: FlatButton(
//                    child: Text('কালেমা'),
//                    onPressed: (){
//                      Navigator.of(context).push(MaterialPageRoute(
//                        builder: (context)=>SubOjifaScreen(1,'কালেমা')
//                      ));
//                    },
//                  ),
//                )),
//                Expanded(child: Container(
//                  child: FlatButton(
//                    child: Text('দরূদ'),
//                    onPressed: (){
//                      Navigator.of(context).push(MaterialPageRoute(
//                          builder: (context)=>SubOjifaScreen(2,'দরূদ')
//                      ));
//                    },
//                  ),
//                )),
//              ],
//            ),
//            Row(
//              children: <Widget>[
//                Expanded(child: Container(
//                  child: FlatButton(
//                    child: Text('খতম'),
//                    onPressed: (){
//                      Navigator.of(context).push(MaterialPageRoute(
//                          builder: (context)=>SubOjifaScreen(3,'খতম')
//                      ));
//                    },
//                  ),
//                )),
//                Expanded(child: Container(
//                  child: FlatButton(
//                    child: Text('ইসমে আজম'),
//                    onPressed: (){
//                      Navigator.of(context).push(MaterialPageRoute(
//                          builder: (context)=>OjifaDetailsScreen(4,1,'ইসমে আজম')
//                      ));
//                    },
//                  ),
//                )),
//              ],
//            ),
//            Row(
//              children: <Widget>[
//                Expanded(child: Container(
//                  child: FlatButton(
//                    child: Text('আসমায়ে হুসনা'),
//                    onPressed: (){
//                      Navigator.of(context).push(MaterialPageRoute(
//                          builder: (context)=>OjifaDetailsScreen(5,1,'আসমায়ে হুসনা')
//                      ));
//                    },
//                  ),
//                )),
//                Expanded(child: Container(
//                  child: FlatButton(
//                    child: Text('সাইয়েদুল ইস্তিখফার'),
//                    onPressed: (){
//                      Navigator.of(context).push(MaterialPageRoute(
//                          builder: (context)=>OjifaDetailsScreen(6,1,'সাইয়েদুল ইস্তিখফার')
//                      ));
//                    },
//                  ),
//                )),
//              ],
//            ),
//            Row(
//              children: <Widget>[
//                Expanded(child: Container(
//                  child: FlatButton(
//                    child: Text('আয়াতে শিফা'),
//                    onPressed: (){
//                      Navigator.of(context).push(MaterialPageRoute(
//                          builder: (context)=>OjifaDetailsScreen(7,1,'আয়াতে শিফা')
//                      ));
//                    },
//                  ),
//                )),
//                Expanded(child: Container(
//                  child: FlatButton(
//                    child: Text('৭ ছালাম'),
//                    onPressed: (){
//                      Navigator.of(context).push(MaterialPageRoute(
//                          builder: (context)=>OjifaDetailsScreen(8,1,'৭ ছালাম')
//                      ));
//                    },
//                  ),
//                )),
//              ],
//            ),
//            Row(
//              children: <Widget>[
//                Expanded(child: Container(
//                  child: FlatButton(
//                    child: Text('আল হাশর'),
//                    onPressed: (){
//                      Navigator.of(context).push(MaterialPageRoute(
//                          builder: (context)=>OjifaDetailsScreen(9,1,'আল হাশর')
//                      ));
//                    },
//                  ),
//                )),
//                Expanded(child: Container(
//                  child: FlatButton(
//                    child: Text('আয়তুল কুরসি'),
//                    onPressed: (){
//                      Navigator.of(context).push(MaterialPageRoute(
//                          builder: (context)=>OjifaDetailsScreen(10,1,'আয়তুল কুরসি')
//                      ));
//                    },
//                  ),
//                )),
//              ],
//            ),
//            Row(
//              children: <Widget>[
//                Expanded(child: Container(
//                  child: FlatButton(
//                    child: Text('দোয়া'),
//                    onPressed: (){
//                      Navigator.of(context).push(MaterialPageRoute(
//                          builder: (context)=>SubOjifaScreen(11,'দোয়া')
//                      ));
//                    },
//                  ),
//                )),
//              ],
//            ),
//          ],
//        )
//      ),
//    );
  }
}
