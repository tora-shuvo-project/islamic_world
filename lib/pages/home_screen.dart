

import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:deivao_drawer/deivao_drawer.dart';
import 'package:deivao_drawer/drawer_controller.dart';
import 'package:bangla_utilities/bangla_utilities.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:searchtosu/FinalModels/prayer_time_models.dart';
import 'package:searchtosu/helpers/database_helper.dart';
import 'package:searchtosu/helpers/provider_helpers.dart';
import 'package:searchtosu/pages/blog_pages.dart';
import 'package:searchtosu/pages/calender_pages.dart';
import 'package:searchtosu/pages/comment_question_screen.dart';
import 'package:searchtosu/pages/donate_screen.dart';
import 'package:searchtosu/pages/doya_name_page.dart';
import 'package:searchtosu/pages/hadis_screen.dart';
import 'package:searchtosu/pages/kibla_screen.dart';
import 'package:searchtosu/pages/location_page.dart';
import 'package:searchtosu/pages/nearby_mosque_screen.dart';
import 'package:searchtosu/pages/niyom_models.dart';
import 'package:searchtosu/pages/ojifa_screen.dart';
import 'package:searchtosu/pages/para_wise_page.dart';
import 'package:searchtosu/pages/quran_word_pages.dart';
import 'package:searchtosu/pages/settings_page.dart';
import 'package:searchtosu/pages/shomoy_shuchi_page.dart';
import 'package:searchtosu/pages/sura_list_page.dart';
import 'package:searchtosu/pages/tasbih_page.dart';
import 'package:searchtosu/utils/utils.dart';

class HomeScreen extends StatefulWidget {

  static final route='/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {

  final drawerController = DeivaoDrawerController();

  String banglaDate,arabyDate,englishDate;
  String zilaName;

  PrayerTimeModels prayerTimeModels;
  int date1;
  bool isOpenQuran=true;

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

  LatLng _center;




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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
//                  Expanded(child: IconButton(
//                    icon:Icon(Icons.menu,color:Color(0xff06AB00)),
//                    onPressed: drawerController.toggle,
//                  )),
                  Expanded(
                    child: RotateAnimatedTextKit(
                      onTap: () {
                        print("Tap Event");
                      },
                      duration: Duration(milliseconds: 5000),
                      text: [
                        englishDate,
                        arabyDate,
                        banglaDate,],

                      isRepeatingAnimation: true,
                      textStyle: TextStyle(fontSize: 17.0,color: Colors.green),
                      textAlign: TextAlign.start,
                      // or Alignment.topLeft
                    ),
                  ),
                  //Text(englishDate,style: TextStyle(color:Color(0xff06AB00), fontSize: 17)),

                  Expanded(child: Text('Search Islam',style: TextStyle(fontSize: 18.0,color: Colors.green,fontWeight: FontWeight.bold),)),

