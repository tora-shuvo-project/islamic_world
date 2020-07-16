import 'dart:async';

import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



class LocationPage extends StatefulWidget {

  final LatLng latLng;
  LocationPage(this.latLng);

  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
final _jelacontroller = TextEditingController();
int selectedRadio;
Set<Marker> markers={};
Completer<GoogleMapController> _completer=Completer();

void _onmapCreated(GoogleMapController controller) {
  _completer.complete(controller);
}


void _handleRadioValueChange(int value) {
  setState(() {
    selectedRadio = value;

    switch (selectedRadio) {
      case 0:
        print("Selected first value");
    
    break;
    case 1:
      print("Selected Second value");
    break;
    }
    });
}
String _selectedJelaName="";

@override
void initState() {
  super.initState();
  selectedRadio =0;
  markers.add(Marker(
      markerId: MarkerId(widget.latLng.toString()),
      position: widget.latLng,
    infoWindow: InfoWindow(
      title: '${widget.latLng}'
    ),
    icon: BitmapDescriptor.defaultMarker,
  ));
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
                        indoorViewEnabled: true,
                        trafficEnabled: true,
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
    );
  }


}

List<String> _jelaNames = [
  "বরগুনা	"	,
  "বরিশাল	"	,
  "ভোলা	"	,
  "ঝালকাঠি	"	,
  "পটুয়াখালি	"	,
  "পিরোজপুর	"	,
  "বান্দরবান	"	,
  "ব্রাহ্মণবাড়িয়া	"	,
  "চাঁদপুর	"	,
  "চট্টগ্রাম	"	,
  "কুমিল্লা	"	,
  "কক্সবাজার	"	,
  "ফেনী	"	,
  "খাগড়াছড়ি	"	,
  "লক্ষ্মীপুর	"	,
  "নোয়াখালি	"	,
  "রাঙ্গামাটি	"	,
  "ঢাকা	"	,
  "ফরিদপুর	"	,
  "গাজীপুর	"	,
  "গোপালগঞ্জ	"	,
  "কিশোরগঞ্জ	"	,
  "মাদারিপুর	"	,
  "মানিকগঞ্জ	"	,
  "মুন্সিগঞ্জ	"	,
  "নারায়ণগঞ্জ	"	,
  "নরসিংদি	"	,
  "রাজবাড়ি	"	,
  "শরিয়তপুর	"	,
  "টাঙ্গাইল	"	,
  "বাগেরহাট	"	,
  "চুয়াডাঙ্গা	"	,
  "যশোর	"	,
  "ঝিনাইদহ	"	,
  "খুলনা	"	,
  "কুষ্টিয়া	"	,
  "মাগুরা	"	,
  "মেহেরপুর	"	,
  "নড়াইল	"	,
  "সাতক্ষীরা	"	,
  "জামালপুর	"	,
  "ময়মনসিংহ	"	,
  "নেত্রকোনা	"	,
  "শেরপুর	"	,
  "বগুড়া	"	,
  "জয়পুরহাট	"	,
  "নওগাঁ	"	,
  "নাটোর	"	,
  "চাঁপাইনবাবগঞ্জ	"	,
  "পাবনা	"	,
  "রাজশাহী	"	,
  "সিরাজগঞ্জ	"	,
  "দিনাজপুর	"	,
  "গাইবান্ধা	"	,
  "কুড়িগ্রাম	"	,
  "লালমনিরহাট	"	,
  "নীলফামারি	"	,
  "পঞ্চগড়	"	,
  "রংপুর	"	,
  "ঠাকুরগাঁও	"	,
  "হবিগঞ্জ	"	,
  "মৌলভীবাজার"	,
  "সুনামগঞ্জ"	,
  "সিলেট	"	,
];