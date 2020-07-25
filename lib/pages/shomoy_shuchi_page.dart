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
  String _timeString="";

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
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocationProvider>(context);
    var now = new DateTime.now();
    var Pminute = DateTime.now().minute;
    var timezone = now.timeZoneOffset.inHours;
    print(" time zone ${timezone}");
    int year = now.year;
    int month = now.month;
    int day = now.day;

    DateTime when = DateTime.utc(month, year, day);

    final postion = Provider.of<LocationProvider>(context, listen: false).pos;
    print(provider.pos.longitude);
    print(provider.pos.latitude);
    print(postion.altitude);
//   geo = Geocoordinate((GeocoordinateBuilder b) => b
//      ..latitude = provider.pos.latitude
//      ..longitude = provider.pos.longitude
//      ..altitude = provider.pos.altitude);
//
//
//    print(provider.pos.latitude);
//    print(provider.pos.longitude);
//    print(provider.pos.altitude);
//    final Prayers prayers = Prayers.on(date: when, settings: settings, coordinate: geo, timeZone: timezone);
//    print(prayers.imsak);
//    print(prayers.fajr);
//    print(prayers.sunrise);
//    print(prayers.dhuha);
//    print(prayers.dhuhr);
//    print(prayers.asr);
//    print(prayers.sunset);
//    print(prayers.maghrib);
//    print(prayers.isha);
//    print(prayers.midnight);
    Utils.getZilaNameFromPreference().then((demoZila){
      setState(() {

        zila=demoZila;
        print(demoZila);

        if(demoZila.trim()=='Gazipur'){


        }
        else if(demoZila.trim()=='Bagerhat'){
          latitude=23.7598952;
          longitude=90.37439346;
        }
        else if(demoZila.trim()=='Bandarban'){

          //timeString
          latitude=23.7598952;
          longitude=90.37439346;

        }
        else if(demoZila.trim()=='Dhaka'){
              latitude=23.7598952;
              longitude=90.37439346;
//          //timeString
//

        }

        else if((demoZila.trim()=='Magura')||(demoZila.trim()=='Rajbari')||(demoZila.trim()=='Pabna')){



        }else if((demoZila.trim()=='Satkhira')||(demoZila.trim()=='Kushtia')||(demoZila.trim()=='Jessore')||(demoZila.trim()=='Rangpur')||(demoZila.trim()=='Jhenaidah')){



        }else if((demoZila.trim()=='Nilphamari')||(demoZila.trim()=='Chuadanga')||(demoZila.trim()=='Khagrachari')||(demoZila.trim()=='Gaibandha')){



        }else if((demoZila.trim()=='Rajshahi')||(demoZila.trim()=='Bogra')||(demoZila.trim()=='Meherpur')||(demoZila.trim()=='Lalmonirhat')){


        }else if((demoZila.trim()=='Nawabganj')||(demoZila.trim()=='Naogaon')||(demoZila.trim()=='Natore')){



        }else if((demoZila.trim().trim()=='Dinajpur')||(demoZila.trim().trim()=='Thakurgaon')||(demoZila.trim().trim()=='Panchagarh')){



        }else if((demoZila.trim()=='Narsingdi')||(demoZila.trim()=='Narayanganj')||(demoZila.trim()=='Munshiganj')||(demoZila.trim()=='Chandpur')){



        }else if((demoZila.trim()=='Kishoreganj')||(demoZila.trim()=='Patuakhali')||(demoZila.trim()=='Bhola')||(demoZila.trim()=='Lakshmipur')){



        }else if((demoZila.trim()=='Netrakona')||(demoZila.trim()=='Comilla')||(demoZila.trim()=='Brahmanbaria')){



        }else if((demoZila.trim()=='Noakhali')||(demoZila.trim()=='Feni')||(demoZila.trim()=='Sunamganj')||(demoZila.trim()=='Habiganj')){


        }else if((demoZila.trim()=='Chittagong')){



        }else if((demoZila.trim()=='Cox\'s Bazar')||(demoZila.trim()=='Sylhet')||(demoZila.trim()=='Moulvibazar')){



        }else if((demoZila.trim()=='Khagrachari')||(demoZila.trim()=='Bandarban')||(demoZila.trim()=='Parbattya Chattagram')){



        }else{
              latitude= provider.pos.latitude;
              longitude=provider.pos.longitude;

        }
      });
    });
