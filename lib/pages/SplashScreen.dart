
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:searchtosu/FinalModels/prayer_time_models.dart';
import 'package:searchtosu/helpers/database_helper.dart';
import 'package:searchtosu/pages/home_screen.dart';
import 'package:searchtosu/utils/utils.dart';

class SplashScreen extends StatefulWidget {

  static final route='/launch';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  int fojorHour_start,aoyabinHour,johaurHour,asorHour,magribHour,esaHour,sunriseHour;
  int date1;
  PrayerTimeModels prayerTimeModels;
  String zilaName;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings androidInitializationSettings;
  IOSInitializationSettings iosInitializationSettings;
  InitializationSettings initializationSettings;

  @override
  void initState() {
    super.initState();

    date1 = (DateTime.now().hour);
    DatabaseHelper.getPrayerTimeModels('${DateFormat('MMM dd').format(DateTime.now())}').then((prayermodels){
      setState(() {

        prayerTimeModels=prayermodels;

        fojorHour_start=DateFormat("yyyy: MM: dd: hh:mm a").parse('${DateTime.now().year}: ${DateTime.now().month}: ${DateTime.now().day}: ${prayermodels.fajr_start}').hour;
        johaurHour=DateFormat("yyyy: MM: dd: hh:mm a").parse('${DateTime.now().year}: ${DateTime.now().month}: ${DateTime.now().day}: ${prayermodels.dhuhr}').hour;
        asorHour=DateFormat("yyyy: MM: dd: hh:mm a").parse('${DateTime.now().year}: ${DateTime.now().month}: ${DateTime.now().day}: ${prayermodels.asr}').hour;
        magribHour=DateFormat("yyyy: MM: dd: hh:mm a").parse('${DateTime.now().year}: ${DateTime.now().month}: ${DateTime.now().day}: ${prayermodels.magrib}').hour;
        esaHour=DateFormat("yyyy: MM: dd: hh:mm a").parse('${DateTime.now().year}: ${DateTime.now().month}: ${DateTime.now().day}: ${prayermodels.isha}').hour;
        sunriseHour=DateFormat("yyyy: MM: dd: hh:mm a").parse('${DateTime.now().year}: ${DateTime.now().month}: ${DateTime.now().day}: ${prayermodels.israk}').hour;
        aoyabinHour=DateFormat("yyyy: MM: dd: hh:mm a").parse('${DateTime.now().year}: ${DateTime.now().month}: ${DateTime.now().day}: ${prayermodels.aoyabin}').hour;


      });
    });

    initializing();

    Utils.getZilaNameFromPreference().then((value){
      zilaName=value;
    });
  }

  void initializing() async {

    androidInitializationSettings = AndroidInitializationSettings('sms');
    iosInitializationSettings = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    initializationSettings = InitializationSettings(
        androidInitializationSettings, iosInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);

    _showNotificationsAfterSecond();

  }

  void _showNotificationsAfterSecond() async {
    await notificationAfterSec();
  }
  Future<void> notificationAfterSec() async {
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

  Future onSelectNotification(String payLoad) {
    if (payLoad != null) {
      print(payLoad);
    }

    // we can set navigator to navigate another screen
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("images/kuranIcon.png", width:150,
              height:  150,fit:BoxFit.cover,),
            SizedBox(height: 25,),
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Container(
                width: 100,
                height: 50,
                decoration: BoxDecoration(
                    color: Color(0xff178723)
                ),
                child: FlatButton(
                    onPressed: (){
                      _showNotificationsAfterSecond();
                      Navigator.pushReplacementNamed(context, HomeScreen.route);
                    }, child: Text("Welcome", style: TextStyle(color: Colors.white),)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}