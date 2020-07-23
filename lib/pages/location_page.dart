import 'dart:async';

import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:libpray/libpray.dart';
import 'package:provider/provider.dart';
import 'package:searchtosu/helpers/provider_helpers.dart';
import 'package:searchtosu/utils/utils.dart';



class LocationPage extends StatefulWidget {

  final LatLng latLng;
  LocationPage(this.latLng);

  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {

final _jelacontroller = TextEditingController();
int selectedRadio=0;
Set<Marker> markers={};
Completer<GoogleMapController> _completer=Completer();
String _selectedJelaName;
String _dristric_from_gps;

void _onmapCreated(GoogleMapController controller) {
  _completer.complete(controller);
}


void _setlocation() async{

  Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  debugPrint('location: ${position.latitude}');
  final coordinates = new Coordinates(widget.latLng.latitude,widget.latLng.longitude);
  var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
  var first = addresses.first;
  print('${first.toMap()}');

  _dristric_from_gps = first.subAdminArea.toString().replaceAll('District', "");

  Utils.getZilaNameFromPreference().then((value){
    setState(() {
      print('$value');
    });
  });


}

void _handleRadioValueChange(int value) {
  setState(() {
    selectedRadio = value;

    switch (selectedRadio) {
      case 0:
        print(_selectedJelaName);
        print("Selected first value");
        Utils.saveZilaFromPreference(_selectedJelaName).then((value){
          setState(() {

          });
        });
    
    break;
    case 1:
      Utils.saveZilaFromPreference(_dristric_from_gps).then((value){
        setState(() {

        });
      });

      print("Selected Second value");
    break;
    }
    });
}


@override
void initState() {
  //final provider = Provider.of<LocationProvider>(context);
//  super.initState();
//  selectedRadio =0;
//  _selectedJelaName="";
//  markers.add(Marker(
//      markerId: MarkerId(widget.latLng.toString()),
//      position: widget.latLng,
//    infoWindow: InfoWindow(
//      title: '${widget.latLng}'
//    ),
//    icon: BitmapDescriptor.defaultMarker,
//  ));
//
//  _setlocation();
}

  Widget _appBar(){
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                const Color(0xff178723),
                const Color(0xff27AB4B)
              ])
          ),
          height:70,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 17),
          child:
          Expanded(
            child: Container(

              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(icon: Icon(Icons.arrow_back,color: Colors.white), onPressed: (){
                    Navigator.of(context).pop();
                  },),
                  Text("লোকেশন", style: TextStyle(color:Colors.white, fontSize: 20),),
                ],
              ),
            ),
          ),


        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: WillPopScope(
        onWillPop: (){
          Navigator.of(context).pop();
        },
        child: Scaffold(
          appBar:PreferredSize(child: _appBar(),preferredSize: Size(MediaQuery.of(context).size.width, 120),) ,
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: Column(
                children: <Widget>[
                        Container(

                            child: DropDownField(
                                  controller: _jelacontroller,
                              hintText: "জেলা নির্বাচন করুন",
                              enabled:true,
                              items: _jelaNames,
                              onValueChanged: (value){
                                    setState(() {
                                   _selectedJelaName= value;
                                   if(selectedRadio==0){
                                     Utils.saveZilaFromPreference(_selectedJelaName).then((value){
                                       setState(() {

                                       });
                                     });
                                   }
                                   print(value);
                                    });
                              },

                            ),

                        ),
                  SizedBox(height: 10,),
                  Row(
                    children: <Widget>[
                      Container(
                        height: 50,
                        width: 3,
                        color: Colors.green,
                      ),
                      SizedBox(width: 10,),
                      Container(

                        child: Expanded(child: Text("Gps বন্ধ থাকলে বা ডিভাইসের লোকেশন পাওয়া না গেলে Dhaka শহরের লোকেশনের উপর ভিত্তি করে সকল সময় দেখানো হবে। " )),
                      ),
                    ],
                  ),
                  SizedBox(height: 30,),
                  Text("এলাকা নির্বাচনের জন্য কোন পদ্ধতিটি ব্যাবহার করতে চান?", style: TextStyle( fontWeight: FontWeight.bold),),
                  Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Radio(
                            value: 0,
                            groupValue: selectedRadio,
                            activeColor: Colors.green,
                            onChanged: _handleRadioValueChange,
                          ),
                          Text("নির্দিস্ট একটি জেলা সিলেক্ট করতে চাই।")
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Radio(
                            value: 1,
                            groupValue: selectedRadio,
                            activeColor: Colors.green,
                            onChanged: _handleRadioValueChange,
                          ),
                          Text("gps এর মাধ্যমে অটোমেটিক পদ্ধতি")
                        ],
                      ),
                    ],
                  ),

                  Container(
                    height: 500,
                    child: Stack(
                      children: <Widget>[
                        GoogleMap(
                          onMapCreated: _onmapCreated,
                          initialCameraPosition: CameraPosition(
                            target: widget.latLng,zoom: 15,
                          ),
                          mapType: MapType.satellite,
                          myLocationButtonEnabled: true,
                          myLocationEnabled: true,
                          markers: markers,
                        ),
                      ],
                    )
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }



}

List<String> _jelaNames = [
  " Bagerhat "	,
  " Bandarban "	,
  " Barguna	"	,
  " Barisal	"	,
  " Bhola	"	,
  " Bogra	"	,
  " Brahmanbaria	"	,
  " Chandpur	"	,
  " Chittagong	"	,
  " Chuadanga	"	,
  " Comilla	"	,
  " Cox's Bazar	"	,
  " Dhaka	"	,
  " Dinajpur	"	,
  " Faridpur	"	,
  " Feni	"	,
  " Gaibandha	"	,
  " Gazipur	"	,
  " Gopalganj	"	,
  " Habiganj	"	,
  " Jaipurhat	"	,
  " Jamalpur	"	,
  " Jessore	"	,
  " Jhalakati	"	,
  " Jhenaidah	"	,
  " Khagrachari	"	,
  " Khulna	"	,
  " Kishoreganj	"	,
  " Kurigram	"	,
  " Kushtia	"	,
  " Lakshmipur	"	,
  " Lalmonirhat	"	,
  " Madaripur	"	,
  " Magura	"	,
  " Manikganj	"	,
  " Meherpur	"	,
  " Moulvibazar	"	,
  " Munshiganj	"	,
  " Mymensingh	"	,
  " Naogaon	"	,
  " Narail	"	,
  " Narayanganj	"	,
  " Narsingdi	"	,
  " Natore	"	,
  " Nawabganj	"	,
  " Netrakona	"	,
  " Nilphamari	"	,
  " Noakhali	"	,
  " Pabna	"	,
  " Panchagarh	"	,
  " Parbattya Chattagram	"	,
  " Patuakhali	"	,
  " Pirojpur	"	,
  " Rajbari	"	,
  " Rajshahi	"	,
  " Rangpur	"	,
  " Satkhira	"	,
  " Shariatpur	"	,
  " Sherpur	"	,
  " Sirajganj	"	,
  " Sunamganj	"	,
  " Sylhet "	,
  " Tangail "	,
  " Thakurgaon	"	,
];