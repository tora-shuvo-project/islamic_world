import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:searchtosu/FinalModels/hadis_models.dart';
import 'package:searchtosu/Widgets/SlideAnimation.dart';
import 'package:searchtosu/helpers/database_helper.dart';
import 'package:searchtosu/pages/doya_subcategory_screen.dart';
import 'package:searchtosu/pages/hadis_details_screen.dart';

class HadisScreen extends StatefulWidget {
  @override
  _HadisScreenState createState() => _HadisScreenState();
}

class _HadisScreenState extends State<HadisScreen> with SingleTickerProviderStateMixin {
  AnimationController animationController;

  int position=2;
  List<HadisModels> allHadisModels=new List();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DatabaseHelper.getAllHadisFromHadisTable().then((hadisModels){
      setState(() {
        hadisModels.forEach((element) {
          allHadisModels.add(HadisModels.frommap(element));
        });
      });
    });
    animationController = AnimationController(vsync:this, duration: Duration(seconds: 1));
  }

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
              color: Colors.green.withOpacity(.1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(icon: Icon(Icons.arrow_back, color: Colors.white,), onPressed: (){
                    Navigator.of(context).pop();
                  }),
                  FittedBox(
                    child: Text('হাদিস সমূহ',style:  TextStyle(
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
        appBar:PreferredSize(child: _appBar(),preferredSize: Size(MediaQuery.of(context).size.width, 120),) ,
        body: ListView.builder(
            itemCount: allHadisModels.length,
            itemBuilder: (context,index)=>OpenContainer(
              closedBuilder: (context,action)=> Container(
                margin: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                child: Card(
                    elevation: 0.6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('হাদিসঃ ${convertEngToBangla(allHadisModels[index].hadisNo)}',style: TextStyle(fontSize: 20),),
                        Container(
                            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
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
//            child: ListTile(
//              onTap: (){
//            Navigator.of(context).push(MaterialPageRoute(
//              builder: (context)=>HadisDetailsScreen(allHadisModels[index])
//            ));
//              },
//              title: Text('Hadis: ${allHadisModels[index].hadisNo}'),
//            ),
                  ),

              ),
              openBuilder: (context,action)=>HadisDetailsScreen(allHadisModels[index]),
            ),
           ),
      ),
    );
  }
}
