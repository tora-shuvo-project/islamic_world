

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';

import 'package:searchtosu/FinalModels/prayer_time_models.dart';
import 'package:searchtosu/helpers/database_helper.dart';

class ShomoyShuchi extends StatefulWidget {
  static final route='/shomoyShuchi';
  @override
  _ShomoyShuchiState createState() => _ShomoyShuchiState();
}



class _ShomoyShuchiState extends State<ShomoyShuchi> {

  PrayerTimeModels prayerTimeModels;
  String dayName,arabyDate,englishDate;

  int fojorHour,johaurHour,asorHour,magribHour,esaHour,sunriseHour,israkHour,aoyabinHour;
  int fojorMinute,johaurMinute,asorMinute,magribMinute,esaMinute,sunriseMinute,israkMinute,aoyabinMinute;
  String currentPrayerTime='';
  String nextPrayerName='';
  String nextPrayerTime='';
  String _timeString;

  String sunrisetoday='';
  String sunsettoday='';
  String israk='';
  String aoyabin='';
  String fajartoday='';
  String dohortoday='';
  String asortoday='';
  String magribtoday='';
  String esatoday='';


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
                    Row(
                      children: <Widget>[
                        Icon(Icons.location_on, color: Colors.white,),
                        Text("|", style: TextStyle(color: Colors.white, fontSize: 17),),
                        Text("DHAKA", style: TextStyle(color: Colors.white, fontSize: 17),),
                      ],
                    )
                  ],
                ),
              ),

        ),

      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    var _today = new HijriCalendar.now();
    arabyDate=_today.toFormat("dd MMMM,yyyy");
    englishDate=DateFormat('dd MMMM,yyyy').format(DateTime.now());
    dayName=DateFormat('EEEE').format(DateTime.now());

    int date1 = (DateTime.now().hour);
    DateTime dateTime=DateTime.now();
    DatabaseHelper.getPrayerTimeModels('${DateFormat('MMM dd').format(DateTime.now())}').then((prayermodels){
      setState(() {
        prayerTimeModels=prayermodels;

        sunrisetoday=prayermodels.fajr_end;
        sunsettoday=prayermodels.magrib;
        fajartoday=prayermodels.fajr_start;
        aoyabin=prayermodels.aoyabin;
        dohortoday=prayermodels.dhuhr;
        asortoday=prayermodels.asr;
        magribtoday=prayermodels.magrib;
        aoyabin=prayermodels.aoyabin;
        esatoday=prayermodels.isha;

        fojorHour=DateFormat("yyyy: MM: dd: hh:mm a").parse('${DateTime.now().year}: ${DateTime.now().month}: ${DateTime.now().day}: ${prayermodels.fajr_start}').hour;
        israkHour=DateFormat("yyyy: MM: dd: hh:mm a").parse('${DateTime.now().year}: ${DateTime.now().month}: ${DateTime.now().day}: ${prayermodels.israk}').hour;
        johaurHour=DateFormat("yyyy: MM: dd: hh:mm a").parse('${DateTime.now().year}: ${DateTime.now().month}: ${DateTime.now().day}: ${prayermodels.dhuhr}').hour;
        asorHour=DateFormat("yyyy: MM: dd: hh:mm a").parse('${DateTime.now().year}: ${DateTime.now().month}: ${DateTime.now().day}: ${prayermodels.asr}').hour;
        magribHour=DateFormat("yyyy: MM: dd: hh:mm a").parse('${DateTime.now().year}: ${DateTime.now().month}: ${DateTime.now().day}: ${prayermodels.magrib}').hour;
        aoyabinHour=DateFormat("yyyy: MM: dd: hh:mm a").parse('${DateTime.now().year}: ${DateTime.now().month}: ${DateTime.now().day}: ${prayermodels.aoyabin}').hour;
        esaHour=DateFormat("yyyy: MM: dd: hh:mm a").parse('${DateTime.now().year}: ${DateTime.now().month}: ${DateTime.now().day}: ${prayermodels.isha}').hour;
        sunriseHour=DateFormat("yyyy: MM: dd: hh:mm a").parse('${DateTime.now().year}: ${DateTime.now().month}: ${DateTime.now().day}: ${prayermodels.fajr_end}').hour;

        fojorMinute=DateFormat("yyyy: MM: dd: hh:mm a").parse('${DateTime.now().year}: ${DateTime.now().month}: ${DateTime.now().day}: ${prayermodels.fajr_start}').minute;
        israkMinute=DateFormat("yyyy: MM: dd: hh:mm a").parse('${DateTime.now().year}: ${DateTime.now().month}: ${DateTime.now().day}: ${prayermodels.israk}').minute;
        johaurMinute=DateFormat("yyyy: MM: dd: hh:mm a").parse('${DateTime.now().year}: ${DateTime.now().month}: ${DateTime.now().day}: ${prayermodels.dhuhr}').minute;
        asorMinute=DateFormat("yyyy: MM: dd: hh:mm a").parse('${DateTime.now().year}: ${DateTime.now().month}: ${DateTime.now().day}: ${prayermodels.asr}').minute;
        magribMinute=DateFormat("yyyy: MM: dd: hh:mm a").parse('${DateTime.now().year}: ${DateTime.now().month}: ${DateTime.now().day}: ${prayermodels.magrib}').minute;
        aoyabinMinute=DateFormat("yyyy: MM: dd: hh:mm a").parse('${DateTime.now().year}: ${DateTime.now().month}: ${DateTime.now().day}: ${prayermodels.aoyabin}').minute;
        esaMinute=DateFormat("yyyy: MM: dd: hh:mm a").parse('${DateTime.now().year}: ${DateTime.now().month}: ${DateTime.now().day}: ${prayermodels.isha}').minute;
        sunriseMinute=DateFormat("yyyy: MM: dd: hh:mm a").parse('${DateTime.now().year}: ${DateTime.now().month}: ${DateTime.now().day}: ${prayermodels.fajr_end}').minute;


        _timeString = "${DateTime.now().hour} ঘন্টা ${DateTime.now().minute} মিনিট ${DateTime.now().second} পর";

        print('$date1');
        print('$fojorHour');
        print('$johaurHour');
        print('$asorHour');
        print('$magribHour');
        print('$esaHour');

        if(date1>=fojorHour&&date1<sunriseHour){

            print('Fojor');
            currentPrayerTime='ফজর';
            nextPrayerName='নামাজের জন্য হারাম সময়';
            nextPrayerTime='${prayermodels.fajr_end}';
            Timer.periodic(Duration(seconds:1), (Timer t)=>_getCurrentTime(dateTime.year,dateTime.month,dateTime.day,sunriseHour,sunriseMinute,esaHour,fojorHour));

        }else if(date1>=sunriseHour&&date1<israkHour){

            print('Israk Time');
            currentPrayerTime='নামাজের জন্য হারাম সময়';
            nextPrayerName='ইশরাক';
            nextPrayerTime='${prayermodels.dhuhr}';
            Timer.periodic(Duration(seconds:1), (Timer t)=>_getCurrentTime(dateTime.year,dateTime.month,dateTime.day,israkHour,israkMinute,esaHour,fojorHour));

        }else if(date1>=israkHour&&date1<johaurHour){

            print('Israk Time');
            currentPrayerTime='ইশরাক';
            nextPrayerName='যহর';
            nextPrayerTime='${prayermodels.dhuhr}';
            Timer.periodic(Duration(seconds:1), (Timer t)=>_getCurrentTime(dateTime.year,dateTime.month,dateTime.day,johaurHour,johaurMinute,esaHour,fojorHour));

        }else if(date1>=johaurHour&&date1<asorHour){

            print('johar');
            currentPrayerTime='যহর';
            nextPrayerName='আসর';
            nextPrayerTime='${prayermodels.asr}';
            Timer.periodic(Duration(seconds:1), (Timer t)=>_getCurrentTime(dateTime.year,dateTime.month,dateTime.day,asorHour,asorMinute,esaHour,fojorHour));

        }else if(date1>=asorHour&&date1<magribHour){

            print('asor');
            currentPrayerTime='আসর';
            nextPrayerName='মাগরিব';
            nextPrayerTime='${prayermodels.magrib}';
            Timer.periodic(Duration(seconds:1), (Timer t)=>_getCurrentTime(dateTime.year,dateTime.month,dateTime.day,magribHour,magribMinute,esaHour,fojorHour));


        }else if(date1>=magribHour&&date1<aoyabinHour){

            print('Magrib');
            currentPrayerTime='মাগরিব';
            nextPrayerName='আওয়াবিন';
            nextPrayerTime='${prayermodels.isha}';
            Timer.periodic(Duration(seconds:1), (Timer t)=>_getCurrentTime(dateTime.year,dateTime.month,dateTime.day,aoyabinHour,aoyabinMinute,esaHour,fojorHour));


        }else if(date1>=aoyabinHour&&date1<esaHour){

            print('Magrib');
            currentPrayerTime='আওয়াবিন';
            nextPrayerName='এশা';
            nextPrayerTime='${prayermodels.isha}';
            Timer.periodic(Duration(seconds:1), (Timer t)=>_getCurrentTime(dateTime.year,dateTime.month,dateTime.day,esaHour,esaMinute,esaHour,fojorHour));


        }else{

            print('Esa');
            currentPrayerTime='এশা';
            nextPrayerName='ফজর';
            nextPrayerTime='${prayermodels.fajr_start}';

            int fjrHr=fojorHour;
              Timer.periodic(Duration(seconds:1), (Timer t)=>_getCurrentTime(dateTime.year,dateTime.month,dateTime.day,fjrHr,fojorMinute,esaHour,fojorHour));

              print('${fojorHour+24}');
            }

      });
    });
  }

  //format(Duration d) => d.toString().split('.').first.padLeft(8, "0");

  void _getCurrentTime(int year, int month, int day, int Hour, int Minute,int esaHour,int fojorHour)  {

      print(esaHour.toString());
      print(fojorHour.toString());

    setState(() {
      final birthday = DateTime(year, month, day,Hour,Minute);
      var result = birthday.minute-DateTime.now().minute;
      print('${birthday.minute} -${DateTime.now().minute} =${result.abs()}');

      if(Hour>esaHour){
        if(Minute>birthday.minute){
          _timeString = "${(birthday.hour+24)-DateTime.now().hour} ঘন্টা "
              "${(((birthday.minute+60)-DateTime.now().minute)-1).abs()} মিনিট "
              "${60-DateTime.now().second} পর";
        }else{
          _timeString = "${(birthday.hour+24)-DateTime.now().hour} ঘন্টা "
              "${(((birthday.minute)-DateTime.now().minute)-1).abs()} মিনিট "
              "${60-DateTime.now().second} পর";
        }
      }else{
        if(Minute>birthday.minute){
          _timeString = "${birthday.hour-DateTime.now().hour} ঘন্টা "
              "${(((birthday.minute+60)-DateTime.now().minute)-1).abs()} মিনিট "
              "${60-DateTime.now().second} পর";
        }else{
          _timeString = "${birthday.hour-DateTime.now().hour} ঘন্টা "
              "${(((birthday.minute)-DateTime.now().minute)-1).abs()} মিনিট "
              "${60-DateTime.now().second} পর";
        }

      }

    });
  }


  @override
  Widget build(BuildContext context) {


    return SafeArea(
      child: Scaffold(
        appBar:PreferredSize(child: _appBar(),preferredSize: Size(MediaQuery.of(context).size.width, 120),) ,
        body: Stack(
          children: <Widget>[
            Container(
              color: Colors.green,
              height: 280,
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              width: MediaQuery.of(context).size.width,
              child: Container(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text("পরবর্তি ওয়াক্ত",style: TextStyle(fontSize: 17,color: Colors.white),),
                                Row(
                                  children: <Widget>[
                                    Text(nextPrayerName, style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),),
                                    SizedBox(width: 10,),
                                    Text(nextPrayerTime,style: TextStyle(fontSize: 20,color: Colors.white),),


                                  ],
                                ),
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
                            Text("বর্তমান ওয়াক্ত",style: TextStyle(fontSize: 17,color: Colors.white),),
                            Text(currentPrayerTime, style: TextStyle(color: Colors.white,fontSize: 30, fontWeight: FontWeight.bold),)
                          ],
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
                            Text(sunrisetoday,style: TextStyle(color: Colors.white))

                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Image.asset("images/sunset.png", width: 50, height:50 ,),
                            Text("Sunset",style: TextStyle(color: Colors.white)),
                            Text(sunsettoday,style: TextStyle(color: Colors.white))

                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 210,left: 10,right: 10),
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
                          Text("Fazar"),
                          Row(
                            children: <Widget>[
                              Text(fajartoday),
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
                          Text("Dhuhr"),
                          Row(
                            children: <Widget>[
                              Text(dohortoday),
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
                          Text("Asr"),
                          Row(
                            children: <Widget>[
                              Text(asortoday),
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
                          Text("Magrib"),
                          Row(
                            children: <Widget>[
                              Text(magribtoday),
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
                          Text("Aoyabin"),
                          Row(
                            children: <Widget>[
                              Text(aoyabin),
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
                          Text("Isha"),
                          Row(
                            children: <Widget>[
                              Text(esatoday),
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

    );
  }
}
