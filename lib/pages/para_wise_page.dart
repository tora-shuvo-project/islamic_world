import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:searchtosu/FinalModels/para_models.dart';
import 'package:searchtosu/helpers/database_helper.dart';
import 'package:searchtosu/pages/para_wise_quran_details_screen.dart';
import 'package:searchtosu/utils/utils.dart';
import 'package:toast/toast.dart';
import 'package:searchtosu/pages/doya_subcategory_screen.dart';

class ParaWiseListPage extends StatefulWidget {
  @override
  _ParaWiseListPageState createState() => _ParaWiseListPageState();
}

class _ParaWiseListPageState extends State<ParaWiseListPage> {
  List<ParaModels> paraModels=new List();
  String qareName;

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

    Utils.getQareNameFromPreference().then((qare){
      setState(() {
        qareName=qare;
      });
    });

  }
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                      child: IconButton(icon: Icon(Icons.arrow_back, color: Colors.white,), onPressed: (){
                        Navigator.of(context).pop();
                      }),
                    ),
                    Expanded(flex:5,child: Hero(tag:"parakrome",child: Text("পারা ক্রমে", style: TextStyle(color: Colors.white, fontSize: 20),))),
                    Expanded(
                      child: IconButton(icon: Icon(Icons.search,color: Colors.white,),
                        onPressed: (){
                        showSearch(context: context, delegate: ParaSearchDeleagate(paraModels,qareName));
                      },),
                    ),



                  ],
                ),
              ),


            ],
          ),

        ),

      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        appBar:PreferredSize(child: _appBar(),preferredSize: Size(MediaQuery.of(context).size.width, 120),),
        body: Center(
          child: paraModels.length<0?
          CircularProgressIndicator():
          ListView.builder(
              itemCount: paraModels.length,
              itemBuilder: (context,index)=>Card(
                elevation: 0,
                child:InkWell(
                  onTap: (){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context)=>ParaWiseQuranDetailsScreen(paraModels[index],qareName)
                    ));
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(

                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[

                            Stack(
                              children: <Widget>[
                                Image.asset("images/NumberIcon.png", height: 50, width: 50, fit: BoxFit.cover,),
                                Container(
                                    width: 50,
                                    height: 50,
                                    alignment: Alignment.center,
                                    child: Text('${convertEngToBangla(paraModels[index].paraNo)}'))
                              ],
                            ),
                            SizedBox(width: 20,),
                            Column(
                              children: <Widget>[
                                Text('${paraModels[index].nameArabi}', style: TextStyle(fontSize: 17, color: Colors.black87, fontWeight: FontWeight.bold),),
                                Text('${paraModels[index].nameBangla}',)
                              ],

                            ),



                          ],
                        ),
                        SizedBox(height: 5,),
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
                ),
//                  child: ListTile(
//                    onTap: (){
//                      Navigator.of(context).push(MaterialPageRoute(
//                        builder: (context)=>ParaWiseQuranDetailsScreen(paraModels[index].paraNo)
//                      ));
//                    },
//                    leading: Stack(
//                        children: <Widget>[
//                          Image.asset("images//NumberIcon.png", height: 40, width: 40, fit: BoxFit.cover,),
//                          Container(
//                              width: 40,
//                              height: 40,
//                              alignment: Alignment.center,
//                              child: Text('${paraModels[index].paraNo}'))
//                        ],
//                      ), //Text('${paraModels[index].paraNo}'),
//
//                    subtitle: Text('${paraModels[index].nameBangla}'),
//                    title: Text('${paraModels[index].nameArabi}'),
//                  ),
              )),
        ),
      ),
    );

  }
}

class ParaSearchDeleagate extends SearchDelegate{

  final List<ParaModels> paraModels;
  final String qareName;
  ParaSearchDeleagate(this.paraModels,this.qareName);

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
          elevation: 0,
          child:InkWell(
            onTap: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context)=>ParaWiseQuranDetailsScreen(suggestion[index],qareName)
              ));
            },
            child: Container(
              padding: EdgeInsets.all(10),
              child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(

                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[

                      Stack(
                        children: <Widget>[
                          Image.asset("images/NumberIcon.png", height: 50, width: 50, fit: BoxFit.cover,),
                          Container(
                              width: 50,
                              height: 50,
                              alignment: Alignment.center,
                              child: Text('${suggestion[index].paraNo}'))
                        ],
                      ),
                      SizedBox(width: 20,),
                      Column(
                        children: <Widget>[
                          Text('${suggestion[index].nameArabi}', style: TextStyle(fontSize: 17, color: Colors.black87, fontWeight: FontWeight.bold),),
                          Text('${suggestion[index].nameBangla}',)
                        ],

                      ),



                    ],
                  ),
                  SizedBox(height: 5,),
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
          ),
        ));
  }

}