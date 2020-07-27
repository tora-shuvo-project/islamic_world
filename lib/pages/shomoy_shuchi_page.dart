import 'dart:async';

import 'package:adhan_flutter/adhan_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:searchtosu/helpers/provider_helpers.dart';
import 'package:searchtosu/pages/location_page.dart';
import 'package:searchtosu/utils/utils.dart';

class ShomoyShuchi extends StatefulWidget {
  static final route='/shomoyShuchi';
  @override
  _ShomoyShuchiState createState() => _ShomoyShuchiState();
}


class _ShomoyShuchiState extends State<ShomoyShuchi> {

  String zila;
  LatLng _center;
  String dayName,arabyDate,englishDate;
  String israk='';
  String aoyabin='';
  String fajartoday='';
  DateTime FazrTime,MagribTime,IsharTime,DuhurTime,AsorTime,SunsetTime,SunRiseTime;
  int IsharMinute, FazrMinute,MagribMinute,IsharMunite,DuhurMinute,AsorMinute,SunsetMinute,SunriseMinute;
  String currentTime;
  String nextTime;
  String dohortoday='';
  String nofoltoday='';
  String asortoday='';
  String Chasttoday="";
  String magribtoday='';
  String esatoday='';
  String nextPrayerName="";
  String nextPrayerTime="";
  String currentPrayerTime="";
  String currentPrayername="";
  String Sunrise="";
  String Sunset="";
  var longitude;
  var latitude;
  var minute;
  bool loading = true;
  String _timeString='';
  String majhabName='';
  bool isTimeString=false;

