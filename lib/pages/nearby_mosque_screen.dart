import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nearby Mosque'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh,color: Colors.white,),
            onPressed: (){
              getNextPageDistance(_myActivity);
            },
          )
        ],
      ),
      body: SafeArea(
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
                  "display": "100 m",
                  "value": 100,
                },
                {
                  "display": "500 m",
                  "value": 500,
                },
                {
                  "display": "1000 m",
                  "value": 1000,
                },
                {
                  "display": "1.5 km",
                  "value": 1500,
                },
                {
                  "display": "2 km",
                  "value": 2000,
                },
                {
                  "display": "2.5 km",
                  "value": 2500,
                },
                {
                  "display": "5 km",
                  "value": 5000,
                },
                {
                  "display": "10 km",
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
                      return Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text('${index+1}'),
                          ),
                          title: Text('${data.currentPlacesearch.results[index].name}'),
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
