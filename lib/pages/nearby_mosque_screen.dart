

import 'package:searchtosu/pages/doya_subcategory_screen.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:searchtosu/helpers/place_provider.dart';
import 'package:searchtosu/helpers/provider_helpers.dart';

class NearByMosqueScreen extends StatefulWidget {
  @override
  _NearByMosqueScreenState createState() => _NearByMosqueScreenState();
}

class _NearByMosqueScreenState extends State<NearByMosqueScreen> {

  bool isLoading=true;
  int _myActivity;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _myActivity = 5000;
    getDistance(5000);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
   getDistance(5000);
  }

  getDistance(int distance){
    Provider.of<LocationProvider>(context,listen: false).getDeviceCurrentLocation().then((position){
      Provider.of<PlaceProvider>(context,listen: false).getcurrentPlaces(position, distance).then((value){
        setState(() {
          isLoading=false;
        });
      });
    });
  }


  void getNextPageDistance(int i) {
    Provider.of<LocationProvider>(context,listen: false).getDeviceCurrentLocation().then((position){
      Provider.of<PlaceProvider>(context,listen: false).getcurrentNextPlaces(position, _myActivity).then((value){
        setState(() {
          isLoading=false;
        });
      });
    });
  }
  Widget _appBar(){
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            const Color(0xffE3E3E1),
            const Color(0xffBACFFE)
          ])
      ),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(icon: Icon(Icons.arrow_back, color: Colors.white,), onPressed: (){
                  Navigator.of(context).pop();
                }),
                FittedBox(
                  child: Text("Nearby Mosque",style:  TextStyle(
                      color: Colors.white, fontSize: 20
                  ), ),
                ),
          IconButton(
            icon: Icon(Icons.refresh,color: Colors.white,),
            onPressed: (){
              getNextPageDistance(_myActivity);
            },
          )
              ],
            ),
          ),

        ),

      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:PreferredSize(child: _appBar(),preferredSize: Size(MediaQuery.of(context).size.width, 135),),

        body:  Stack(

        children: <Widget>[
          Container(
           child: Image.asset("images/mapbg.jpg" , width: MediaQuery.of(context).size.width, height: 150, fit: BoxFit.cover,),
          ),
          Container(

            margin: EdgeInsets.only(top: 50,left: 10,right: 10),
            child: ClipRRect(

              borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.only(top: 20),
                child: Column(
                  children: <Widget>[
                    DropDownFormField(
                      titleText: 'Distance',
                      hintText: '$_myActivity',
                      value: _myActivity,
                      onSaved: (value){
                        setState(() {
                          _myActivity = value;
                          getDistance(value);
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          _myActivity = value;
                          getDistance(value);
                        });
                      },
                      dataSource: [
                        {
                          "display": "১০০ মি.",
                          "value": 100,
                        },
                        {
                          "display": "৫০০ মি.",
                          "value": 500,
                        },
                        {
                          "display": "১০০০ মি.",
                          "value": 1000,
                        },
                        {
                          "display": "১.৫ কিঃমিঃ",
                          "value": 1500,
                        },
                        {
                          "display": "২ কিঃমিঃ",
                          "value": 2000,
                        },
                        {
                          "display": "২.৫ কিঃমিঃ",
                          "value": 2500,
                        },
                        {
                          "display": "৫ কিঃমিঃ",
                          "value": 5000,
                        },
                        {
                          "display": "১০ কিঃমিঃ",
                          "value": 10000,
                        },
                      ],
                      textField: 'display',
                      valueField: 'value',
                    ),
                    Expanded(
                      child: Consumer<PlaceProvider>(
                        builder: (context,data,child)=>isLoading?
                        Center(
                          child: CircularProgressIndicator(backgroundColor: Colors.green,),
                        ):ListView.builder(
                            itemCount: data.currentPlacesearch.results.length,
                            itemBuilder: (context,index){
                              return  Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Card(
                                      elevation: 0,
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          child: Text('${convertEngToBangla(index+1)}'),
                                        ),
                                        title: Text('${data.currentPlacesearch.results[index].name}'),

                                      ),
                                    ),
                                    Container( padding: EdgeInsets.symmetric(horizontal: 20),
                                        child: Text('Location: ${data.currentPlacesearch.results[index].vicinity}')),
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
                                );

                            }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
        ),
      
      ),
    );
  }

}
