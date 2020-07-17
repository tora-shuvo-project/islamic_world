import 'package:flutter/material.dart';
import 'package:searchtosu/FinalModels/hadis_models.dart';

class HadisDetailsScreen extends StatelessWidget {
  final HadisModels hadisModels;
  HadisDetailsScreen(this.hadisModels);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hadis: ${hadisModels.hadisNo}'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: <Widget>[
            Text('${hadisModels.arabyHadis}',style: TextStyle(
              fontSize: 20,
              fontFamily: 'QalamMajid'
            ),),
            Text('${hadisModels.banglaMeaning}',style: TextStyle(
              fontSize: 16,
              fontFamily: 'kalpurus'
            ),),
          ],
        ),
      ),
    );
  }
}