  Widget _appBar(){
    return Container(
      color: Colors.green,
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
                  child: Text("নামাজের সময়সূচী",style:  TextStyle(
                      color: Colors.white, fontSize: 20
                  ), ),
                ),

                InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context)=>LocationPage(_center)
                    )).then((_){
                      setState(() {
                        Utils.getZilaNameFromPreference().then((value){
                          setState(() {
                            zila=value;
                            _inital();
                          });
                        });
                      });
                    });
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.location_on, color: Colors.white,),
                      Text("|", style: TextStyle(color: Colors.white, fontSize: 17),),
                      Text("$zila", style: TextStyle(color: Colors.white, fontSize: 17),),
                    ],
                  ),
                ),

              ],
            ),
          ),

        ),

      ),
    );
  }
  _inital(){

    var _today = new HijriCalendar.now();
    arabyDate=_today.toFormat("dd MMMM,yyyy");
    englishDate=DateFormat('dd MMMM,yyyy').format(DateTime.now());
    dayName=DateFormat('EEEE').format(DateTime.now());
    final postion = Provider.of<LocationProvider>(context, listen: false).pos;
    Provider.of<LocationProvider>(context,listen: false).getDeviceCurrentLocation(postion: postion).then((_){
      setState(() {
        _center=LatLng(postion.latitude,postion.longitude);
      });
    });

  }

  @override
  void initState() {
    super.initState();
    _inital();

    _timeString='';
    Utils.getPrayerMethodFromPreference().then((value){
      setState(() {
        majhabName=value;
      });
    });

    Timer(
        Duration(seconds: 1),
            (){
          setState(() {
            isTimeString=true;
          });
        });

  }

  void _getlatlngwithData(LatLng latLng) {
    latitude=latLng.latitude;
    longitude=latLng.longitude;
  }

  @override
  Widget build(BuildContext context) {
    var now = new DateTime.now();
    var Pminute = DateTime.now().minute;

    zilaInitialization();

    return SafeArea(
      child: Scaffold(
        appBar:PreferredSize(child: _appBar(),preferredSize: Size(MediaQuery.of(context).size.width, 120),) ,
        body: SingleChildScrollView(
          child: Container(
            child: Stack(
              children: <Widget>[
           Container(
                  color: Colors.green,
                  height: 280,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  width: MediaQuery.of(context).size.width,

                    child: Column(
                      children: <Widget>[
                       Row(
                            children: <Widget>[
                              Expanded(flex:2,
                                child:
                                Center(
                                  child:
                                  isTimeString?
                                  Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text("পরবর্তি ওয়াক্ত",style: TextStyle(fontSize: 17,color: Colors.white),),
                                        Center(
                                          child: FutureBuilder(
                                                future: getNextPrayer(),
                                                    builder: (context, AsyncSnapshot<Prayer> snapshot) {
                                                      if (snapshot.hasData) {
                                                        final prayer = snapshot.data;
                                                        if(prayer.toString().trim()=="Prayer.ASR"){
                                                          nextTime = "আসর";
                                                          nextPrayerTime=asortoday;
                                                          //TimeString
                                                          if(AsorMinute.toString()== null){
                                                            minute = 0;
                                                          }else{
                                                            if(Pminute.toInt()>AsorMinute){
                                                              minute = Pminute-AsorMinute;
                                                            }else{
                                                              minute=AsorMinute-Pminute;
                                                            }
                                                          }
                                                          //timeString

                                                          _timeString="${AsorTime.difference(DateTime.now()).inHours.abs()} ঘন্টা "
                                                              "${minute} মিনিট"
                                                              " ${60-DateTime.now().second}  সেকেন্ড পর  ";

                                                        }

                                                        else if(prayer.toString().trim()=="Prayer.FAJR"){
                                                          nextTime = "ফজর";
                                                          nextPrayerTime=fajartoday;
                                                          //TimeString
                                                          if(FazrMinute.toString()== null){
                                                            minute = 0;
                                                          }else{
                                                            if(DateTime.now().minute>FazrMinute){
                                                              minute = DateTime.now().minute-FazrMinute;
                                                            }else{
                                                              minute=FazrMinute-DateTime.now().minute;
                                                            }
                                                          }
                                                          //timeString

                                                          _timeString="${FazrTime.difference(DateTime.now()).inHours.abs()} ঘন্টা "
                                                              "${minute} মিনিট"
                                                              " ${60-DateTime.now().second}  সেকেন্ড পর  ";


                                                        }

                                                        else if(prayer.toString().trim()=="Prayer.SUNRISE"){
                                                          nextTime = "নামাজের জন্য হারাম";
                                                          nextPrayerTime=Sunrise;
                                                          //TimeString
                                                          if(SunriseMinute.toString()== null){
                                                            minute = 0;
                                                          }else{
                                                            if(DateTime.now().minute>SunriseMinute){
                                                              minute = DateTime.now().minute-SunriseMinute;
                                                            }else{
                                                              minute=SunriseMinute-DateTime.now().minute;
                                                            }
                                                          }
                                                          //timeString

                                                          _timeString="${SunRiseTime.difference(DateTime.now()).inHours.abs()} ঘন্টা "
                                                              "${minute} মিনিট"
                                                              " ${60-DateTime.now().second}  সেকেন্ড পর  ";


                                                        }

                                                        else if(prayer.toString().trim()=="Prayer.DHUHR"){

                                                          nextTime = "যোহর";
                                                          nextPrayerTime=dohortoday;

                                                          //TimeString
                                                          if(DuhurMinute.toString()== null){
                                                            minute = 0;
                                                          }else{
                                                            if(DateTime.now().minute>DuhurMinute){
                                                              minute = DateTime.now().minute-DuhurMinute;
                                                            }else{
                                                              minute=DuhurMinute-DateTime.now().minute;
                                                            }
                                                          }

                                                          //timeString

                                                          _timeString="${DuhurTime.difference(DateTime.now()).inHours.abs()} ঘন্টা "
                                                              "${minute} মিনিট"
                                                              " ${60-DateTime.now().second}  সেকেন্ড পর  ";


                                                        }

                                                        else if(prayer.toString().trim()=="Prayer.MAGHRIB"){
                                                          nextTime = "মাগরিব";
                                                          nextPrayerTime=magribtoday;

                                                          //TimeString
                                                          if(MagribMinute== null){
                                                            minute = 0;
                                                          }else{
                                                            if(DateTime.now().minute>MagribMinute){
                                                              minute = DateTime.now().minute-MagribMinute;
                                                            }else{
                                                              minute=MagribMinute-DateTime.now().minute;
                                                            }
                                                          }
                                                          //timeString

                                                          _timeString="${MagribTime.difference(DateTime.now()).inHours.abs()} ঘন্টা "
                                                              "${minute} মিনিট"
                                                              " ${60-DateTime.now().second}  সেকেন্ড পর  ";



                                                        }
                                                        else if(prayer.toString().trim()=="Prayer.ISHA"){
                                                          nextTime = "এশা";
                                                          nextPrayerTime=esatoday;

                                                          //TimeString
                                                          if(IsharMunite== null){
                                                            minute = 0;
                                                          }else{
                                                            if(DateTime.now().minute>IsharMunite){
                                                              minute = DateTime.now().minute-IsharMunite;
                                                            }else{
                                                              minute=IsharMunite-DateTime.now().minute;
                                                            }
                                                          }
                                                          //timeString

                                                          _timeString="${IsharTime.difference(DateTime.now()).inHours.abs()} ঘন্টা "
                                                              "${minute} মিনিট"
                                                              " ${60-DateTime.now().second}  সেকেন্ড পর  ";



                                                        }else
                                                        {
                                                          nextTime = "নফল";
                                                        }
                                                        return
                                                          Row(
                                                          children: <Widget>[
                                                            Text(nextTime,style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold) ),
                                                            SizedBox(width: 10,),
                                                            nextTime == "নফল" ? Container(): Text(nextPrayerTime,style: TextStyle(fontSize: 20,color: Colors.white),)


                                                          ],
                                                        );
                                                      }
                                                      if(snapshot.hasError){
                                                        print(snapshot.error);
                                                        return Container();
                                                      }
                                                      return CircularProgressIndicator();
                                                }

                  ),
                                        ),
                                        SizedBox(height: 10,),
                                        Text(_timeString,style: TextStyle(fontSize: 17,color: Colors.white),),
                                        //    VerticalDivider(width: 2,thickness: 2, color: Colors.white,),
                                        SizedBox(height: 10,),

                                      ],
                                    ):
                                  Container(
                                    child: Text('........অপেক্ষা করুণ......',style: TextStyle(color: Colors.white),),
                                  ),
                                ),
                              ),

                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    FittedBox(child: Text("বর্তমান ওয়াক্ত",style: TextStyle(fontSize: 17,color: Colors.white),)),
                                    //style: TextStyle(color: Colors.white,fontSize: 30, fontWeight: FontWeight.bold),
                                     Container(
                                        child:
                                        FutureBuilder(
                                          future: getCurrentPrayer(),
                                          builder: (context, AsyncSnapshot<Prayer> snapshot) {
                                            if (snapshot.hasData) {
                                              final prayer = snapshot.data;
                                              if(prayer.toString().trim()=="Prayer.ASR"){
                                                currentTime = "আসর";
                                              }else if(prayer.toString().trim()=="Prayer.FAJR"){
                                                currentTime = "ফজর";
                                              }else if(prayer.toString().trim()=="Prayer.DHUHR"){
                                                currentTime = "যোহর";
                                              }else if(prayer.toString().trim()=="Prayer.MAGHRIB"){
                                                currentTime = "মাগরিব";
                                              }else if(prayer.toString().trim()=="Prayer.ISHA"){
                                                currentTime = "এশা";
                                              }else{
                                                currentTime = "নফল";
                                              }
                                              return Text(currentTime, style: TextStyle(
                                                  color: Colors.white,fontSize: 30, fontWeight: FontWeight.bold
                                              ),);
                                            } else if (snapshot.hasError) {
                                              print(snapshot.hasError);
                                              return Container();
                                            } else {
                                              return Text('Waiting...');
                                            }
                                          },
                                        ),
                                      ),

                                  ],
                                ),
                              ),
                            ],
                          ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Image.asset("images/sunrise.png", width: 50, height:50 ,),
                                Text("Sunrise", style: TextStyle(color: Colors.white)),
                                Container(child:

                                FutureBuilder(
                                  future: getTodaySuriseTime(),
                                  builder: (context, AsyncSnapshot<DateTime> snapshot) {
                                    if (snapshot.hasData) {
                                      final dateTime = snapshot.data.toLocal();
                                      Sunrise=DateFormat.jm().format(dateTime);
                                      SunRiseTime=dateTime;
                                      SunriseMinute= dateTime.minute;
                                      return Text(Sunrise, style: TextStyle(

                                          color: Colors.white
                                      ),);
                                    } else if (snapshot.hasError) {
                                      print(snapshot.hasError);
                                      return SingleChildScrollView();
                                    } else {
                                      return Text('Waiting...');
                                    }
                                  },
                                ),),

                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Image.asset("images/sunset.png", width: 50, height:50 ,), //Text(Sunset,style: TextStyle(color: Colors.white))
                                Text("Sunset",style: TextStyle(color: Colors.white)),
                                Container(child:
                                FutureBuilder(
                                  future: getTodayMagribTime(),
                                  builder: (context, AsyncSnapshot<DateTime> snapshot) {
                                    if (snapshot.hasData) {
                                      final dateTime = snapshot.data.toLocal();
                                      Sunset=DateFormat.jm().format(dateTime);
                                      SunsetTime=dateTime;
                                      SunsetMinute= dateTime.minute;
                                      return Text(Sunset, style: TextStyle(

                                         color: Colors.white
                                      ),);
                                    } else if (snapshot.hasError) {
                                      print(snapshot.hasError);
                                      return SingleChildScrollView();
                                    } else {
                                      return Text('Waiting...');
                                    }
                                  },
                                ),),

                              ],
                            )
                          ],
                        )
                      ],
                    ),

                ),
                Container(
                  margin: EdgeInsets.only(top: 230,left: 10,right: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                    child: Container(
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                        child: Column(
                          children: <Widget>[
                            Container(
                              child:Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.event),
                                  SizedBox(width: 5,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text(dayName, style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),

                                      Text("$englishDate/ $arabyDate"),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("ফজর"),
                                Row(
                                  children: <Widget>[
                                    Container(child: FutureBuilder(
                                      future: getTodayFajrTime(),
                                      builder: (context, AsyncSnapshot<DateTime> snapshot) {
                                        if (snapshot.hasData) {
                                          final dateTime = snapshot.data.toLocal();
                                          fajartoday=DateFormat.jm().format(dateTime);
                                          FazrTime=dateTime;
                                          FazrMinute= dateTime.minute;
                                          return Text(fajartoday, style: TextStyle(
                                              fontWeight: FontWeight.bold
                                          ),);
                                        } else if (snapshot.hasError) {
                                          print(snapshot.hasError);
                                          return SingleChildScrollView();
                                        } else {
                                          return Text('Waiting...');
                                        }
                                      },
                                    ),),
                                    IconButton(icon: Icon(Icons.notifications), onPressed: (){}),

                                  ],
                                )
                              ],
                            ),
                            Container(
                              height: 1,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.black87,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("যোহর"),
                                Row(
                                  children: <Widget>[
                                    Container(child: FutureBuilder(
                                      future: getTodaydhuhurTime(),
                                      builder: (context, AsyncSnapshot<DateTime> snapshot) {
                                        if (snapshot.hasData) {
                                          final dateTime = snapshot.data.toLocal();
                                          dohortoday=DateFormat.jm().format(dateTime);
                                          DuhurTime=dateTime;
                                          DuhurMinute= dateTime.minute;
                                          return Text(dohortoday, style: TextStyle(

                                              fontWeight: FontWeight.bold
                                          ),);
                                        } else if (snapshot.hasError) {
                                          print(snapshot.hasError);
                                          return SingleChildScrollView();
                                        } else {
                                          return Text('Waiting...');
                                        }
                                      },
                                    ),),
                                    IconButton(icon: Icon(Icons.notifications), onPressed: (){}),

                                  ],
                                )
                              ],
                            ),
                            Container(
                              height: 1,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.black87,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("আসর"),
                                Row(
                                  children: <Widget>[
                                    Container(child: FutureBuilder(
                                      future: getTodayAsorTime(),
                                      builder: (context, AsyncSnapshot<DateTime> snapshot) {
                                        if (snapshot.hasData) {
                                          final dateTime = snapshot.data.toLocal();
                                          asortoday=DateFormat.jm().format(dateTime);
                                          AsorTime=dateTime;
                                          AsorMinute= dateTime.minute;
                                          return Text(asortoday, style: TextStyle(

                                              fontWeight: FontWeight.bold
                                          ),);
                                        } else if (snapshot.hasError) {
                                          print(snapshot.hasError);
                                          return SingleChildScrollView();
                                        } else {
                                          return Text('Waiting...');
                                        }
                                      },
                                    ),),
                                    IconButton(icon: Icon(Icons.notifications), onPressed: (){}),

                                  ],
                                )
                              ],
                            ),
                            Container(
                              height: 1,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.black87,
                            ),
                          Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("মাগরিব"),
                                  Row(
                                    children: <Widget>[
                                      Container(child: FutureBuilder(
                                        future: getTodayMagribTime(),
                                        builder: (context, AsyncSnapshot<DateTime> snapshot) {
                                          if (snapshot.hasData) {
                                            final dateTime = snapshot.data.toLocal();
                                            magribtoday=DateFormat.jm().format(dateTime);
                                            MagribTime=dateTime;
                                            MagribMinute= dateTime.minute;
                                            return Text(magribtoday, style: TextStyle(

                                                fontWeight: FontWeight.bold
                                            ),);
                                          } else if (snapshot.hasError) {
                                            print(snapshot.hasError);
                                            return SingleChildScrollView();
                                          } else {
                                            return Text('Waiting...');
                                          }
                                        },
                                      ),),
                                      IconButton(icon: Icon(Icons.notifications), onPressed: (){}),

                                    ],
                                  )
                                ],
                              ),


                            Container(
                              height: 1,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.black87,
                            ),
                           Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                Text("এশা"),
                                Row(
                                  children: <Widget>[
                                    Container(child: FutureBuilder(
                                      future: getTodayIsharTime(),
                                      builder: (context, AsyncSnapshot<DateTime> snapshot) {
                                        if (snapshot.hasData) {
                                          final dateTime = snapshot.data.toLocal();
                                          esatoday=DateFormat.jm().format(dateTime);
                                          IsharTime=dateTime;
                                          IsharMinute= dateTime.minute;
                                          return Text(esatoday, style: TextStyle(
                                              fontWeight: FontWeight.bold
                                          ),);
                                        } else if (snapshot.hasError) {
                                          print(snapshot.hasError);
                                          return SingleChildScrollView();
                                        } else {
                                          return Text('Waiting...');
                                        }
                                      },
                                    ),),
                                    IconButton(icon: Icon(Icons.notifications), onPressed: (){}),

                                  ],
                                )
                              ],
                              ),

                            Container(
                              height: 1,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.black87,
                            )
                          ],
                        )

                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

    );
  }
  Future<DateTime> getTodayFajrTime() async {
    final adhan = AdhanFlutter.create(Coordinates(latitude, longitude), DateTime.now(), CalculationMethod.KARACHI,);
    return await adhan.fajr;
  }
  Future<DateTime> getTodaydhuhurTime() async {
    final adhan = AdhanFlutter.create(Coordinates(latitude, longitude), DateTime.now(), CalculationMethod.KARACHI);
    return await adhan.dhuhr;
  }
  Future<DateTime> getTodayIsharTime() async {
    final adhan = AdhanFlutter.create(Coordinates(latitude, longitude), DateTime.now(), CalculationMethod.KARACHI);
    return await adhan.isha;
  }
  Future<DateTime> getTodayMagribTime() async {
    final adhan = AdhanFlutter.create(Coordinates(latitude, longitude), DateTime.now(), CalculationMethod.KARACHI);
    return await adhan.maghrib;
  }
  Future<DateTime> getTodayAsorTime() async {
    final adhan = AdhanFlutter.create(Coordinates(latitude, longitude), DateTime.now(), CalculationMethod.KARACHI);


    if(majhabName=='hanafi'){
      adhan.setMadhab(Madhab.HANAFI);
    }else if(majhabName=='safe'){
      adhan.setMadhab(Madhab.SHAFI);
    }else{
      adhan.setMadhab(Madhab.HANAFI);
    }

    return await adhan.asr;
  }
  Future<DateTime> getTodaySuriseTime() async {
    final adhan = AdhanFlutter.create(Coordinates(latitude, longitude), DateTime.now(), CalculationMethod.KARACHI);
    return await adhan.sunrise;
  }
  Future<Prayer> getCurrentPrayer() async {
    final adhan = AdhanFlutter.create(Coordinates(latitude, longitude), DateTime.now(), CalculationMethod.KARACHI);
    return await adhan.currentPrayer();
  }

  Future<Prayer> getNextPrayer() async {
    final adhan = AdhanFlutter.create(Coordinates(latitude, longitude), DateTime.now(), CalculationMethod.KARACHI);
    return await adhan.nextPrayer();
  }

  void zilaInitialization() {

    Utils.getZilaNameFromPreference().then((zilaName){
      setState(() {

        zila=zilaName;
        print(zilaName);

        if(zilaName.trim()=='Dhaka'){
          print('Dhaka Called');
          _getlatlngwithData(LatLng(23.7115253,90.4111451));
        }else if(zilaName.trim()=='Faridpur'){
          _getlatlngwithData(LatLng(23.6070822,89.8429406));
        }else if(zilaName.trim()=='Gazipur'){
          _getlatlngwithData(LatLng(24.0022858,90.4264283));
        }else if(zilaName.trim()=='Gopalganj'){
          _getlatlngwithData(LatLng(23.0050857,89.8266059));
        }else if(zilaName.trim()=='Jamalpur'){
          _getlatlngwithData(LatLng(24.937533,89.937775));
        }else if(zilaName.trim()=='Kishoreganj'){
          _getlatlngwithData(LatLng(24.444937,90.776575));
        }else if(zilaName.trim()=='Madaripur'){
          _getlatlngwithData(LatLng(23.164102,90.1896805));
        }else if(zilaName.trim()=='Manikganj'){
          _getlatlngwithData(LatLng(23.8644,90.0047));
        }else if(zilaName.trim()=='Munshiganj'){
          _getlatlngwithData(LatLng(23.5422,90.5305));
        }else if(zilaName.trim()=='Mymensingh'){
          _getlatlngwithData(LatLng(24.7471,90.4203));
        }else if(zilaName.trim()=='Narayanganj'){
          _getlatlngwithData(LatLng(23.63366,90.496482));
        }else if(zilaName.trim()=='Narsingdi'){
          _getlatlngwithData(LatLng(23.932233,90.71541));
        }else if(zilaName.trim()=='Netrokona'){
          _getlatlngwithData(LatLng(24.870955,90.727887));
        }else if(zilaName.trim()=='Netrakona'){
          _getlatlngwithData(LatLng(24.870955,90.727887));
        }else if(zilaName.trim()=='Rajbari'){
          _getlatlngwithData(LatLng(23.7574305,89.6444665));
        }else if(zilaName.trim()=='Shariatpur'){
          _getlatlngwithData(LatLng(23.2423,90.4348));
        }else if(zilaName.trim()=='Sherpur'){
          _getlatlngwithData(LatLng(25.0204933,90.0152966));
        }else if(zilaName.trim()=='Tangail'){
          _getlatlngwithData(LatLng(24.2513,89.9167));
        }else if(zilaName.trim()=='Bogura'){
          _getlatlngwithData(LatLng(24.8465228,89.377755));
        }else if(zilaName.trim()=='Bogra'){
          _getlatlngwithData(LatLng(24.8465228,89.377755));
        }else if(zilaName.trim()=='Joypurhat'){
          _getlatlngwithData(LatLng(25.0968,89.0227));
        }else if(zilaName.trim()=='Jaipurhat'){
          _getlatlngwithData(LatLng(25.0968,89.0227));
        }else if(zilaName.trim()=='Naogaon'){
          _getlatlngwithData(LatLng(24.7936,88.9318));
        }else if(zilaName.trim()=='Natore'){
          _getlatlngwithData(LatLng(24.420556,89.000282));
        }else if(zilaName.trim()=='Nawabganj'){
          _getlatlngwithData(LatLng(24.5965034,88.2775122));
        }else if(zilaName.trim()=='Pabna'){
          _getlatlngwithData(LatLng(23.998524,89.233645));
        }else if(zilaName.trim()=='Rajshahi'){
          _getlatlngwithData(LatLng(24.3745,88.6042));
        }else if(zilaName.trim()=='Sirajgonj'){
          _getlatlngwithData(LatLng(24.4533978,89.7006815));
        }else if(zilaName.trim()=='Sirajganj'){
          _getlatlngwithData(LatLng(24.4533978,89.7006815));
        }else if(zilaName.trim()=='Dinajpur'){
          _getlatlngwithData(LatLng(25.6217061,88.6354504));
        }else if(zilaName.trim()=='Gaibandha'){
          _getlatlngwithData(LatLng(25.328751,89.528088));
        }else if(zilaName.trim()=='Kurigram'){
          _getlatlngwithData(LatLng(25.805445,89.636174));
        }else if(zilaName.trim()=='Lalmonirhat'){
          _getlatlngwithData(LatLng(25.9923,89.2847));
        }else if(zilaName.trim()=='Nilphamari'){
          _getlatlngwithData(LatLng(25.931794,88.856006));
        }else if(zilaName.trim()=='Panchagarh'){
          _getlatlngwithData(LatLng(26.3411,88.5541606));
        }else if(zilaName.trim()=='Rangpur'){
          _getlatlngwithData(LatLng(25.7558096,89.244462));
        }else if(zilaName.trim()=='Thakurgaon'){
          _getlatlngwithData(LatLng(26.0336945,88.4616834));
        }else if(zilaName.trim()=='Barguna'){
          _getlatlngwithData(LatLng(22.0953,90.1121));
        }else if(zilaName.trim()=='Barishal'){
          _getlatlngwithData(LatLng(22.7010,90.3535));
        }else if(zilaName.trim()=='Barisal'){
          _getlatlngwithData(LatLng(22.7010,90.3535));
        }else if(zilaName.trim()=='Bhola'){
          _getlatlngwithData(LatLng(22.685923,90.648179));
        }else if(zilaName.trim()=='Jhalokati'){
          _getlatlngwithData(LatLng(22.6406,90.1987));
        }else if(zilaName.trim()=='Jhalakati'){
          _getlatlngwithData(LatLng(22.6406,90.1987));
        }else if(zilaName.trim()=='Patuakhali'){
          _getlatlngwithData(LatLng(22.3596316,90.3298712));
        }else if(zilaName.trim()=='Pirojpur'){
          _getlatlngwithData(LatLng(22.5841,89.9720));
        }else if(zilaName.trim()=='Bandarban'){
          _getlatlngwithData(LatLng(22.1953275,92.2183773));
        }else if(zilaName.trim()=='Brahmanbaria'){
          _getlatlngwithData(LatLng(23.9570904,91.1119286));
        }else if(zilaName.trim()=='Chandpur'){
          _getlatlngwithData(LatLng(23.2332585,90.6712912));
        }else if(zilaName.trim()=='Chattogram'){
          _getlatlngwithData(LatLng(22.335109,91.834073));
        }else if(zilaName.trim()=='Chittagong'){
          _getlatlngwithData(LatLng(22.335109,91.834073));
        }else if(zilaName.trim()=='Cumilla'){
          _getlatlngwithData(LatLng(23.4682747,91.1788135));
        }else if(zilaName.trim()=='Comilla'){
          _getlatlngwithData(LatLng(23.4682747,91.1788135));
        }else if(zilaName.trim()=="Cox's Bazar"){
          _getlatlngwithData(LatLng(21.4272,92.0058));
        }else if(zilaName.trim()=='Feni'){
          _getlatlngwithData(LatLng(23.0159,91.3976));
        }else if(zilaName.trim()=='Khagrachari'){
          _getlatlngwithData(LatLng(23.119285,91.984663));
        }else if(zilaName.trim()=='Lakshmipur'){
          _getlatlngwithData(LatLng(22.942477,90.841184));
        }else if(zilaName.trim()=='Noakhali'){
          _getlatlngwithData(LatLng(22.869563,91.099398));
        }else if(zilaName.trim()=='Rangamati'){
          _getlatlngwithData(LatLng(22.7324,92.2985));
        }else if(zilaName.trim()=='Parbattya Chattagram'){
          _getlatlngwithData(LatLng(22.7324,92.2985));
        }else if(zilaName.trim()=='Habiganj'){
          _getlatlngwithData(LatLng(24.374945,91.41553));
        }else if(zilaName.trim()=='Maulvibazar'){
          _getlatlngwithData(LatLng(24.482934,91.777417));
        }else if(zilaName.trim()=='Moulvibazar'){
          _getlatlngwithData(LatLng(24.482934,91.777417));
        }else if(zilaName.trim()=='Sunamganj'){
          _getlatlngwithData(LatLng(25.0658042,91.3950115));
        }else if(zilaName.trim()=='Sylhet'){
          _getlatlngwithData(LatLng(24.8897956,91.8697894));
        }else if(zilaName.trim()=='Bagerhat'){
          _getlatlngwithData(LatLng(22.651568,89.785938));
        }else if(zilaName.trim()=='Chuadanga'){
          _getlatlngwithData(LatLng(23.6401961,88.841841));
        }else if(zilaName.trim()=='Jashore'){
          _getlatlngwithData(LatLng(23.16643,89.2081126));
        }else if(zilaName.trim()=='Jessore'){
          _getlatlngwithData(LatLng(23.16643,89.2081126));
        }else if(zilaName.trim()=='Jhenaidah'){
          _getlatlngwithData(LatLng(23.5448176,89.1539213));
        }else if(zilaName.trim()=='Khulna'){
          _getlatlngwithData(LatLng(22.815774,89.568679));
        }else if(zilaName.trim()=='Kushtia'){
          _getlatlngwithData(LatLng(23.901258,89.120482));
        }else if(zilaName.trim()=='Magura'){
          _getlatlngwithData(LatLng(23.487337,89.419956));
        }else if(zilaName.trim()=='Meherpur'){
          _getlatlngwithData(LatLng(23.762213,88.631821));
        }else if(zilaName.trim()=='Narail'){
          _getlatlngwithData(LatLng(23.172534,89.512672));
        }else if(zilaName.trim()=='Satkhira'){
          _getlatlngwithData(LatLng(22.7185,89.0705));
        }else if(zilaName.trim()=='Alipur'){
          _getlatlngwithData(LatLng(22.32,88.24));
        }else if(zilaName.trim()=='Alipurduar'){
          _getlatlngwithData(LatLng(26.30,89.35));
        }else if(zilaName.trim()=='Arambagh'){
          _getlatlngwithData(LatLng(22.53,87.50));
        }else if(zilaName.trim()=='Asansol'){
          _getlatlngwithData(LatLng(23.42,87.01));
        }else if(zilaName.trim()=='Baharampur'){
          _getlatlngwithData(LatLng(24.06,88.19));
        }else if(zilaName.trim()=='Baksa Duar	'){
          _getlatlngwithData(LatLng(26.45,89.35));
        }else if(zilaName.trim()=='Balurghat'){
          _getlatlngwithData(LatLng(25.14,88.47));
        }else if(zilaName.trim()=='Bankura'){
          _getlatlngwithData(LatLng(23.14,87.07));
        }else if(zilaName.trim()=='Barackpore'){
          _getlatlngwithData(LatLng(22.46,88.24));
        }else if(zilaName.trim()=='Baranagar'){
          _getlatlngwithData(LatLng(22.38,88.22));
        }else if(zilaName.trim()=='Barddhaman'){
          _getlatlngwithData(LatLng(23.16,87.54));
        }else if(zilaName.trim()=='Beldanga'){
          _getlatlngwithData(LatLng(23.58,88.20));
        }else if(zilaName.trim()=='Benapol'){
          _getlatlngwithData(LatLng(23.04,88.32));
        }else if(zilaName.trim()=='Bhadreswar'){
          _getlatlngwithData(LatLng(22.49,88.20));
        }else if(zilaName.trim()=='Bhatpara'){
          _getlatlngwithData(LatLng(22.54,88.25));
        }else if(zilaName.trim()=='Bishnupur'){
          _getlatlngwithData(LatLng(23.05,87.23));
        }else if(zilaName.trim()=='Calcutta'){
          _getlatlngwithData(LatLng(22.34,88.24));
        }else if(zilaName.trim()=='Chandernagore'){
          _getlatlngwithData(LatLng(22.52,88.25));
        }else if(zilaName.trim()=='Chandrakona'){
          _getlatlngwithData(LatLng(22.44,87.33));
        }else if(zilaName.trim()=='Chanduria'){
          _getlatlngwithData(LatLng(22.56,88.55));
        }else if(zilaName.trim()=='Chinsura'){
          _getlatlngwithData(LatLng(22.53,88.27));
        }else if(zilaName.trim()=='Chittaranjan'){
          _getlatlngwithData(LatLng(23.50,87.00));
        }else if(zilaName.trim()=='Contai'){
          _getlatlngwithData(LatLng(21.50,87.48));
        }else if(zilaName.trim()=='Damodar, R.	'){
          _getlatlngwithData(LatLng(23.17,87.35));
        }else if(zilaName.trim()=='Darjilling'){
          _getlatlngwithData(LatLng(27.03,88.18));
        }else if(zilaName.trim()=='Diamond Harbour	'){
          _getlatlngwithData(LatLng(22.11,88.14));
        }else if(zilaName.trim()=='Dum-Dum	'){
          _getlatlngwithData(LatLng(22.38,88.38));
        }else if(zilaName.trim()=='Duragapur'){
          _getlatlngwithData(LatLng(22.30,87.20));
        }else if(zilaName.trim()=='Haora'){
          _getlatlngwithData(LatLng(22.35,88.23));
        }else if(zilaName.trim()=='Ingraj Bazar	'){
          _getlatlngwithData(LatLng(25.00,88.11));
        }else if(zilaName.trim()=='Jalpaiguri'){
          _getlatlngwithData(LatLng(26.32,88.46));
        }else if(zilaName.trim()=='Jangipur'){
          _getlatlngwithData(LatLng(24.28,88.05));
        }else if(zilaName.trim()=='Katoya'){
          _getlatlngwithData(LatLng(23.39,88.11));
        }else if(zilaName.trim()=='Kharagpur'){
          _getlatlngwithData(LatLng(22.30,87.20));
        }else if(zilaName.trim()=='Koch Bihar	'){
          _getlatlngwithData(LatLng(26.20,89.29));
        }else if(zilaName.trim()=='Kotalpur'){
          _getlatlngwithData(LatLng(23.01,87.38));
        }else if(zilaName.trim()=='Krishnanagar'){
          _getlatlngwithData(LatLng(23.24,88.33));
        }else if(zilaName.trim()=='Lalbagh'){
          _getlatlngwithData(LatLng(24.13,88.19));
        }else if(zilaName.trim()=='Mehinipur'){
          _getlatlngwithData(LatLng(22.25,87.21));
        }else if(zilaName.trim()=='Murshidabad'){
          _getlatlngwithData(LatLng(24.11,88.19));
        }else if(zilaName.trim()=='Nabadwip'){
          _getlatlngwithData(LatLng(23.24,88.23));
        }else if(zilaName.trim()=='Nalhati'){
          _getlatlngwithData(LatLng(22.54,88.28));
        }else if(zilaName.trim()=='Purulliya'){
          _getlatlngwithData(LatLng(23.2,88.28));
        }else if(zilaName.trim()=='Raghunathpur'){
          _getlatlngwithData(LatLng(23.32,86.43));
        }else if(zilaName.trim()=='Ramaghat'){
          _getlatlngwithData(LatLng(23.11,88.37));
        }else if(zilaName.trim()=='Raniganj'){
          _getlatlngwithData(LatLng(25.52,57.52));
        }else if(zilaName.trim()=='Sagar I.	'){
          _getlatlngwithData(LatLng(21.4,88.1));
        }else if(zilaName.trim()=='Santipur'){
          _getlatlngwithData(LatLng(23.14,88.29));
        }else if(zilaName.trim()=='Serampore'){
          _getlatlngwithData(LatLng(22.45,88.23));
        }else if(zilaName.trim()=='Siliguri'){
          _getlatlngwithData(LatLng(26.42,88.25));
        }else if(zilaName.trim()=='Tamluk'){
          _getlatlngwithData(LatLng(22.18,87.58));
        }else if(zilaName.trim()=='Tilpara'){
          _getlatlngwithData(LatLng(23.58,87.32));
        }else if(zilaName.trim()=='Arakan Rakhine'){
          _getlatlngwithData(LatLng(20.1041,93.5813));
        }else if(zilaName.trim()=='Yangon'){
          _getlatlngwithData(LatLng(16.8409,96.1735));
        }
        else{
          print('Default Called');
          _getlatlngwithData(LatLng(23.7115253,90.4111451));
        }
      });
    });
  }


}