                  Expanded(
                    child: InkWell(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context)=>LocationPage(_center)
                          )).then((_){
                            setState(() {
                              Utils.getZilaNameFromPreference().then((value){
                                zilaName=value;
                              });
                            });
                          });
                        },
                        child: FittedBox(
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.location_on,color:Color(0xff06AB00),),
                              Text("|",style: TextStyle(color:Color(0xff06AB00), fontSize: 17),),
                              Text(zilaName,style: TextStyle(color:Color(0xff06AB00), fontSize: 17), )
                            ],
                          ),
                        ),
                      ),
                  ),





                ],
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
        sunrisetoday=prayermodels.fajr_end;
        sunsettoday=prayermodels.magrib;

        fojorHour=DateFormat("yyyy: MM: dd: hh:mm a").parse('${DateTime.now().year}: ${DateTime.now().month}: ${DateTime.now().day}: ${prayermodels.fajr_start}').hour;
        johaurHour=DateFormat("yyyy: MM: dd: hh:mm a").parse('${DateTime.now().year}: ${DateTime.now().month}: ${DateTime.now().day}: ${prayermodels.dhuhr}').hour;
        asorHour=DateFormat("yyyy: MM: dd: hh:mm a").parse('${DateTime.now().year}: ${DateTime.now().month}: ${DateTime.now().day}: ${prayermodels.asr}').hour;
        magribHour=DateFormat("yyyy: MM: dd: hh:mm a").parse('${DateTime.now().year}: ${DateTime.now().month}: ${DateTime.now().day}: ${prayermodels.magrib}').hour;
        esaHour=DateFormat("yyyy: MM: dd: hh:mm a").parse('${DateTime.now().year}: ${DateTime.now().month}: ${DateTime.now().day}: ${prayermodels.isha}').hour;
        sunriseHour=DateFormat("yyyy: MM: dd: hh:mm a").parse('${DateTime.now().year}: ${DateTime.now().month}: ${DateTime.now().day}: ${prayermodels.fajr_end}').hour;



        if(date1>=fojorHour&&date1<sunriseHour){
          currentPrayerTime='ফজর';
          nextPrayerName='ইশরাক';
          nextPrayerTime='${prayermodels.fajr_end}';

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
          nextPrayerTime='${prayermodels.fajr_start}';
        }

      });
    });


    Provider.of<LocationProvider>(context,listen: false).getDeviceCurrentLocation().then((position){
      setState(() {
        _center=LatLng(position.latitude,position.longitude);
      });
    });

    Utils.getZilaNameFromPreference().then((value) {
      setState(() {
        zilaName=value;
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

      await flutterLocalNotificationsPlugin.schedule(1, 'বর্তমান ওয়াক্ত ফজর', 'শুরু হয়েছে ${prayerTimeModels.fajr_start}\nশেষ হবে ${prayerTimeModels.fajr_end}', timeDelayed, notificationDetails, androidAllowWhileIdle: false);

    }else if(date1>=sunriseHour&&date1<johaurHour){

      await flutterLocalNotificationsPlugin.schedule(1, 'বর্তমান ওয়াক্ত ইশরাক', 'শুরু হয়েছে ${prayerTimeModels.fajr_end}\nশেষ হবে ${prayerTimeModels.dhuhr}', timeDelayed, notificationDetails, androidAllowWhileIdle: false);

    }else if(date1>=johaurHour&&date1<asorHour){

      await flutterLocalNotificationsPlugin.schedule(1, 'বর্তমান ওয়াক্ত যহর', 'শুরু হয়েছে ${prayerTimeModels.dhuhr}\nশেষ হবে ${prayerTimeModels.asr}', timeDelayed, notificationDetails, androidAllowWhileIdle: false);

    }else if(date1>=asorHour&&date1<magribHour){

      await flutterLocalNotificationsPlugin.schedule(1, 'বর্তমান ওয়াক্ত আসর', 'শুরু হয়েছে ${prayerTimeModels.asr}\nশেষ হবে ${prayerTimeModels.magrib}', timeDelayed, notificationDetails, androidAllowWhileIdle: false);

    }else if(date1>=magribHour&&date1<esaHour){

      await flutterLocalNotificationsPlugin.schedule(1, 'বর্তমান ওয়াক্ত মাগরিব', 'শুরু হয়েছে ${prayerTimeModels.magrib}\nশেষ হবে ${prayerTimeModels.isha}', timeDelayed, notificationDetails, androidAllowWhileIdle: false);

    }else{

      await flutterLocalNotificationsPlugin.schedule(1, 'বর্তমান ওয়াক্ত এশা', 'শুরু হয়েছে ${prayerTimeModels.isha}\nশেষ হবে ${prayerTimeModels.fajr_start}', timeDelayed, notificationDetails, androidAllowWhileIdle: false);

    }



  }

  @override
  Widget build(BuildContext context) {
    return DeivaoDrawer(
      controller: drawerController,
      drawer: _buildDrawer(context),
      child: DefaultTabController(
        length: 9,
        child: WillPopScope(
          onWillPop: (){
            _showNotificationsAfterAppClose();
            exit(0);
          },
          child: SafeArea(
            child: Scaffold(
         appBar: PreferredSize(child: _appBar(),preferredSize: Size(MediaQuery.of(context).size.width, 120),) ,
              body: SingleChildScrollView(
                child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(colors: [
                                    const Color(0xff178723),
                                    const Color(0xff27AB4B)
                                  ])
                              ),
                              child:
                              Stack(
                                overflow: Overflow.visible,
                                    children: <Widget>[
                                      Positioned(
                                          right: -20,
                                          top: 14,
                                          child: Image.asset("images/home_mousque.jpg", height: 150, width: 150,)),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text("বর্তমান নামাজের ওয়াক্ত", style: TextStyle(color: Colors.white),),
                                          Text('${currentPrayerTime}', style: TextStyle(fontSize: 20, color: Colors.white),),
                                          Container(
                                              decoration: BoxDecoration(
                                                  gradient: LinearGradient(colors: [
                                                    const Color(0xffffffff),
                                                    const Color(0xff178723),
                                                    const Color(0xffffffff),
                                                  ]))
                                          ),
                                          Text("পরবর্তি নামাজের ওয়াক্ত", style: TextStyle(color: Colors.white),),
                                          Text('${nextPrayerName}', style: TextStyle(fontSize: 20, color: Colors.white),),
                                          Text("সূর্যদয়ঃ ${sunrisetoday} । সুর্যাস্তঃ ${sunsettoday}",style: TextStyle( color: Colors.white),)
                                        ],
                                      ),

                                    ],
                                  )

                            ),
                           Container(
                                child:Column(
                                  children: <Widget>[
                                    SizedBox(height: 20,),
                                   Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          InkWell(
                                            onTap: (){
                                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SuraListPage()));
                                            },
                                            child: Column(
                                              children: <Widget>[
                                                Card(

                                                  child: Container(
                                                    padding: EdgeInsets.all(15),
                                                      child: Image.asset("images/quran.png",height: 40, width: 40,)),
                                                ),
                                                Text("কোরআন শরীফ")
                                              ],
                                            ),
                                          ),

                                          InkWell(
                                            onTap: (){
                                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ShomoyShuchi()));
                                            },
                                            child: Column(
                                              children: <Widget>[
                                                Card(

                                                  child: Container(
                                                      padding: EdgeInsets.all(15),
                                                      child: Image.asset("images/time.png",height: 40, width: 40,)),
                                                ),
                                                Text("নামাজের সময়সূচী")
                                              ],
                                            ),
                                          ),

                                          InkWell(
                                            onTap: (){
                                              Navigator.of(context).pushNamed(QuranWordPages.route);
                                            },
                                            child: Column(
                                              children: <Widget>[
                                                Card(

                                                  child: Container(
                                                      padding: EdgeInsets.all(15),
                                                      child: Image.asset("images/word.png",height: 40, width: 40,)),
                                                ),
                                                Text("কোরআন শব্দ")
                                              ],
                                            ),
                                          ),

                                          InkWell(

                                            child: Column(
                                              children: <Widget>[
                                                Card(

                                                  child: Container(
                                                      padding: EdgeInsets.all(15),
                                                      child: Image.asset("images/live_comment.png",height: 40, width: 40,)),
                                                ),
                                                Text("জিজ্ঞাসা")
                                              ],
                                            ),
                                          )
                                        ],
                                      ),

                                    SizedBox(height: 15,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Column(
                                          children: <Widget>[
                                            Card(

                                              child: Container(
                                                  padding: EdgeInsets.all(15),
                                                  child: Image.asset("images/ojifa.png",height: 40, width: 40,)),
                                            ),
                                            Text("অজিফা")
                                          ],
                                        ),

                                        Column(
                                          children: <Widget>[
                                            Card(

                                              child: Container(
                                                  padding: EdgeInsets.all(15),
                                                  child: Image.asset("images/doya.png",height: 40, width: 40,)),
                                            ),
                                            Text("দোয়া")
                                          ],
                                        ),

                                        Column(
                                          children: <Widget>[
                                            Card(

                                              child: Container(
                                                  padding: EdgeInsets.all(15),
                                                  child: Image.asset("images/hadis.png",height: 40, width: 40,)),
                                            ),
                                            Text("হাদিস")
                                          ],
                                        ),

                                        Column(
                                          children: <Widget>[
                                            Card(

                                              child: Container(
                                                  padding: EdgeInsets.all(15),
                                                  child: Image.asset("images/niyom.png",height: 40, width: 40,)),
                                            ),
                                            Text("নিয়ম")
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 15,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Column(
                                          children: <Widget>[
                                            Card(

                                              child: Container(
                                                  padding: EdgeInsets.all(15),
                                                  child: Image.asset("images/kibla.png",height: 40, width: 40,)),
                                            ),
                                            Text("কিবলা")
                                          ],
                                        ),

                                        Column(
                                          children: <Widget>[
                                            Card(

                                              child: Container(
                                                  padding: EdgeInsets.all(15),
                                                  child: Image.asset("images/mosque.png",height: 40, width: 40,)),
                                            ),
                                            Text("কাছাকাছি মসজিদ")
                                          ],
                                        ),

                                        Column(
                                          children: <Widget>[
                                            Card(

                                              child: Container(
                                                  padding: EdgeInsets.all(15),
                                                  child: Image.asset("images/tasbih.png",height: 40, width: 40,)),
                                            ),
                                            Text("তাসবিহ")
                                          ],
                                        ),

                                        Column(
                                          children: <Widget>[
                                            Card(

                                              child: Container(
                                                  padding: EdgeInsets.all(15),
                                                  child: Image.asset("images/calendar.png",height: 40, width: 40,)),
                                            ),
                                            Text("ক্যালেন্ডার")
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 15,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Column(
                                          children: <Widget>[
                                            Card(

                                              child: Container(
                                                  padding: EdgeInsets.all(15),
                                                  child: Image.asset("images/web.png",height: 40, width: 40,)),
                                            ),
                                            Text("ব্লগ")
                                          ],
                                        ),

                                        Column(
                                          children: <Widget>[

                                          ],
                                        ),

                                        Column(
                                          children: <Widget>[
                                          ],
                                        ),

                                        Column(
                                          children: <Widget>[

                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 15,),
                                  ],
                                )
                              ),
                            
                          ],
                        ),
                      ),
              ),
//                child: Container(
//                  color: Color(0xffEFFAFC),
//                  child: Column(
//                    children: <Widget>[
//                      Container(
//                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                        color:Color(0xff06AB00),
//                        child: Row(
//                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                          children: <Widget>[
//                            Text("তারিখ",style: TextStyle(color:Colors.white, fontSize: 17),),
//                            Text("নামাজ",style: TextStyle(color:Colors.white, fontSize: 17),),
//                          ],
//                        ),
//                      ),
//                      Row(
//                        children: <Widget>[
//                          Expanded(flex: 1,
//                            child: Column(
//                              children: <Widget>[
//                                Container(
//                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                                  color: Color(0xff015605),
//                                  width: (MediaQuery.of(context).size.width/2)-1,
//                                  child: Column(
//                                    children: <Widget>[
//                                      Text("ইংরেজী",style: TextStyle(color:Colors.white, fontSize: 15),),
//                                      FittedBox(child: Text(englishDate,style: TextStyle(color:Colors.white, fontSize: 15),))
//                                    ],
//                                  ),
//                                  //color: Color(0xff026104),
//                                ),
//                                Container(
//                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                                  color: Color(0xff026104),
//                                  width: (MediaQuery.of(context).size.width/2)-1,
//                                  child: Column(
//                                    children: <Widget>[
//                                      Text("হিজরি",style: TextStyle(color:Colors.white, fontSize: 15),),
//                                      FittedBox(child: Text(arabyDate,style: TextStyle(color:Colors.white, fontSize: 15),))
//                                    ],
//                                  ),
//                                  //color: Color(0xff026104),
//                                ),
//                                Container(
//                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                                  color: Color(0xff026C03),
//                                  width: (MediaQuery.of(context).size.width/2)-1,
//                                  child: Column(
//                                    children: <Widget>[
//                                      Text("বঙ্গাব্দ",style: TextStyle(color:Colors.white, fontSize: 16),),
//                                      FittedBox(child: Text(banglaDate,style: TextStyle(color:Colors.white, fontSize: 16),))
//                                    ],
//                                  ),
//                                  //color: Color(0xff026104),
//                                ),
//                              ],
//                            ),
//                          ),
//                          Expanded(flex: 1,
//                            child: Column(
//                              children: <Widget>[
//                                Container(
//                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                                  color: Color(0xff015605),
//                                  width: (MediaQuery.of(context).size.width/2)-1,
//                                  child: Column(
//                                    children: <Widget>[
//                                      FittedBox(child: Text("${currentPrayerTime} চলিতেছে....",style: TextStyle(color:Colors.white, fontSize: 15),)),
//                                      FittedBox(child: Text("ওয়াক্ত শেষ ${nextPrayerTime}",style: TextStyle(color:Colors.white, fontSize: 15),))
//                                    ],
//                                  ),
//                                  //color: Color(0xff026104),
//                                ),
//                                Container(
//                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                                  color: Color(0xff026104),
//                                  width: (MediaQuery.of(context).size.width/2)-1,
//                                  child: Column(
//                                    children: <Widget>[
//                                      FittedBox(child: Text("পরবর্তি নামাজ",style: TextStyle(color:Colors.white, fontSize: 15),)),
//                                      FittedBox(child: Text("${nextPrayerName} ",style: TextStyle(color:Colors.white, fontSize: 15),))
//                                    ],
//                                  ),
//                                  //color: Color(0xff026104),
//                                ),
//                                Container(
//                                  alignment: Alignment.centerLeft,
//                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                                  color: Color(0xff026C03),
//                                  width: (MediaQuery.of(context).size.width/2)-1,
//                                  child: Column(
//                                    children: <Widget>[
//                                      FittedBox(child: Text("সুর্যোদয়ঃ $sunrisetoday",style: TextStyle(color:Colors.white, fontSize: 14),)),
//                                      FittedBox(child: Text("           সুর্যাস্তঃ $sunsettoday",style: TextStyle(color:Colors.white, fontSize: 14),))
//                                    ],
//                                  ),
//                                  //color: Color(0xff026104),
//                                ),
//
//                              ],
//                            ),
//                          ),
//                        ],
//                      ),
//                      Column(
//                        children: <Widget>[
//                          Container(
//                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                            child: Row(
//                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                              children: <Widget>[
//                                InkWell(
//                                  onTap:(){
//                                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SuraListPage()));
//                                  },
//                                  child: Card(
//                                    child:Container(
//                                      padding: EdgeInsets.all(6),
//                                      child: Column(
//                                        crossAxisAlignment: CrossAxisAlignment.center,
//                                        children: <Widget>[
//                                          Image.asset("images/kuranShorif.png", height: 80,width: 80,),
//                                          Text("আল কুরআন", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500),)
//                                        ],
//                                      ),
//                                    ),
//                                  ),
//                                ),
//                                InkWell(
//                                  onTap:(){
//                                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ShomoyShuchi()));
//
//                                  },
//                                  child: Card(
//                                    child:Container(
//                                      padding: EdgeInsets.all(6),
//                                      child: Column(
//                                        crossAxisAlignment: CrossAxisAlignment.center,
//                                        children: <Widget>[
//
//                                          Image.asset("images/namjerShomoy.png", height: 80,width: 80,),
//                                          Text("নামাজের সময়সূচি",style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500),)
//                                        ],
//                                      ),
//                                    ),
//                                  ),
//                                ),
//                                InkWell(
//                                  onTap:(){
//                                    Navigator.of(context).pushNamed(QuranWordPages.route);
//                                  },
//                                  child: Card(
//                                    child:Container(
//                                      padding: EdgeInsets.all(6),
//                                      child: Column(
//                                        crossAxisAlignment: CrossAxisAlignment.center,
//                                        children: <Widget>[
//                                          Image.asset("images/shahihAfija.png", height: 80,width: 80,),
//                                          Text("কুরআনের শব্দ",style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500),)
//                                        ],
//                                      ),
//                                    ),
//                                  ),
//                                ),
//                              ],
//                            ),
//                          ),
//                          Container(
//                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                            child: Row(
//                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                              children: <Widget>[
//                                InkWell(
//                                  onTap:(){
//                                    Navigator.of(context).push(MaterialPageRoute(
//                                        builder: (context)=>OjifaScreen()
//                                    ));
//                                  },
//                                  child: Card(
//                                    child:Container(
//                                      padding: EdgeInsets.all(6),
//                                      child: Column(
//                                        crossAxisAlignment: CrossAxisAlignment.center,
//                                        children: <Widget>[
//                                          Image.asset("images/kuranShorif.png", height: 80,width: 80,),
//                                          Text("ওজিফা", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500),)
//                                        ],
//                                      ),
//                                    ),
//                                  ),
//                                ),
//                                InkWell(
//                                  onTap:(){
//                                    Navigator.of(context).push(MaterialPageRoute(
//                                        builder: (context)=>DoyaNameScren()
//                                    ));
//                                  },
//                                  child: Card(
//                                    child:Container(
//                                      padding: EdgeInsets.all(6),
//                                      child: Column(
//                                        crossAxisAlignment: CrossAxisAlignment.center,
//                                        children: <Widget>[
//
//                                          Image.asset("images/namjerShomoy.png", height: 80,width: 80,),
//                                          Text("দোয়া",style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500),)
//                                        ],
//                                      ),
//                                    ),
//                                  ),
//                                ),
//                                InkWell(
//                                  onTap:(){
//                                    Navigator.of(context).push(MaterialPageRoute(
//                                        builder: (context)=>NearByMosqueScreen()
//                                    ));
//                                  },
//                                  child: Card(
//                                    child:Container(
//                                      padding: EdgeInsets.all(6),
//                                      child: Column(
//                                        crossAxisAlignment: CrossAxisAlignment.center,
//                                        children: <Widget>[
//                                          Image.asset("images/shahihAfija.png", height: 80,width: 80,),
//                                          Text("NearBy Mosque",style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500),)
//                                        ],
//                                      ),
//                                    ),
//                                  ),
//                                ),
//                              ],
//                            ),
//                          ),
//                          Container(
//                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                            child: Row(
//                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                              children: <Widget>[
//                                InkWell(
//                                  onTap:(){
//                                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>KiblaScreen()));
//                                  },
//                                  child: Card(
//                                    child:Container(
//                                      padding: EdgeInsets.all(6),
//                                      child: Column(
//                                        crossAxisAlignment: CrossAxisAlignment.center,
//                                        children: <Widget>[
//                                          Image.asset("images/kuranShorif.png", height: 80,width: 80,),
//                                          Text("কিবলা", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500),)
//                                        ],
//                                      ),
//                                    ),
//                                  ),
//                                ),
//                                InkWell(
//                                  onTap:(){
//                                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>TasbihScreen()));
//
//                                  },
//                                  child: Card(
//                                    child:Container(
//                                      padding: EdgeInsets.all(6),
//                                      child: Column(
//                                        crossAxisAlignment: CrossAxisAlignment.center,
//                                        children: <Widget>[
//
//                                          Image.asset("images/namjerShomoy.png", height: 80,width: 80,),
//                                          Text("তাসবিহ",style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500),)
//                                        ],
//                                      ),
//                                    ),
//                                  ),
//                                ),
//                                InkWell(
//                                  onTap:(){
//                                    Navigator.of(context).push(MaterialPageRoute(
//                                        builder: (context)=>CalenderScreen()
//                                    ));
//                                  },
//                                  child: Card(
//                                    child:Container(
//                                      padding: EdgeInsets.all(6),
//                                      child: Column(
//                                        crossAxisAlignment: CrossAxisAlignment.center,
//                                        children: <Widget>[
//                                          Image.asset("images/shahihAfija.png", height: 80,width: 80,),
//                                          Text("Calender",style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500),)
//                                        ],
//                                      ),
//                                    ),
//                                  ),
//                                ),
//                              ],
//                            ),
//                          ),
//                          Container(
//                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                            child: Row(
//                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                              children: <Widget>[
//                                InkWell(
//                                  onTap:(){
//                                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HadisScreen()));
//                                  },
//                                  child: Card(
//                                    child:Container(
//                                      padding: EdgeInsets.all(6),
//                                      child: Column(
//                                        crossAxisAlignment: CrossAxisAlignment.center,
//                                        children: <Widget>[
//                                          Image.asset("images/kuranShorif.png", height: 80,width: 80,),
//                                          Text("হাদিস", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500),)
//                                        ],
//                                      ),
//                                    ),
//                                  ),
//                                ),
//                                InkWell(
//                                  onTap:(){
//                                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>NiyomScreen()));
//
//                                  },
//                                  child: Card(
//                                    child:Container(
//                                      padding: EdgeInsets.all(6),
//                                      child: Column(
//                                        crossAxisAlignment: CrossAxisAlignment.center,
//                                        children: <Widget>[
//
//                                          Image.asset("images/namjerShomoy.png", height: 80,width: 80,),
//                                          Text("নিয়ম কানুন",style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500),)
//                                        ],
//                                      ),
//                                    ),
//                                  ),
//                                ),
//                                InkWell(
//                                  onTap:(){
//                                    Navigator.of(context).push(MaterialPageRoute(
//                                        builder: (context)=>CommentQuestionScreen()
//                                    ));
//                                  },
//                                  child: Card(
//                                    child:Container(
//                                      padding: EdgeInsets.all(6),
//                                      child: Column(
//                                        crossAxisAlignment: CrossAxisAlignment.center,
//                                        children: <Widget>[
//                                          Image.asset("images/shahihAfija.png", height: 80,width: 80,),
//                                          Text("লাইভ কমেন্ট",style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500),)
//                                        ],
//                                      ),
//                                    ),
//                                  ),
//                                ),
//                              ],
//                            ),
//                          ),
//                          Container(
//                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                            child: Row(
//                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                              children: <Widget>[
//                                InkWell(
//                                  onTap:(){
//                                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>BlogPages()));
//                                  },
//                                  child: Card(
//                                    child:Container(
//                                      padding: EdgeInsets.all(6),
//                                      child: Column(
//                                        crossAxisAlignment: CrossAxisAlignment.center,
//                                        children: <Widget>[
//                                          Image.asset("images/kuranShorif.png", height: 80,width: 80,),
//                                          Text("ইসলামিক ওয়েব", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500),)
//                                        ],
//                                      ),
//                                    ),
//                                  ),
//                                ),
//                                InkWell(
//                                  onTap:(){
//                                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>NiyomScreen()));
//
//                                  },
//                                  child: Card(
//                                    child:Container(
//                                      padding: EdgeInsets.all(6),
//                                      child: Column(
//                                        crossAxisAlignment: CrossAxisAlignment.center,
//                                        children: <Widget>[
//
//                                          Image.asset("images/namjerShomoy.png", height: 80,width: 80,),
//                                          Text("নিয়ম কানুন",style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500),)
//                                        ],
//                                      ),
//                                    ),
//                                  ),
//                                ),
//                                InkWell(
//                                  onTap:(){
//                                    Navigator.of(context).push(MaterialPageRoute(
//                                        builder: (context)=>CommentQuestionScreen()
//                                    ));
//                                  },
//                                  child: Card(
//                                    child:Container(
//                                      padding: EdgeInsets.all(6),
//                                      child: Column(
//                                        crossAxisAlignment: CrossAxisAlignment.center,
//                                        children: <Widget>[
//                                          Image.asset("images/shahihAfija.png", height: 80,width: 80,),
//                                          Text("লাইভ কমেন্ট",style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500),)
//                                        ],
//                                      ),
//                                    ),
//                                  ),
//                                ),
//                              ],
//                            ),
//                          ),
//                        ],
//                      ),
//                    ],
//                  ),
//                ),

            ),
          ),
        ),
      ),
    );

  }

  ListView _buildDrawer(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(0),
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 50, bottom: 20),
          color: Colors.green,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ClipOval(
                child: Image.asset(
                  "images/mosque.png",
                  width: 70,
                  height: 70,
                ),
              ),
              SizedBox(height: 15),
              Text(
                'Bd Islamic World',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ],
          ),
        ),
        Container(
          color: Colors.green.withOpacity(.5),
          child: ListTile(
              onTap: (){
                Navigator.of(context).pushReplacementNamed(HomeScreen.route);
              },
    leading: CircleAvatar(
    backgroundColor: Colors.transparent,
    child: Image.asset('images/home.png',width: 25,),
    ),
              title: Text("হোম")),
        ),
        Container(
          height: 1,
          color: Colors.green.withOpacity(.4),
        ),
        Container(
          color: Colors.green.withOpacity(.5),
          child: ListTile(
              onTap: (){

              },
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Image.asset(('images/quran.png'),width: 25,),
              ),
            title: Text("সিলেক্ট কুরআন"),
              subtitle: isOpenQuran?Container():Column(
                children: <Widget>[
                  Container(
                    child: FlatButton(
                      child: Text('সূরা ক্রমে',style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500
                      ),),
                      onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context)=>SuraListPage()
                        ));
                      },
                    ),
                    color: Colors.green.withOpacity(.2),
                    width: double.infinity,
                  ),
                  Divider(color: Colors.white,),
                  Container(
                    child: FlatButton(
                      child: Text('পারা ক্রমে',style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500
                      ),),
                      onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context)=>ParaWiseListPage()
                        ));
                      },
                    ),
                    color: Colors.green.withOpacity(.2),
                    width: double.infinity,
                  ),
                ],
              ),
            trailing: IconButton(
              icon: Icon(Icons.keyboard_arrow_down,color: Colors.white,),
              onPressed: (){
                setState(() {
                  isOpenQuran=!isOpenQuran;
                });
              },
            )),
        ),
        Container(
          height: 1,
          color: Colors.green.withOpacity(.4),
        ),
        Container(
          color: Colors.green.withOpacity(.5),
          child: ListTile(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context)=>SettingsPage()
                ));
              },
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Image.asset(('images/settings.png'),width: 25,),
              ),
              title: Text("সেটিংস")),
        ),
        Container(
          height: 1,
          color: Colors.green.withOpacity(.4),
        ),
        Container(
          color: Colors.green.withOpacity(.5),
          child: ListTile(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context)=>ShomoyShuchi()
                ));
              },
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Image.asset(('images/time.png'),width: 25,),
              ),
              title: Text("নামাজের সময়সূচি")),
        ),
        Container(
          height: 1,
          color: Colors.green.withOpacity(.4),
        ),
        Container(
          color: Colors.green.withOpacity(.5),
          child: ListTile(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context)=>QuranWordPages()
                ));
              },
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Image.asset(('images/word.png'),width: 25,),
              ), title: Text("কুরআনের শব্দ")),
        ),
        Container(
          height: 1,
          color: Colors.green.withOpacity(.4),
        ),
        Container(
          color: Colors.green.withOpacity(.5),
          child: ListTile(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context)=>OjifaScreen()
                ));
              },
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Image.asset(('images/ojifa.png'),width: 25,),
              ), title: Text("অজিফা")),
        ),
        Container(
          height: 1,
          color: Colors.green.withOpacity(.4),
        ),
        Container(
          color: Colors.green.withOpacity(.5),
          child: ListTile(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context)=>DoyaNameScren()
                ));
              },
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Image.asset(('images/doya.png'),width: 25,),
              ), title: Text("দোয়া")),
        ),
        Container(
          height: 1,
          color: Colors.green.withOpacity(.4),
        ),
        Container(
          color: Colors.green.withOpacity(.5),
          child: ListTile(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context)=>NearByMosqueScreen()
                ));
              },
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Image.asset(('images/mosque (3).png'),width: 25,),
              ), title: Text("চারপাশের মসজিদ")),
        ),
        Container(
          height: 1,
          color: Colors.green.withOpacity(.4),
        ),
        Container(
          color: Colors.green.withOpacity(.5),
          child: ListTile(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context)=>KiblaScreen()
                ));
              },
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Image.asset(('images/kibla.png'),width: 25,),
              ), title: Text("কিবলা")),
        ),
        Container(
          height: 1,
          color: Colors.green.withOpacity(.4),
        ),
        Container(
          color: Colors.green.withOpacity(.5),
          child: ListTile(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context)=>TasbihScreen()
                ));
              },
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Image.asset(('images/tasbih.png'),width: 25,),
              ), title: Text("তাসবিহ")),
        ),
        Container(
          height: 1,
          color: Colors.green.withOpacity(.4),
        ),
        Container(
          color: Colors.green.withOpacity(.5),
          child: ListTile(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context)=>CalenderScreen()
                ));
              },
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Image.asset(('images/calendar.png'),width: 25,),
              ), title: Text("ইসলামিক ক্যালেন্ডার")),
        ),
        Container(
          height: 1,
          color: Colors.green.withOpacity(.4),
        ),
        Container(
          color: Colors.green.withOpacity(.5),
          child: ListTile(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context)=>HadisScreen()
                ));
              },
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Image.asset(('images/hadis.png'),width: 25,),
              ), title: Text("কিছু হাদিস")),
        ),
        Container(
          height: 1,
          color: Colors.green.withOpacity(.4),
        ),
        Container(
          color: Colors.green.withOpacity(.5),
          child: ListTile(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context)=>NiyomScreen()
                ));
              },
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Image.asset(('images/niyom.png'),width: 25,),
              ), title: Text("নিয়ম কানুন")),
        ),
        Container(
          height: 1,
          color: Colors.green.withOpacity(.4),
        ),
        Container(
          color: Colors.green.withOpacity(.5),
          child: ListTile(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context)=>CommentQuestionScreen()
                ));
              },
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Image.asset(('images/live_comment.png'),width: 25,),
              ), title: Text("লাইভ কমেন্ট")),
        ),
        Container(
          height: 1,
          color: Colors.green.withOpacity(.4),
        ),
        Container(
          color: Colors.green.withOpacity(.5),
          child: ListTile(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context)=>BlogPages()
                ));
              },
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Image.asset(('images/web.png'),width: 25,),
              ), title: Text("ইসলামিক ওয়েব সাইট")),
        ),
        Container(
          height: 1,
          color: Colors.green.withOpacity(.4),
        ),
        Container(
          color: Colors.green.withOpacity(.5),
          child: ListTile(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context)=>DonateScreen()
                ));
              },
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Image.asset(('images/donate.png'),width: 25,),
              ), title: Text("দান করুন")),
        ),
        Container(
          height: 1,
          color: Colors.green.withOpacity(.4),
        ),
        Container(
          color: Colors.green.withOpacity(.5),
          child: ListTile(
              onTap: (){

              },
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Image.asset(('images/developer.png'),width: 25,),
              ), title: Text("আমাদের সম্পর্কে জানুন")),
        ),
        Container(
          height: 200,
          color: Colors.green.withOpacity(.4),
        ),
      ],
    );
  }

}