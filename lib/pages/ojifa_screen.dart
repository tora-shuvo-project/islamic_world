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
                    InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Image.asset("images/ojifapageIcon.png", height: 50, width: 50,),
                          Text('কালেমা',style: TextStyle(color: Colors.black,fontSize: 20),),
                          Image.asset("images/ojifapageIcon.png", height: 50, width: 50,),
                        ],
                      ),
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context)=>SubOjifaScreen(1,'কালেমা')
                        ));
                      },
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
                    InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Image.asset("images/ojifapageIcon.png", height: 50, width: 50,),
                          Text('দুরূদ পড়ার নিয়ম',style: TextStyle(color: Colors.black,fontSize: 20),),
                          Image.asset("images/ojifapageIcon.png", height: 50, width: 50,),
                        ],
                      ),
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context)=>OjifaDetailsScreen(2,1,'দুরূদ  পড়ার নিয়ম')
                        ));
                      },
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
                    InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Image.asset("images/ojifapageIcon.png", height: 50, width: 50,),
                          Text('দরূদে ইব্রাহিম',style: TextStyle(color: Colors.black,fontSize: 20),),
                          Image.asset("images/ojifapageIcon.png", height: 50, width: 50,),
                        ],
                      ),
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context)=>OjifaDetailsScreen(2,2,'দরূদে ইব্রাহিম')
                        ));
                      },
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
                    InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Image.asset("images/ojifapageIcon.png", height: 50, width: 50,),
                          Text('ইসমে আজম',style: TextStyle(color: Colors.black,fontSize: 20),),
                          Image.asset("images/ojifapageIcon.png", height: 50, width: 50,),
                        ],
                      ),
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context)=>OjifaDetailsScreen(4,1,'ইসমে আজম')
                        ));
                      },
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
                    InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Image.asset("images/ojifapageIcon.png", height: 50, width: 50,),
                          Text('আসমায়ে হুসনা',style: TextStyle(color: Colors.black,fontSize: 20),),
                          Image.asset("images/ojifapageIcon.png", height: 50, width: 50,),
                        ],
                      ),
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context)=>OjifaDetailsScreen(5,1,'আসমায়ে হুসনা')
                        ));
                      },
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
                    InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Image.asset("images/ojifapageIcon.png", height: 50, width: 50,),
                          Text('সাইয়েদুল ইস্তিখফার',style: TextStyle(color: Colors.black,fontSize: 20),),
                          Image.asset("images/ojifapageIcon.png", height: 50, width: 50,),
                        ],
                      ),
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context)=>OjifaDetailsScreen(6,1,'সাইয়েদুল ইস্তিখফার')
                        ));
                      },
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
                    InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Image.asset("images/ojifapageIcon.png", height: 50, width: 50,),
                          Text('আয়াতে শিফা',style: TextStyle(color: Colors.black,fontSize: 20),),
                          Image.asset("images/ojifapageIcon.png", height: 50, width: 50,),
                        ],
                      ),
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context)=>OjifaDetailsScreen(7,1,'আয়াতে শিফা')
                        ));
                      },
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
                    InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Image.asset("images/ojifapageIcon.png", height: 50, width: 50,),
                          Text('৭ ছালাম',style: TextStyle(color: Colors.black,fontSize: 20),),
                          Image.asset("images/ojifapageIcon.png", height: 50, width: 50,),
                        ],
                      ),
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context)=>OjifaDetailsScreen(8,1,'৭ ছালাম')
                        ));
                      },
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
                    InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Image.asset("images/ojifapageIcon.png", height: 50, width: 50,),
                          Text('আল হাশর',style: TextStyle(color: Colors.black,fontSize: 20),),
                          Image.asset("images/ojifapageIcon.png", height: 50, width: 50,),
                        ],
                      ),
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context)=>OjifaDetailsScreen(9,1,'আল হাশর')
                        ));
                      },
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
                    InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Image.asset("images/ojifapageIcon.png", height: 50, width: 50,),
                          Text('আয়তুল কুরসি',style: TextStyle(color: Colors.black,fontSize: 20),),
                          Image.asset("images/ojifapageIcon.png", height: 50, width: 50,),
                        ],
                      ),
                      onTap: (){

                      },
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
                    InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Image.asset("images/ojifapageIcon.png", height: 50, width: 50,),
                          Text('দোয়া',style: TextStyle(color: Colors.black,fontSize: 20),),
                          Image.asset("images/ojifapageIcon.png", height: 50, width: 50,),
                        ],
                      ),
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context)=>SubOjifaScreen(11,'দোয়া')
                        ));
                      },
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
  }
}
