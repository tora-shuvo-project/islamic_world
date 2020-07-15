

import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';
import 'package:searchtosu/helpers/provider_helpers.dart';
import 'package:latlong/latlong.dart';

class LocationPage extends StatefulWidget {
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
final _jelacontroller = TextEditingController();
MapController mapController = new MapController();
int selectedRadio;


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
//  _dropDownMenuItems = buildDroDownMenuItems(_jelaname);
//  _selectedJelaName = _dropDownMenuItems[0].value;
}



//onChangeDropDownItem(JelaName selectedJelaName){
//  setState(() {
//    _selectedJelaName = selectedJelaName;
//  });
//}
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
    final provider = Provider.of<LocationProvider>(context);

    buildMap(){
          provider.getDeviceCurrentLocation().then((response) => {
                mapController.move(LatLng(response.latitude, response.longitude), 15.0)
          });
    }
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

//                    child: DropdownButton(
//                      value: _selectedJelaName,
//                        items: _dropDownMenuItems,
//                        onChanged: onChangeDropDownItem)
//                  child: TextField(
//                    controller: _controller,
//                    decoration: InputDecoration(
//                      border: InputBorder.none,
//                      hintText: "দেশ নির্বাচন করুন",
//                      //"জেলা নির্বাচন করুন"
//                    ),
//                  ),

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
                  child: FlutterMap(
                    mapController: mapController,
                    options: new MapOptions(center: buildMap(),
                    zoom: 13.0,
                  ),
                    layers: [
                    new TileLayerOptions(
                    urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: ['a', 'b', 'c'])
                    ],
                  ),
                )
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