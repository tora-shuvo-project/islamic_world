import 'dart:io';

import 'package:bangla_utilities/bangla_utilities.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:searchtosu/FinalModels/prayer_time_models.dart';
import 'package:searchtosu/helpers/database_helper.dart';
import 'package:searchtosu/pages/doya_name_page.dart';
import 'package:searchtosu/pages/location_page.dart';
import 'package:searchtosu/pages/nearby_mosque_screen.dart';
import 'package:searchtosu/pages/ojifa_screen.dart';
import 'package:searchtosu/pages/quran_word_pages.dart';
import 'package:searchtosu/pages/shomoy_shuchi_page.dart';
import 'package:searchtosu/pages/sura_list_page.dart';

class HomeScreen extends StatefulWidget {

  static final route='/home';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {


  String banglaDate,arabyDate,englishDate;

  PrayerTimeModels prayerTimeModels;
  int date1;

  int fojorHour,johaurHour,asorHour,magribHour,esaHour,sunriseHour;
  String currentPrayerTime='';
  String nextPrayerName='';
  String nextPrayerTime='';
  String sunrisetoday='';
  String sunsettoday='';

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings androidInitializationSettings;
  IOSInitializationSettings iosInitializationSettings;
  InitializationSettings initializationSettings;




  Widget _appBar(){
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
        child: Container(
          height:70,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 17),
          child:
              Expanded(
                child: Container(

                  child: InkWell(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context)=>LocationPage()
                      ));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(Icons.menu,color:Color(0xff06AB00)),
                        Text("আল-কোরআন ও বিভিন্ন দোয়া ", style: TextStyle(color:Color(0xff06AB00), fontSize: 17),),
                        Row(
                          children: <Widget>[
                            Icon(Icons.location_on,color:Color(0xff06AB00),),
                            Text("|",style: TextStyle(color:Color(0xff06AB00), fontSize: 17),),
                            Text("ঢাকা",style: TextStyle(color:Color(0xff06AB00), fontSize: 17), )
                          ],
                        ),




                      ],
                    ),
                  ),
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

    initializing();

    var _today = new HijriCalendar.now();
    banglaDate=BanglaUtility.getBanglaDate(day: DateTime.now().day, month: DateTime.now().month, year: DateTime.now().year);
    arabyDate=_today.toFormat("dd MMMM,yyyy");
    englishDate=DateFormat('dd MMMM,yyyy').format(DateTime.now());


    date1 = (DateTime.now().hour);
    DatabaseHelper.getPrayerTimeModels('${DateFormat('MMM dd').format(DateTime.now())}').then((prayermodels){
      setState(() {
        prayerTimeModels=prayermodels;
        sunrisetoday=prayermodels.sunrise;
        sunsettoday=prayermodels.magrib;

        fojorHour=DateFormat("yyyy: MM: dd: hh:mm a").parse('${DateTime.now().year}: ${DateTime.now().month}: ${DateTime.now().day}: ${prayermodels.fajr}').hour;
        johaurHour=DateFormat("yyyy: MM: dd: hh:mm a").parse('${DateTime.now().year}: ${DateTime.now().month}: ${DateTime.now().day}: ${prayermodels.dhuhr}').hour;
        asorHour=DateFormat("yyyy: MM: dd: hh:mm a").parse('${DateTime.now().year}: ${DateTime.now().month}: ${DateTime.now().day}: ${prayermodels.asr}').hour;
        magribHour=DateFormat("yyyy: MM: dd: hh:mm a").parse('${DateTime.now().year}: ${DateTime.now().month}: ${DateTime.now().day}: ${prayermodels.magrib}').hour;
        esaHour=DateFormat("yyyy: MM: dd: hh:mm a").parse('${DateTime.now().year}: ${DateTime.now().month}: ${DateTime.now().day}: ${prayermodels.isha}').hour;
        sunriseHour=DateFormat("yyyy: MM: dd: hh:mm a").parse('${DateTime.now().year}: ${DateTime.now().month}: ${DateTime.now().day}: ${prayermodels.sunrise}').hour;



        if(date1>=fojorHour&&date1<sunriseHour){
          currentPrayerTime='ফজর';
          nextPrayerName='ইশরাক';
          nextPrayerTime='${prayermodels.sunrise}';

        }else if(date1>=sunriseHour&&date1<johaurHour){

          currentPrayerTime='ইশরাক';
          nextPrayerName='যহর';
          nextPrayerTime='${prayermodels.dhuhr}';

        }else if(date1>=johaurHour&&date1<asorHour){

          currentPrayerTime='যহর';
          nextPrayerName='আসর';
          nextPrayerTime='${prayermodels.asr}';

        }else if(date1>=asorHour&&date1<magribHour){

          currentPrayerTime='আসর';
          nextPrayerName='মাগরিব';
          nextPrayerTime='${prayermodels.magrib}';

        }else if(date1>=magribHour&&date1<esaHour){

          currentPrayerTime='মাগরিব';
          nextPrayerName='এশা';
          nextPrayerTime='${prayermodels.isha}';

        }else{

          currentPrayerTime='এশা';
          nextPrayerName='ফজর';
          nextPrayerTime='${prayermodels.fajr}';
        }

      });
    });
}

  Future onDidReceiveLocalNotification(int id, String title, String body, String payload) async {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(body),
      actions: <Widget>[
        CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              print("");
            },
            child: Text("Okay")),
      ],
    );
  }
  Future onSelectNotification(String payLoad) {
    if (payLoad != null) {
      print(payLoad);
    }

    // we can set navigator to navigate another screen
  }
  void initializing() async {

    androidInitializationSettings = AndroidInitializationSettings('sms');
    iosInitializationSettings = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    initializationSettings = InitializationSettings(
        androidInitializationSettings, iosInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);


  }

  void _showNotificationsAfterAppClose() async {
    await notificationAfterAppClose();
  }
  Future<void> notificationAfterAppClose() async {
    var timeDelayed = DateTime.now().add(Duration(seconds: 10));
    AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
        'second channel ID', 'second Channel title', 'second channel body',
        priority: Priority.High,
        importance: Importance.Max,
        autoCancel: false,
        ongoing: true,
        category: 'Name',
        ticker: 'test');

    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();
    NotificationDetails notificationDetails = NotificationDetails(androidNotificationDetails, iosNotificationDetails);


    if(date1>=fojorHour&&date1<sunriseHour){

      await flutterLocalNotificationsPlugin.schedule(1, 'বর্তমান ওয়াক্ত ফজর', 'শুরু হয়েছে ${prayerTimeModels.fajr}\nশেষ হবে ${prayerTimeModels.sunrise}', timeDelayed, notificationDetails, androidAllowWhileIdle: false);

    }else if(date1>=sunriseHour&&date1<johaurHour){

      await flutterLocalNotificationsPlugin.schedule(1, 'বর্তমান ওয়াক্ত ইশরাক', 'শুরু হয়েছে ${prayerTimeModels.sunrise}\nশেষ হবে ${prayerTimeModels.dhuhr}', timeDelayed, notificationDetails, androidAllowWhileIdle: false);

    }else if(date1>=johaurHour&&date1<asorHour){

      await flutterLocalNotificationsPlugin.schedule(1, 'বর্তমান ওয়াক্ত যহর', 'শুরু হয়েছে ${prayerTimeModels.dhuhr}\nশেষ হবে ${prayerTimeModels.asr}', timeDelayed, notificationDetails, androidAllowWhileIdle: false);

    }else if(date1>=asorHour&&date1<magribHour){

      await flutterLocalNotificationsPlugin.schedule(1, 'বর্তমান ওয়াক্ত আসর', 'শুরু হয়েছে ${prayerTimeModels.asr}\nশেষ হবে ${prayerTimeModels.magrib}', timeDelayed, notificationDetails, androidAllowWhileIdle: false);

    }else if(date1>=magribHour&&date1<esaHour){

      await flutterLocalNotificationsPlugin.schedule(1, 'বর্তমান ওয়াক্ত মাগরিব', 'শুরু হয়েছে ${prayerTimeModels.magrib}\nশেষ হবে ${prayerTimeModels.isha}', timeDelayed, notificationDetails, androidAllowWhileIdle: false);

    }else{

      await flutterLocalNotificationsPlugin.schedule(1, 'বর্তমান ওয়াক্ত এশা', 'শুরু হয়েছে ${prayerTimeModels.isha}\nশেষ হবে ${prayerTimeModels.fajr}', timeDelayed, notificationDetails, androidAllowWhileIdle: false);

    }



  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        _showNotificationsAfterAppClose();
        exit(0);
      },
      child: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(child: _appBar(),preferredSize: Size(MediaQuery.of(context).size.width, 120),) ,
          body: SingleChildScrollView(
            child: Container(
              color: Color(0xffEFFAFC),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              color:Color(0xff06AB00),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text("তারিখ",style: TextStyle(color:Colors.white, fontSize: 17),),
                        Text("নামাজ",style: TextStyle(color:Colors.white, fontSize: 17),),
                      ],
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(flex: 1,
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              color: Color(0xff015605),
                              width: (MediaQuery.of(context).size.width/2)-1,
                              child: Column(
                                children: <Widget>[
                                  Text("ইংরেজী",style: TextStyle(color:Colors.white, fontSize: 15),),
                                  FittedBox(child: Text(englishDate,style: TextStyle(color:Colors.white, fontSize: 15),))
                                ],
                              ),
                              //color: Color(0xff026104),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              color: Color(0xff026104),
                              width: (MediaQuery.of(context).size.width/2)-1,
                              child: Column(
                                children: <Widget>[
                                  Text("হিজরি",style: TextStyle(color:Colors.white, fontSize: 15),),
                                  FittedBox(child: Text(arabyDate,style: TextStyle(color:Colors.white, fontSize: 15),))
                                ],
                              ),
                              //color: Color(0xff026104),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              color: Color(0xff026C03),
                              width: (MediaQuery.of(context).size.width/2)-1,
                              child: Column(
                                children: <Widget>[
                                  Text("বঙ্গাব্দ",style: TextStyle(color:Colors.white, fontSize: 16),),
                                  FittedBox(child: Text(banglaDate,style: TextStyle(color:Colors.white, fontSize: 16),))
                                ],
                              ),
                              //color: Color(0xff026104),
                            ),
                          ],
                        ),
                      ),
                      Expanded(flex: 1,
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              color: Color(0xff015605),
                              width: (MediaQuery.of(context).size.width/2)-1,
                              child: Column(
                                children: <Widget>[
                                  FittedBox(child: Text("${currentPrayerTime} চলিতেছে....",style: TextStyle(color:Colors.white, fontSize: 15),)),
                                  FittedBox(child: Text("ওয়াক্ত শেষ ${nextPrayerTime}",style: TextStyle(color:Colors.white, fontSize: 15),))
                                ],
                              ),
                              //color: Color(0xff026104),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              color: Color(0xff026104),
                              width: (MediaQuery.of(context).size.width/2)-1,
                              child: Column(
                                children: <Widget>[
                                  FittedBox(child: Text("পরবর্তি নামাজ",style: TextStyle(color:Colors.white, fontSize: 15),)),
                                  FittedBox(child: Text("${nextPrayerName} ",style: TextStyle(color:Colors.white, fontSize: 15),))
                                ],
                              ),
                              //color: Color(0xff026104),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              color: Color(0xff026C03),
                              width: (MediaQuery.of(context).size.width/2)-1,
                              child: Column(
                                children: <Widget>[
                                  FittedBox(child: Text("সুর্যোদয়ঃ $sunrisetoday",style: TextStyle(color:Colors.white, fontSize: 14),)),
                                  FittedBox(child: Text("           সুর্যাস্তঃ $sunsettoday",style: TextStyle(color:Colors.white, fontSize: 14),))
                                ],
                              ),
                              //color: Color(0xff026104),
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                 Column(
                     children: <Widget>[
                       Container(
                         padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                           children: <Widget>[
                             InkWell(
                               onTap:(){
                                 Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SuraListPage()));
                               },
                               child: Card(
                                 child:Container(
                                   padding: EdgeInsets.all(6),
                                   child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.center,
                                     children: <Widget>[
                                       Image.asset("images/kuranShorif.png", height: 80,width: 80,),
                                       Text("Al Quran", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500),)
                                     ],
                                   ),
                                 ),
                               ),
                             ),
                             InkWell(
                               onTap:(){
                                 Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ShomoyShuchi()));

                               },
                               child: Card(
                                 child:Container(
                                   padding: EdgeInsets.all(6),
                                   child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.center,
                                     children: <Widget>[

                                       Image.asset("images/namjerShomoy.png", height: 80,width: 80,),
                                       Text("Namajer Waqt",style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500),)
                                     ],
                                   ),
                                 ),
                               ),
                             ),
                             InkWell(
                               onTap:(){
                                 Navigator.of(context).pushNamed(QuranWordPages.route);
                               },
                               child: Card(
                                 child:Container(
                                   padding: EdgeInsets.all(6),
                                   child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.center,
                                     children: <Widget>[
                                       Image.asset("images/shahihAfija.png", height: 80,width: 80,),
                                       Text("Quran Words",style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500),)
                                     ],
                                   ),
                                 ),
                               ),
                             ),
                           ],
                         ),
                       ),
                       Container(
                         padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                           children: <Widget>[
                             InkWell(
                               onTap:(){
                                 Navigator.of(context).push(MaterialPageRoute(
                                     builder: (context)=>OjifaScreen()
                                 ));
                               },
                               child: Card(
                                 child:Container(
                                   padding: EdgeInsets.all(6),
                                   child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.center,
                                     children: <Widget>[
                                       Image.asset("images/kuranShorif.png", height: 80,width: 80,),
                                       Text("Ojifa", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500),)
                                     ],
                                   ),
                                 ),
                               ),
                             ),
                             InkWell(
                               onTap:(){
                                 Navigator.of(context).push(MaterialPageRoute(
                                     builder: (context)=>DoyaNameScren()
                                 ));
                               },
                               child: Card(
                                 child:Container(
                                   padding: EdgeInsets.all(6),
                                   child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.center,
                                     children: <Widget>[

                                       Image.asset("images/namjerShomoy.png", height: 80,width: 80,),
                                       Text("Doya",style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500),)
                                     ],
                                   ),
                                 ),
                               ),
                             ),
                             InkWell(
                               onTap:(){
                                 Navigator.of(context).push(MaterialPageRoute(
                                   builder: (context)=>NearByMosqueScreen()
                                 ));
                               },
                               child: Card(
                                 child:Container(
                                   padding: EdgeInsets.all(6),
                                   child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.center,
                                     children: <Widget>[
                                       Image.asset("images/shahihAfija.png", height: 80,width: 80,),
                                       Text("NearBy Mosque",style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500),)
                                     ],
                                   ),
                                 ),
                               ),
                             ),
                           ],
                         ),
                       ),
                       Container(
                         padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                           children: <Widget>[
                             InkWell(
                               onTap:(){
                                 Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SuraListPage()));
                               },
                               child: Card(
                                 child:Container(
                                   padding: EdgeInsets.all(6),
                                   child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.center,
                                     children: <Widget>[
                                       Image.asset("images/kuranShorif.png", height: 80,width: 80,),
                                       Text("Al Quran", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500),)
                                     ],
                                   ),
                                 ),
                               ),
                             ),
                             InkWell(
                               onTap:(){

                               },
                               child: Card(
                                 child:Container(
                                   padding: EdgeInsets.all(6),
                                   child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.center,
                                     children: <Widget>[

                                       Image.asset("images/namjerShomoy.png", height: 80,width: 80,),
                                       Text("Namajer Waqt",style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500),)
                                     ],
                                   ),
                                 ),
                               ),
                             ),
                             InkWell(
                               onTap:(){
                                 Navigator.of(context).pushNamed(QuranWordPages.route);
                               },
                               child: Card(
                                 child:Container(
                                   padding: EdgeInsets.all(6),
                                   child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.center,
                                     children: <Widget>[
                                       Image.asset("images/shahihAfija.png", height: 80,width: 80,),
                                       Text("Quran Words",style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500),)
                                     ],
                                   ),
                                 ),
                               ),
                             ),
                           ],
                         ),
                       ),
                     ],
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
