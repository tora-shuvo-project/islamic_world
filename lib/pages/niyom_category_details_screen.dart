import 'package:flutter/material.dart';
import 'package:searchtosu/FinalModels/niyom_models.dart';

class NiyomCategoryDetailsScreen extends StatefulWidget {
  final NiyomModels niyomModels;
  NiyomCategoryDetailsScreen(this.niyomModels);

  @override
  _NiyomCategoryDetailsScreenState createState() => _NiyomCategoryDetailsScreenState();
}

class _NiyomCategoryDetailsScreenState extends State<NiyomCategoryDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.niyomModels.name}'),
      ),
      body: ListView(
        children: <Widget>[
          Container(

              padding: EdgeInsets.all(16),
              child: Text('${widget.niyomModels.description}',style: TextStyle(
                fontSize: 20,
              ),))
        ],
      ),
    );
  }
}