//
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
                       FittedBox(
                         child: Row(
                              children: <Widget>[
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      FittedBox(child: Text("পরবর্তি ওয়াক্ত",style: TextStyle(fontSize: 17,color: Colors.white),)),
                                      FutureBuilder(

                                            future: getNextPrayer(),
                                                builder: (context, AsyncSnapshot<Prayer> snapshot) {
                                                  if (snapshot.hasData) {
                                                    final prayer = snapshot.data;
                                                    print(" next prayer ${prayer.toString()}");
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

                                                      print(" next prayer ${prayer.toString()}");
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


                                                      print("next prayer ${prayer.toString()}");
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


                                                      print("next prayer ${prayer.toString()}");
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



                                                      print("next prayer ${prayer.toString()}");
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



                                                      print("next prayer ${prayer.toString()}");
                                                    }else
                                                    {
                                                      nextTime = "নফল";
                                                      print("next prayer ${prayer.toString()}");
                                                    }
                                                    return Row(
                                                      children: <Widget>[
                                                        //style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                                                        // style: TextStyle(fontSize: 20,color: Colors.white),
                                                        Text(nextTime,style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold) ),
                                                        SizedBox(width: 10,),
                                                        nextTime == "নফল" ? Container(): Text(nextPrayerTime,style: TextStyle(fontSize: 20,color: Colors.white),)


                                                      ],
                                                    );
                                                  }
                                                  else if(snapshot.hasError){
                                                    print(snapshot.error);
                                                  }else{
                                                    print ("error");
                                                  }

                                                    return Container();
                                            }

                  ),



//


                                      SizedBox(height: 10,),
                                      Text("$_timeString",style: TextStyle(fontSize: 17,color: Colors.white),),
                                      //    VerticalDivider(width: 2,thickness: 2, color: Colors.white,),
                                      SizedBox(height: 10,),

                                    ],
                                  ),

                                SizedBox(width: 20,),
                                Container(
                                  width: 2,
                                  height: 100,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 20,),
                                Column(
                                  children: <Widget>[
                                    FittedBox(child: Text("বর্তমান ওয়াক্ত",style: TextStyle(fontSize: 17,color: Colors.white),)),
                                    //style: TextStyle(color: Colors.white,fontSize: 30, fontWeight: FontWeight.bold),
                                     Container(
                                        child:FutureBuilder(
                                          future: getCurrentPrayer(),
                                          builder: (context, AsyncSnapshot<Prayer> snapshot) {
                                            if (snapshot.hasData) {
                                              final prayer = snapshot.data;
                                              print(" current prayer ${prayer.toString()}");
                                              if(prayer.toString().trim()=="Prayer.ASR"){
                                                currentTime = "আসর";
                                                print(" current prayer ${prayer.toString()}");
                                              }else if(prayer.toString().trim()=="Prayer.FAJR"){
                                                currentTime = "ফজর";
                                                print(" current prayer ${prayer.toString()}");
                                              }else if(prayer.toString().trim()=="Prayer.DHUHUR"){
                                                currentTime = "যোহর";
                                                print(" current prayer ${prayer.toString()}");
                                              }else if(prayer.toString().trim()=="Prayer.MAGHRIB"){
                                                currentTime = "মাগরিব";
                                                print(" current prayer ${prayer.toString()}");
                                              }else if(prayer.toString().trim()=="Prayer.ISHA"){
                                                currentTime = "এশা";
                                                print(" current prayer ${prayer.toString()}");
                                              }else{
                                                currentTime = "নফল";
                                                print(" current prayer ${prayer.toString()}");
                                              }
                                              return Text(currentTime, style: TextStyle(
                                                  color: Colors.white,fontSize: 30, fontWeight: FontWeight.bold
                                              ),);
                                            } else if (snapshot.hasError) {
                                              print(snapshot.hasError);
                                              return SingleChildScrollView();
                                            } else {
                                              return Text('Waiting...');
                                            }
                                          },
                                        ),
                                      ),

                                  ],
                                ),
                              ],
                            ),
                       ),


                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Image.asset("images/sunrise.png", width: 50, height:50 ,),
                                  Text("Sunrise", style: TextStyle(color: Colors.white)),
                                  Container(child: FutureBuilder(
                                    future: getTodaySuriseTime(),
                                    builder: (context, AsyncSnapshot<DateTime> snapshot) {
                                      if (snapshot.hasData) {
                                        final dateTime = snapshot.data.toLocal();
                                        print("Sunrise Time: ${dateTime}");
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
                                  Container(child: FutureBuilder(
                                    future: getTodayMagribTime(),
                                    builder: (context, AsyncSnapshot<DateTime> snapshot) {
                                      if (snapshot.hasData) {
                                        final dateTime = snapshot.data.toLocal();
                                        print("SunsetTime Time: ${dateTime}");
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
                          ),
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
                                          print("Fajar Time: ${dateTime}");
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
                                          print("Duhur Time: ${dateTime}");
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
                                          print("Asor Time: ${dateTime}");
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
                                            print("Magrib Time: ${dateTime}");
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
                                          print("Eshar Time: ${dateTime}");
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
    final adhan = AdhanFlutter.create(Coordinates(latitude, longitude), DateTime.now(), CalculationMethod.KARACHI);
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
}
