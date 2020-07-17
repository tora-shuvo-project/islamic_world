import 'package:flutter/material.dart';
import 'package:searchtosu/FinalModels/niyom_models.dart';
import 'package:searchtosu/helpers/database_helper.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.categoryName}'),
      ),
      body: ListView.builder(
          itemCount: niyomModels.length,
          itemBuilder: (context,index)=>Card(
            child: ListTile(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context)=>NiyomCategoryDetailsScreen(niyomModels[index])
                ));
              },
              title: Text('${niyomModels[index].name}'),
              trailing: Icon(Icons.keyboard_arrow_right,color: Colors.green,),
            ),
          )),
    );
  }
}
