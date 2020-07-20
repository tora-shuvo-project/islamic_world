import 'package:flutter/material.dart';
import 'package:searchtosu/FinalModels/doya_name_models.dart';
import 'package:searchtosu/helpers/database_helper.dart';
import 'package:searchtosu/pages/doya_details_page.dart';

 String convertEngToBangla(int getNumer){
  return getNumer.toString()
      .replaceAll('0', '০')
      .replaceAll('1', '১')
      .replaceAll('2', '২')
      .replaceAll('3', '৩')
      .replaceAll('4', '৪')
      .replaceAll('5', '৫')
      .replaceAll('6', '৬')
      .replaceAll('7', '৭')
      .replaceAll('8', '৮')
      .replaceAll('9', '৯');
}


class DoyaSubcategoryScreen extends StatefulWidget {
  final int category;
  final String categoryName;
  DoyaSubcategoryScreen(this.category,this.categoryName);

  @override
  _DoyaSubcategoryScreenState createState() => _DoyaSubcategoryScreenState();
}

class _DoyaSubcategoryScreenState extends State<DoyaSubcategoryScreen> {

  List<DoyaNameModels>  doyaNameModels=new List();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DatabaseHelper.getDuyaCategoryNameFromTable(widget.category).then((doyaNameModel){
      doyaNameModel.forEach((element) {
        setState(() {
          doyaNameModels.add(DoyaNameModels.fromMap(element));
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
          itemCount: doyaNameModels.length,
          itemBuilder: (context,index)=>Card(
            child: ListTile(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context)=>DoyaDetailsPage(id:doyaNameModels[index].id , name: doyaNameModels[index].name)
                ));
              },
              title: Text('${doyaNameModels[index].name}'),
              trailing: Icon(Icons.keyboard_arrow_right),
              leading: CircleAvatar(
                child: Text('${convertEngToBangla(index+1)}'),
              ),
            ),
          )),
    );
  }
}
