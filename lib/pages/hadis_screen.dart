import 'package:flutter/material.dart';
import 'package:searchtosu/FinalModels/hadis_models.dart';
import 'package:searchtosu/helpers/database_helper.dart';
import 'package:searchtosu/pages/hadis_details_screen.dart';

class HadisScreen extends StatefulWidget {
  @override
  _HadisScreenState createState() => _HadisScreenState();
}

class _HadisScreenState extends State<HadisScreen> {

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('হাদিস'),
      ),
      body: ListView.builder(
          itemCount: allHadisModels.length,
          itemBuilder: (context,index)=>Card(
            child: ListTile(
              onTap: (){
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context)=>HadisDetailsScreen(allHadisModels[index])
            ));
              },
              title: Text('Hadis: ${allHadisModels[index].hadisNo}'),
            ),
          )),
    );
  }
}
