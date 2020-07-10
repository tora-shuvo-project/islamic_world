import 'package:flutter/material.dart';
import 'package:searchtosu/DataBaseHelper/database_helper.dart';
import 'package:searchtosu/FinalModels/para_models.dart';
import 'package:searchtosu/pages/para_wise_quran_details_screen.dart';
import 'package:searchtosu/pages/sura_list_page.dart';
import 'package:toast/toast.dart';

class ParaWiseListPage extends StatefulWidget {
  @override
  _ParaWiseListPageState createState() => _ParaWiseListPageState();
}

class _ParaWiseListPageState extends State<ParaWiseListPage> {
  List<ParaModels> paraModels=new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DatabaseHelper.getAllParaNameFromTable().then((rows){
      setState(() {
        rows.forEach((element) {
          paraModels.add(ParaModels.fromMap(element));
        });
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context)=>SuraListPage()
        ));
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('পারা ক্রমে'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search,color: Colors.white,),
              onPressed: (){
                showSearch(context: context, delegate: ParaSearchDeleagate(paraModels)).then((value){
                  setState(() {

                  });
                });
              },
            )
          ],
        ),
        body: Center(
          child: paraModels.length<0?
          CircularProgressIndicator():
          ListView.builder(
              itemCount: paraModels.length,
              itemBuilder: (context,index)=>Card(
                child: ListTile(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context)=>ParaWiseQuranDetailsScreen(paraModels[index].paraNo)
                    ));
                  },
                  leading: CircleAvatar(
                    child: Text('${paraModels[index].paraNo}'),
                  ),
                  trailing: Text('${paraModels[index].nameEnglish}'),
                  subtitle: Text('${paraModels[index].nameBangla}'),
                  title: Text('${paraModels[index].nameArabi}'),
                ),
              )),
        ),
      ),
    );
  }
}

class ParaSearchDeleagate extends SearchDelegate{

  final List<ParaModels> paraModels;
  ParaSearchDeleagate(this.paraModels);

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        icon: Icon(Icons.cancel),
        onPressed: (){
          query='';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: (){
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return ListTile(
      leading: Icon(Icons.search),
      title: Text(query),
      onTap: (){
      Toast.show('Para Not Found', context);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    var suggestion=query==null?
    paraModels:paraModels.where((para){
      return para.nameEnglish.toLowerCase().startsWith(query.toLowerCase()) ||
          para.nameArabi.toLowerCase().startsWith(query.toLowerCase()) ||
          para.nameBangla.toLowerCase().startsWith(query.toLowerCase())||
          para.paraNo.toString().startsWith(query.toLowerCase());
    }).toList();
    return ListView.builder(
        itemCount: suggestion.length,
        itemBuilder: (context,index)=>Card(
          child: ListTile(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context)=>ParaWiseQuranDetailsScreen(suggestion[index].paraNo)
              ));
            },
            leading: CircleAvatar(
              child: Text('${suggestion[index].paraNo}'),
            ),
            subtitle: Text('${suggestion[index].nameBangla}'),
            title: Text('${suggestion[index].nameArabi}'),
          ),
        ));
  }

}