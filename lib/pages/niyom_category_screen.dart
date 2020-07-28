import 'package:flutter/material.dart';
import 'package:searchtosu/FinalModels/niyom_models.dart';
import 'package:searchtosu/Widgets/SlideAnimation.dart';
import 'package:searchtosu/helpers/database_helper.dart';
import 'package:searchtosu/pages/home_screen.dart';
import 'package:searchtosu/pages/niyom_category_details_screen.dart';

class NiyomCategoryScreen extends StatefulWidget {
  int category;
  final String categoryName;
  NiyomCategoryScreen(this.category,this.categoryName);

  @override
  _NiyomCategoryScreenState createState() => _NiyomCategoryScreenState();
}

class _NiyomCategoryScreenState extends State<NiyomCategoryScreen> {

  List<NiyomModels> niyomModels=new List();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DatabaseHelper.getNiyomCategoryFromNiyomTable(widget.category).then((niyommodel){
      niyommodel.forEach((element) {
        setState(() {
          niyomModels.add(NiyomModels.fromMap(element));
        });
      });
    });
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
                    child: Text('${widget.categoryName}',style:  TextStyle(
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
            itemCount: niyomModels.length,
            itemBuilder: (context,index)=>Card(
              child: ListTile(
                onTap: (){
                  Navigator.of(context).push(SizeRoute(
                    page :NiyomCategoryDetailsScreen(niyomModels[index])
                  ));
                },
                title: Text('${niyomModels[index].name}'),
                trailing: Icon(Icons.keyboard_arrow_right,color: Colors.green,),
              ),
            )),
      ),
    );
  }
}
