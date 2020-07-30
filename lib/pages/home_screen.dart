

import 'dart:async';

import 'package:adhan_flutter/adhan_flutter.dart';
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
import 'package:url_launcher/url_launcher.dart';

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
  String zila;
  String currentTime='';
  String nextTime='';


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
  String majhabName='';

  int date1;
  bool isOpenQuran=true;

  int fojorHour_start,johaurHour,asorHour,magribHour,esaHour,sunriseHour,aoyabinHour;
  String sunrisetoday='';
  String sunsettoday='';

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  AndroidInitializationSettings androidInitializationSettings;
  IOSInitializationSettings iosInitializationSettings;
  InitializationSettings initializationSettings;

  LatLng _center;

  bool isOpen=true;
  bool isTimeString=false;

  String asortoday;

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    } }

  Widget _appBar(){
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
        child: Container(
          height:70,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 17),
          child:
          Row(
            children: <Widget>[
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
    );
  }

  void _getlatlngwithData(LatLng latLng) {
    latitude=latLng.latitude;
    longitude=latLng.longitude;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    androidInitializationSettings = new AndroidInitializationSettings('notification_icon');
    iosInitializationSettings = new IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    initializationSettings = new InitializationSettings(
        androidInitializationSettings, iosInitializationSettings);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);



    var _today = new HijriCalendar.now();
    banglaDate=BanglaUtility.getBanglaDate(day: DateTime.now().day, month: DateTime.now().month, year: DateTime.now().year);
    banglaDate1='Bangla Date: '+BanglaUtility.getBanglaDate(day: DateTime.now().day, month: DateTime.now().month, year: DateTime.now().year);
    arabyDate=_today.toFormat("dd MMMM,yyyy");
    arabyDate1='Araby Date: '+_today.toFormat("dd MMMM,yyyy");
    englishDate=DateFormat('dd MMMM,yyyy').format(DateTime.now());
    englishDate1='English Date: '+DateFormat('dd MMMM,yyyy').format(DateTime.now());


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

    Timer(
        Duration(seconds: 1),
            (){
          setState(() {
            isTimeString=true;
          });
        });

    _morning_notification_from_srarch_islam();
    _evening_notification_from_srarch_islam();

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

  void _morning_notification_from_srarch_islam() async {
    await morning_notification();
  }
  Future<void> morning_notification() async {
    var time = Time(5, 0, 0);

    AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      'your channel description',
      priority: Priority.High,
      importance: Importance.Max,
      styleInformation: BigTextStyleInformation(''),
    );

    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();
    NotificationDetails notificationDetails = NotificationDetails(androidNotificationDetails, iosNotificationDetails);

    await flutterLocalNotificationsPlugin.showDailyAtTime(1, 'সত্যের সন্ধানে', 'আসুন নিজের জীবনকে সুন্দর করি।', time, notificationDetails);

  }

  void _evening_notification_from_srarch_islam() async {
    await evening_notification();
  }
  Future<void> evening_notification() async {
    var time = Time(19, 00, 0);

    AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      'your channel description',
      priority: Priority.High,
      importance: Importance.Max,
      styleInformation: BigTextStyleInformation(''),
    );

    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();
    NotificationDetails notificationDetails = NotificationDetails(androidNotificationDetails, iosNotificationDetails);

    await flutterLocalNotificationsPlugin.showDailyAtTime(1, 'সত্যের সন্ধানে', '“আজকের কাজ আগামীকাল করার জন্য রেখে দিবেন না। পরে দেখা যাবে কাজগুলো জমা হয়ে যাবে এবং আপনি কিছুই অর্জন করতে পারবেন না।”', time, notificationDetails);

  }


  @override
  Widget build(BuildContext context) {

    zilaInitialize();

    return DeivaoDrawer(
      controller: drawerController,
      drawer: _buildDrawer(context),
      child: DefaultTabController(
        length: 9,
        child: WillPopScope(
          onWillPop: (){
            _morning_notification_from_srarch_islam();
            _evening_notification_from_srarch_islam();
            showDialog(
              context: context,
              builder: (_) => CustomeAlertDialog(),
            );
          },
          child: SafeArea(
            child: Scaffold(
              appBar: PreferredSize(child: _appBar(),
                preferredSize: Size(MediaQuery.of(context).size.width, 120),) ,
              body: ListView(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: <Widget>[
                        Container(
                            height:164,
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
                                              fontSize: 20, color: Colors.white
                                          ),);
                                        } else if (snapshot.hasError) {
                                          print(snapshot.hasError);
                                          return Container();
                                        } else {
                                          return CircularProgressIndicator();
                                        }
                                      },
                                    ),
                                    Container(
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(colors: [
                                              const Color(0xffffffff),
                                              const Color(0xff178723),
                                              const Color(0xffffffff),
                                            ]))
                                    ),
                                    Text("পরবর্তী নামাজের ওয়াক্ত", style: TextStyle(color: Colors.white),),
                                    Center(child:
                                    isTimeString?
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        FutureBuilder(
                                            future: getNextPrayer(),
                                            builder: (context, AsyncSnapshot<Prayer> snapshot) {
                                              if (snapshot.hasData) {
                                                final prayer = snapshot.data;
                                                if(prayer.toString().trim()=="Prayer.ASR"){
                                                  nextTime = "আসর";
                                                }
                                                else if(prayer.toString().trim()=="Prayer.FAJR"){
                                                  nextTime = "ফজর";
                                                }
                                                else if(prayer.toString().trim()=="Prayer.SUNRISE"){
                                                  nextTime = "নামাজের জন্য হারাম";
                                                }
                                                else if(prayer.toString().trim()=="Prayer.DHUHR"){
                                                  nextTime = "যোহর";
                                                }
                                                else if(prayer.toString().trim()=="Prayer.MAGHRIB"){
                                                  nextTime = "মাগরিব";
                                                }
                                                else if(prayer.toString().trim()=="Prayer.ISHA"){
                                                  nextTime = "এশা";
                                                }else
                                                {
                                                  nextTime = "নফল";
                                                }
                                                return Container(
                                                    alignment: Alignment.centerLeft,
                                                    child: Text(nextTime,style: TextStyle(fontSize: 20, color: Colors.white) ));
                                              }
                                              if(snapshot.hasError){
                                                print(snapshot.error);
                                                return Container();
                                              }
                                              return CircularProgressIndicator();
                                            }

                                        ),

                                      ],
                                    ):
                                    Container(
                                      child: Text('',style: TextStyle(color: Colors.white),),
                                    ),
                                    ),

                                    Row(
                                      children: <Widget>[
                                        FutureBuilder(
                                          future: getTodaySuriseTime(),
                                          builder: (context, AsyncSnapshot<DateTime> snapshot) {
                                            if (snapshot.hasData) {
                                              final dateTime = snapshot.data.toLocal();
                                              Sunrise=DateFormat.jm().format(dateTime);
                                              return Text('সূর্যদয়ঃ ${Sunrise} । ', style: TextStyle(

                                                  color: Colors.white
                                              ),);
                                            } else if (snapshot.hasError) {
                                              print(snapshot.hasError);
                                              return SingleChildScrollView();
                                            } else {
                                              return Text('');
                                            }
                                          },
                                        ),
                                        FutureBuilder(
                                          future: getTodayMagribTime(),
                                          builder: (context, AsyncSnapshot<DateTime> snapshot) {
                                            if (snapshot.hasData) {
                                              final dateTime = snapshot.data.toLocal();
                                              Sunset=DateFormat.jm().format(dateTime);
                                              return Text('সূর্যাস্তঃ ${Sunset}', style: TextStyle(

                                                  color: Colors.white
                                              ),);
                                            } else if (snapshot.hasError) {
                                              print(snapshot.hasError);
                                              return SingleChildScrollView();
                                            } else {
                                              return Text('');
                                            }
                                          },
                                        ),
                                      ],
                                    ),
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
                                        Navigator.of(context).push(ScaleRoute(page: SuraListPage()));
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
                                        Navigator.of(context).push(ScaleRoute(
                                            page: DoyaNameScren()
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
                                        Navigator.of(context).push(ScaleRoute(page: QuranWordPages()));
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
                                        Navigator.of(context).push(ScaleRoute(
                                            page:CommentQuestionScreen()
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
                                        Navigator.of(context).push(ScaleRoute(
                                            page: OjifaScreen()
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
                                        Navigator.of(context).push(ScaleRoute(page:ShomoyShuchi()));
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
                                        Navigator.of(context).push(ScaleRoute(page: HadisScreen() ));
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
                                        Navigator.of(context).push(ScaleRoute(page:NiyomScreen()));
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
                                        Navigator.of(context).push(ScaleRoute(page: KiblaScreen()));
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
                                        Navigator.of(context).push(ScaleRoute(
                                            page: NearByMosqueScreen()
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
                                        Navigator.of(context).push(ScaleRoute(page:TasbihScreen()));
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
                                        Navigator.of(context).push(ScaleRoute(page: CalenderScreen()));
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
                                          Navigator.of(context).push(ScaleRoute(page: BlogPages()));
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
                                          Navigator.of(context).push(ScaleRoute(page:  SettingsPage()));
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
                ],
              ),
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
                setState(() {
                  isOpenQuran=!isOpenQuran;
                });
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
                showDialog(
                  context: context,
                  builder: (_) => Labbayekallahumma_screen(),
                );
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
          height: 1,
          color: Colors.green.withOpacity(.4),
        ),
        Container(
          color: Colors.green.withOpacity(.5),
          child: ListTile(
              onTap: (){
                _launchURL('https://play.google.com/store/apps/developer?id=duetinmehedishuvo');
              },
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Image.asset(('images/share.png'),width: 25,),
              ), title: Text("শেয়ার করুণ")),
        ),
        Container(
          height: 250,
          color: Colors.green.withOpacity(.4),
        ),
      ],
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

  void zilaInitialize(){
    Utils.getZilaNameFromPreference().then((zilaName){
      setState(() {

        zila=zilaName;

        if(zilaName.trim()=='Dhaka'){
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

class ScaleRoute extends PageRouteBuilder {
  final Widget page;
  ScaleRoute({@required this.page})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        ScaleTransition(
          scale: Tween<double>(
            begin: 0.0,
            end: 1.0,
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.fastOutSlowIn,
            ),
          ),
          child: child,
        ),
  );
}