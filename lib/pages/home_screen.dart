

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
import 'package:searchtosu/Widgets/custome_dialog.dart';
import 'package:searchtosu/helpers/database_helper.dart';
import 'package:searchtosu/helpers/provider_helpers.dart';
import 'package:searchtosu/pages/about_pages.dart';
import 'package:searchtosu/pages/blog_pages.dart';
import 'package:searchtosu/pages/calender_pages.dart';
import 'package:searchtosu/pages/comment_question_screen.dart';
import 'package:searchtosu/pages/donate_screen.dart';
import 'package:searchtosu/pages/doya_name_page.dart';
import 'package:searchtosu/pages/hadis_screen.dart';
import 'package:searchtosu/pages/kibla_screen.dart';
import 'package:searchtosu/pages/labbayekallahumma_screen.dart';
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
  String banglaDate1,arabyDate1,englishDate1;
  String zilaName;

  PrayerTimeModels prayerTimeModels;
  int date1;
  bool isOpenQuran=true;

  int fojorHour_start,johaurHour,asorHour,magribHour,esaHour,sunriseHour,aoyabinHour;
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

  bool isOpen=true;


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
                    child:
                    IconButton(
                      icon:Icon(Icons.menu,color: Colors.green,),
                      onPressed: drawerController.toggle,

                    )
                  ),
                  //Text(englishDate,style: TextStyle(color:Color(0xff06AB00), fontSize: 17)),

                  Expanded(
                      flex: 3,
                      child: Text('Search Islam',style: TextStyle(fontSize: 18.0,color: Colors.green,fontWeight: FontWeight.bold),)),

                  Expanded(flex: 2,
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
    banglaDate1='Bangla Date: '+BanglaUtility.getBanglaDate(day: DateTime.now().day, month: DateTime.now().month, year: DateTime.now().year);
    arabyDate=_today.toFormat("dd MMMM,yyyy");
    arabyDate1='Araby Date: '+_today.toFormat("dd MMMM,yyyy");
    englishDate=DateFormat('dd MMMM,yyyy').format(DateTime.now());
    englishDate1='English Date: '+DateFormat('dd MMMM,yyyy').format(DateTime.now());


    date1 = (DateTime.now().hour);
    DatabaseHelper.getPrayerTimeModels('${DateFormat('MMM dd').format(DateTime.now())}').then((prayermodels){
      setState(() {
        prayerTimeModels=prayermodels;
        sunrisetoday=prayermodels.fajr_end;
        sunsettoday=prayermodels.magrib;

        fojorHour_start=DateFormat("yyyy: MM: dd: hh:mm a").parse('${DateTime.now().year}: ${DateTime.now().month}: ${DateTime.now().day}: ${prayermodels.fajr_start}').hour;
        johaurHour=DateFormat("yyyy: MM: dd: hh:mm a").parse('${DateTime.now().year}: ${DateTime.now().month}: ${DateTime.now().day}: ${prayermodels.dhuhr}').hour;
        asorHour=DateFormat("yyyy: MM: dd: hh:mm a").parse('${DateTime.now().year}: ${DateTime.now().month}: ${DateTime.now().day}: ${prayermodels.asr}').hour;
        magribHour=DateFormat("yyyy: MM: dd: hh:mm a").parse('${DateTime.now().year}: ${DateTime.now().month}: ${DateTime.now().day}: ${prayermodels.magrib}').hour;
        esaHour=DateFormat("yyyy: MM: dd: hh:mm a").parse('${DateTime.now().year}: ${DateTime.now().month}: ${DateTime.now().day}: ${prayermodels.isha}').hour;
        sunriseHour=DateFormat("yyyy: MM: dd: hh:mm a").parse('${DateTime.now().year}: ${DateTime.now().month}: ${DateTime.now().day}: ${prayermodels.fajr_end}').hour;



        if(date1>=fojorHour_start&&date1<sunriseHour){
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

    final postion = Provider.of<LocationProvider>(context, listen: false).pos;
    Provider.of<LocationProvider>(context,listen: false).getDeviceCurrentLocation(postion: postion).then((_){
      setState(() {
        _center=LatLng(postion.latitude,postion.longitude);
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

    androidInitializationSettings = AndroidInitializationSettings('notification_icon');
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

    var timeDelayed = DateTime.now().add(Duration(seconds: 1));
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


    if(date1>=fojorHour_start&&date1<sunriseHour){

      await flutterLocalNotificationsPlugin.schedule(1, 'বর্তমান ওয়াক্ত ফজর', 'শুরু হয়েছে ${prayerTimeModels.fajr_start}\nশেষ হবে ${prayerTimeModels.fajr_end}', timeDelayed, notificationDetails, androidAllowWhileIdle: false);

    }else if(date1>=sunriseHour&&date1<johaurHour){

      await flutterLocalNotificationsPlugin.schedule(1, 'বর্তমান ওয়াক্ত ইশরাক', 'শুরু হয়েছে ${prayerTimeModels.israk}\nশেষ হবে ${prayerTimeModels.dhuhr}', timeDelayed, notificationDetails, androidAllowWhileIdle: false);

    }else if(date1>=johaurHour&&date1<asorHour){

      await flutterLocalNotificationsPlugin.schedule(1, 'বর্তমান ওয়াক্ত যহর', 'শুরু হয়েছে ${prayerTimeModels.dhuhr}\nশেষ হবে ${prayerTimeModels.asr}', timeDelayed, notificationDetails, androidAllowWhileIdle: false);

    }else if(date1>=asorHour&&date1<magribHour){

      await flutterLocalNotificationsPlugin.schedule(1, 'বর্তমান ওয়াক্ত আসর', 'শুরু হয়েছে ${prayerTimeModels.asr}\nশেষ হবে ${prayerTimeModels.magrib}', timeDelayed, notificationDetails, androidAllowWhileIdle: false);

    }else if(date1>=magribHour&&date1<aoyabinHour){

      await flutterLocalNotificationsPlugin.schedule(1, 'বর্তমান ওয়াক্ত মাগরিব', 'শুরু হয়েছে ${prayerTimeModels.magrib}\nশেষ হবে ${prayerTimeModels.aoyabin}', timeDelayed, notificationDetails, androidAllowWhileIdle: false);

    }else if(date1>=aoyabinHour&&date1<esaHour){

      await flutterLocalNotificationsPlugin.schedule(1, 'বর্তমান ওয়াক্ত আওয়াবিন', 'শুরু হয়েছে ${prayerTimeModels.aoyabin}\nশেষ হবে ${prayerTimeModels.isha}', timeDelayed, notificationDetails, androidAllowWhileIdle: false);

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
            showDialog(
              context: context,
              builder: (_) => CustomeAlertDialog(),
            );
          },
          child: SafeArea(
            child: Scaffold(
         appBar: PreferredSize(child: _appBar(),preferredSize: Size(MediaQuery.of(context).size.width, 120),) ,
              body: SingleChildScrollView(
                child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
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
                                          right: -12,
                                          top:5,
                                          child: Image.asset("images/home_mousque.png", height: 150, width: 140,)),
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

                            RotateAnimatedTextKit(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context)=>CalenderScreen()
                                ));
                              },
                              duration: Duration(milliseconds: 5000),
                              text: [
                                englishDate1,
                                arabyDate1,
                                banglaDate1,
                                englishDate1,
                                arabyDate1,
                                banglaDate1,
                                englishDate1,
                                arabyDate1,
                                banglaDate1,
                                englishDate1,
                                arabyDate1,
                                banglaDate1,
                                englishDate1,
                                arabyDate1,
                                banglaDate1,
                                englishDate1,
                                arabyDate1,
                                banglaDate1,
                                englishDate1,
                                arabyDate1,
                                banglaDate1,
                                englishDate1,
                                arabyDate1,
                                banglaDate1,
                                englishDate1,
                                arabyDate1,
                                banglaDate1,
                                englishDate1,
                                banglaDate1,
                                englishDate1,
                                arabyDate1,
                                banglaDate1,
                                englishDate1,
                                arabyDate1,
                                banglaDate1,
                                englishDate1,
                                arabyDate1,
                                banglaDate1,
                                englishDate1,
                                arabyDate1,
                                banglaDate1,
                                englishDate1,
                                banglaDate1,
                                englishDate1,
                                arabyDate1,
                                banglaDate1,
                                englishDate1,
                                arabyDate1,
                                banglaDate1,
                                englishDate1,
                                arabyDate1,
                                banglaDate1,
                                englishDate1,
                                arabyDate1,
                                banglaDate1,
                                englishDate1,
                                banglaDate1,
                                englishDate1,
                                arabyDate1,
                                banglaDate1,
                                englishDate1,
                                arabyDate1,
                                banglaDate1,
                                englishDate1,

                              ],

                              isRepeatingAnimation: true,
                              textStyle: TextStyle(fontSize: 17.0,color: Colors.green),
                              textAlign: TextAlign.start,
                              // or Alignment.topLeft
                            ),

                           Container(
                                child:Column(
                                  children: <Widget>[
                                    SizedBox(height: 5,),
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
                                              Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context)=>DoyaNameScren()
                                    ));
                                            },
                                            child: Column(
                                              children: <Widget>[
                                                Card(

                                                  child: Container(
                                                      padding: EdgeInsets.all(15),
                                                      child: Image.asset("images/doya.png",height: 40, width: 40,)),
                                                ),
                                                Text("দোয়া")
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
                                            onTap: (){
                                              Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context)=>CommentQuestionScreen()
                                    ));
                                            },
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
                                          InkWell(
                                            onTap: (){
                                              Navigator.of(context).push(MaterialPageRoute(
                                                  builder: (context)=>OjifaScreen()
                                              ));
                                            },
                                            child: Column(
                                              children: <Widget>[
                                                Card(

                                                  child: Container(
                                                      padding: EdgeInsets.all(15),
                                                      child: Image.asset("images/ojifa.png",height: 40, width: 40,)),
                                                ),
                                                Text("অজিফা")
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
                                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HadisScreen()));
                                            },
                                            child: Column(
                                              children: <Widget>[
                                                Card(

                                                  child: Container(
                                                      padding: EdgeInsets.all(15),
                                                      child: Image.asset("images/hadis.png",height: 40, width: 40,)),
                                                ),
                                                Text("হাদিস")
                                              ],
                                            ),
                                          ),

                                          InkWell(
                                            onTap: (){
                                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>NiyomScreen()));
                                            },
                                            child: Column(
                                              children: <Widget>[
                                                Card(

                                                  child: Container(
                                                      padding: EdgeInsets.all(15),
                                                      child: Image.asset("images/niyom.png",height: 40, width: 40,)),
                                                ),
                                                Text("নিয়ম")
                                              ],
                                            ),
                                          )
                                        ],
                                      ),

                                    SizedBox(height: 15,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        InkWell(
                                          onTap: (){
                                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>KiblaScreen()));
                                          },
                                          child: Column(
                                            children: <Widget>[
                                              Card(

                                                child: Container(
                                                    padding: EdgeInsets.all(15),
                                                    child: Image.asset("images/kibla.png",height: 40, width: 40,)),
                                              ),
                                              Text("কিবলা")
                                            ],
                                          ),
                                        ),

                                        InkWell(
                                          onTap: (){
                                            Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context)=>NearByMosqueScreen()
                                    ));
                                          },
                                          child: Column(
                                            children: <Widget>[
                                              Card(

                                                child: Container(
                                                    padding: EdgeInsets.all(15),
                                                    child: Image.asset("images/mosque.png",height: 40, width: 40,)),
                                              ),
                                              Text("নিকটবর্তী মসজিদ")
                                            ],
                                          ),
                                        ),

                                        InkWell(
                                          onTap: (){
                                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>TasbihScreen()));
                                          },
                                          child: Column(
                                            children: <Widget>[
                                              Card(

                                                child: Container(
                                                    padding: EdgeInsets.all(15),
                                                    child: Image.asset("images/tasbih.png",height: 40, width: 40,)),
                                              ),
                                              Text("তাসবিহ")
                                            ],
                                          ),
                                        ),

                                        InkWell(
                                          onTap: (){
                                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CalenderScreen()));
                                          },
                                          child: Column(
                                            children: <Widget>[
                                              Card(

                                                child: Container(
                                                    padding: EdgeInsets.all(15),
                                                    child: Image.asset("images/calendar.png",height: 40, width: 40,)),
                                              ),
                                              Text("ক্যালেন্ডার")
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 15,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[

                                        Expanded(
                                          child: InkWell(
                                            onTap: (){
                                              showDialog(
                                                context: context,
                                                builder: (_) => Labbayekallahumma_screen(),
                                              );
                                            },
                                            child: Column(
                                              children: <Widget>[
                                                Card(

                                                  child: Container(
                                                      padding: EdgeInsets.all(15),
                                                      child: Image.asset("images/labbaikkallahumma.png",height: 40, width: 40,)),
                                                ),
                                                Text("লাব্বাইক")
                                              ],
                                            ),
                                          ),
                                        ),

                                        Expanded(
                                          child: InkWell(
                                            onTap: (){
                                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>BlogPages()));
                                            },
                                            child: Column(
                                              children: <Widget>[
                                                Card(

                                                  child: Container(
                                                      padding: EdgeInsets.all(15),
                                                      child: Image.asset("images/web.png",height: 40, width: 40,)),
                                                ),
                                                Text("ব্লগ")
                                              ],
                                            ),
                                          ),
                                        ),

                                        Expanded(
                                          child: InkWell(
                                            onTap: (){
                                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SettingsPage()));
                                            },
                                            child: Column(
                                              children: <Widget>[
                                                Card(

                                                  child: Container(
                                                      padding: EdgeInsets.all(15),
                                                      child: Image.asset("images/settings.png",height: 40, width: 40,)),
                                                ),
                                                Text("সেটিংস")
                                              ],
                                            ),
                                          ),
                                        ),

                                        Expanded(
                                          child: InkWell(
                                            onTap: (){
                                              showDialog(
                                                context: context,
                                                builder: (_) => CustomeAlertDialog(),
                                              );
                                            },
                                            child: Column(
                                              children: <Widget>[
                                                Card(

                                                  child: Container(
                                                      padding: EdgeInsets.all(15),
                                                      child: Image.asset("images/close.png",height: 40, width: 40,)),
                                                ),
                                                Text("বন্ধ করুন")
                                              ],
                                            ),
                                          ),
                                        ),


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
            ),
          ),
        ),
      ),
    );

  }

  ListView _buildDrawer(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 50, bottom: 20),
          color: Colors.green,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ClipOval(
                child: Image.asset(
                  "images/app_logo.png",
                  width: 70,
                  height: 70,
                ),
              ),
              SizedBox(height: 15),
              Text(
                'Search Islam\n(সত্যের সন্ধানে)',
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
                    builder: (context)=>Labbayekallahumma_screen()
                ));
              },
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Image.asset(('images/labbaikkallahumma.png'),width: 25,),
              ), title: Text("লাব্বাইকাল্লামুম্মা লাব্বাইক")),
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
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context)=>AboutPages()
              ));
              },
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Image.asset(('images/developer.png'),width: 25,),
              ), title: Text("আমাদের সম্পর্কে জানুন")),
        ),
        Container(
          height: 250,
          color: Colors.green.withOpacity(.4),
        ),
      ],
    );
  }

}