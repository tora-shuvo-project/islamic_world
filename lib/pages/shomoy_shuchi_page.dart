import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:libpray/libpray.dart';
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
  String dohortoday='';
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
    var timezone = now.timeZoneOffset.inHours.toDouble();
    int year = now.year;
    int month = now.month;
    int day = now.day;
    Geocoordinate geo;
    DateTime when = DateTime.utc(month, year, day);
    PrayerCalculationSettings settings = PrayerCalculationSettings((PrayerCalculationSettingsBuilder b) =>
    b
      ..calculationMethod.replace(CalculationMethod.fromPreset(preset: CalculationMethodPreset.universityOfIslamicSciencesKarachi))
      ..imsakParameter.replace(PrayerCalculationParameter((PrayerCalculationParameterBuilder c) => c..value = 0 ..type = PrayerCalculationParameterType.minutesAdjust))
      ..juristicMethod.replace(JuristicMethod((JuristicMethodBuilder e) => e..preset = JuristicMethodPreset.hanafi ..timeOfShadow = 2))
      ..highLatitudeAdjustment = HighLatitudeAdjustment.angleBased
      ..imsakMinutesAdjustment = 0
      ..fajrMinutesAdjustment = 0
      ..sunriseMinutesAdjustment = 0
      ..dhuhaMinutesAdjustment = 0
      ..dhuhrMinutesAdjustment = 0
      ..asrMinutesAdjustment = 0
      ..maghribMinutesAdjustment = 0
      ..ishaMinutesAdjustment = 0
    );
    final postion = Provider.of<LocationProvider>(context, listen: false).pos;
    print(postion.longitude);
    print(postion.latitude);
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

          geo = Geocoordinate((GeocoordinateBuilder b) => b
            ..latitude = 23.9980797
            ..longitude = 90.4229848
            ..altitude = 12);
          final Prayers prayers = Prayers.on(date: when, settings: settings, coordinate: geo, timeZone: 6.0);
          fajartoday = DateFormat.jm().format(prayers.fajr);
          israk = DateFormat.jm().format(prayers.imsak);
          dohortoday = DateFormat.jm().format(prayers.dhuhr);
          asortoday = DateFormat.jm().format(prayers.asr);
          Chasttoday=DateFormat.jm().format(prayers.dhuha);
          magribtoday = DateFormat.jm().format(prayers.maghrib);
          esatoday= DateFormat.jm().format(prayers.isha);
          Sunrise = DateFormat.jm().format(prayers.sunrise);
          Sunset = DateFormat.jm().format(prayers.sunset);

          final Prayer current = Prayer.now(settings: settings, coordinate: geo, timeZone: 6.0);

          print('${current.type}: ${current.time}');
          print(prayers.dhuhr);

          //current prayer name
          if(current.type.toString()=="fazr"){
            currentPrayername ="ফজর";
            print(currentPrayername);
          }
          else if(current.type.toString()=="dhuhr"){
            currentPrayername ="যোহর";
            print(currentPrayername);
          }
          else if(current.type.toString()=="asr"){
            currentPrayername ="আসর";
            print(currentPrayername);
          }
          else if(current.type.toString()=="maghrib"){
            currentPrayername ="মাগরিব";
            print(currentPrayername);
          }
          else if(current.type.toString()=="isha"){
            currentPrayername ="এশা";
            print(currentPrayername);
          }
          else if(current.type.toString()=="imsak"){
            currentPrayername="ইশরাক";
            print(currentPrayername);
          }
          else if(current.type.toString()=="dhuha") {
            currentPrayername = "চাশত";
            print(currentPrayername);
          }

          //next prayer time
          currentPrayerTime = DateFormat.jm().format(current.time);

          //Next prayer Name
          final Prayer later = Prayer.later(
              settings: settings, coordinate: geo, timeZone: 6.0);
          print('${later.type}: ${later.time}');
          nextPrayerTime =DateFormat.jm().format(later.time);
          if (later.type.toString() == "fazr") {
            nextPrayerName = "ফজর";
            print(nextPrayerName);
          }
          else if (later.type.toString() == "dhuhr") {
            nextPrayerName = "যোহর";
            print(nextPrayerName);
          }
          else if (later.type.toString() == "asr") {
            nextPrayerName = "আসর";
            print(nextPrayerName);
          }
          else if (later.type.toString() == "maghrib") {
            nextPrayerName = "মাগরিব";
            print(nextPrayerName);
          }
          else if (later.type.toString() == "isha") {
            nextPrayerName = "এশা";
            print(nextPrayerName);
          }
          else if (later.type.toString() == "imsak") {
            nextPrayerName = "ইশরাক";
            print(nextPrayerName);
          }
          else if (later.type.toString() == "dhuha") {
            nextPrayerName = "চাশত";
            print(nextPrayerName);
          }

          //timeString
          setState(() {
            _timeString="${current.time.difference(later.time).inHours.abs()} ঘন্টা "
                "${(((current.time.minute+60)-DateTime.now().minute)-1).abs()} মিনিট"
                " ${60-current.time.second.abs()}  সেকেন্ড পর  ";
          });
        }
        else if(demoZila.trim()=='Bagerhat'){
          geo = Geocoordinate((GeocoordinateBuilder b) => b
            ..latitude = 22.6554187
            ..longitude = 89.7971746
            ..altitude = 9);

          final Prayers prayers = Prayers.on(date: when, settings: settings, coordinate: geo, timeZone: 6.0);
          fajartoday = DateFormat.jm().format(prayers.fajr);
          israk = DateFormat.jm().format(prayers.imsak);
          dohortoday = DateFormat.jm().format(prayers.dhuhr);
          asortoday = DateFormat.jm().format(prayers.asr);
          Chasttoday=DateFormat.jm().format(prayers.dhuha);
          magribtoday = DateFormat.jm().format(prayers.maghrib);
          esatoday= DateFormat.jm().format(prayers.isha);
          Sunrise = DateFormat.jm().format(prayers.sunrise);
          Sunset = DateFormat.jm().format(prayers.sunset);

          final Prayer current = Prayer.now(settings: settings, coordinate: geo, timeZone: 6.0);

          print('${current.type}: ${current.time}');
          print(prayers.dhuhr);

          //current prayer name
          if(current.type.toString()=="fazr"){
            currentPrayername ="ফজর";
            print(currentPrayername);
          }
          else if(current.type.toString()=="dhuhr"){
            currentPrayername ="যোহর";
            print(currentPrayername);
          }
          else if(current.type.toString()=="asr"){
            currentPrayername ="আসর";
            print(currentPrayername);
          }
          else if(current.type.toString()=="maghrib"){
            currentPrayername ="মাগরিব";
            print(currentPrayername);
          }
          else if(current.type.toString()=="isha"){
            currentPrayername ="এশা";
            print(currentPrayername);
          }
          else if(current.type.toString()=="imsak"){
            currentPrayername="ইশরাক";
            print(currentPrayername);
          }
          else if(current.type.toString()=="dhuha") {
            currentPrayername = "চাশত";
            print(currentPrayername);
          }

          //next prayer time
          currentPrayerTime = DateFormat.jm().format(current.time);

          //Next prayer Name
          final Prayer later = Prayer.later(
              settings: settings, coordinate: geo, timeZone: 6.0);
          print('${later.type}: ${later.time}');
          nextPrayerTime =DateFormat.jm().format(later.time);
          if (later.type.toString() == "fazr") {
            nextPrayerName = "ফজর";
            print(nextPrayerName);
          }
          else if (later.type.toString() == "dhuhr") {
            nextPrayerName = "যোহর";
            print(nextPrayerName);
          }
          else if (later.type.toString() == "asr") {
            nextPrayerName = "আসর";
            print(nextPrayerName);
          }
          else if (later.type.toString() == "maghrib") {
            nextPrayerName = "মাগরিব";
            print(nextPrayerName);
          }
          else if (later.type.toString() == "isha") {
            nextPrayerName = "এশা";
            print(nextPrayerName);
          }
          else if (later.type.toString() == "imsak") {
            nextPrayerName = "ইশরাক";
            print(nextPrayerName);
          }
          else if (later.type.toString() == "dhuha") {
            nextPrayerName = "চাশত";
            print(nextPrayerName);
          }

          //timeString
          setState(() {
            _timeString="${current.time.difference(later.time).inHours.abs()} ঘন্টা "
                "${(((current.time.minute+60)-DateTime.now().minute)-1).abs()} মিনিট"
                " ${60-current.time.second.abs()}  সেকেন্ড পর  ";
          });
        }
        else if(demoZila.trim()=='Bandarban'){
          geo = Geocoordinate((GeocoordinateBuilder b) => b
            ..latitude = 22.1963002
            ..longitude = 92.2198872
            ..altitude = 24);
          final Prayers prayers = Prayers.on(date: when, settings: settings, coordinate: geo, timeZone: 6.0);
          fajartoday = DateFormat.jm().format(prayers.fajr);
          israk = DateFormat.jm().format(prayers.imsak);
          dohortoday = DateFormat.jm().format(prayers.dhuhr);
          asortoday = DateFormat.jm().format(prayers.asr);
          Chasttoday=DateFormat.jm().format(prayers.dhuha);
          magribtoday = DateFormat.jm().format(prayers.maghrib);
          esatoday= DateFormat.jm().format(prayers.isha);
          Sunrise = DateFormat.jm().format(prayers.sunrise);
          Sunset = DateFormat.jm().format(prayers.sunset);

          final Prayer current = Prayer.now(settings: settings, coordinate: geo, timeZone: 6.0);

          print('${current.type}: ${current.time}');
          print(prayers.dhuhr);

          //current prayer name
          if(current.type.toString()=="fajr"){
            currentPrayername ="ফজর";
            print(currentPrayername);
          }
          else if(current.type.toString()=="dhuhr"){
            currentPrayername ="যোহর";
            print(currentPrayername);
          }
          else if(current.type.toString()=="asr"){
            currentPrayername ="আসর";
            print(currentPrayername);
          }
          else if(current.type.toString()=="maghrib"){
            currentPrayername ="মাগরিব";
            print(currentPrayername);
          }
          else if(current.type.toString()=="isha"){
            currentPrayername ="এশা";
            print(currentPrayername);
          }
          else if(current.type.toString()=="imsak"){
            currentPrayername="ইশরাক";
            print(currentPrayername);
          }
          else if(current.type.toString()=="dhuha") {
            currentPrayername = "চাশত";
            print(currentPrayername);
          }

          //next prayer time
          currentPrayerTime = DateFormat.jm().format(current.time);

          //Next prayer Name
          final Prayer later = Prayer.later(
              settings: settings, coordinate: geo, timeZone: 6.0);
          print('${later.type}: ${later.time}');
          nextPrayerTime =DateFormat.jm().format(later.time);
          if (later.type.toString() == "fazr") {
            nextPrayerName = "ফজর";
            print(nextPrayerName);
          }
          else if (later.type.toString() == "dhuhr") {
            nextPrayerName = "যোহর";
            print(nextPrayerName);
          }
          else if (later.type.toString() == "asr") {
            nextPrayerName = "আসর";
            print(nextPrayerName);
          }
          else if (later.type.toString() == "maghrib") {
            nextPrayerName = "মাগরিব";
            print(nextPrayerName);
          }
          else if (later.type.toString() == "isha") {
            nextPrayerName = "এশা";
            print(nextPrayerName);
          }
          else if (later.type.toString() == "imsak") {
            nextPrayerName = "ইশরাক";
            print(nextPrayerName);
          }
//          else if (later.type.toString() == "dhuha") {
//            nextPrayerName = "চাশত";
//            print(nextPrayerName);
//          }

          //timeString
          setState(() {
            _timeString="${current.time.difference(later.time).inHours.abs()} ঘন্টা "
                "${(((current.time.minute+60)-DateTime.now().minute)-1).abs()} মিনিট"
                " \n${60-current.time.second.abs()}  সেকেন্ড পর  ";
          });

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

          geo = Geocoordinate((GeocoordinateBuilder b) => b
            ..latitude = provider.pos.latitude
            ..longitude = provider.pos.longitude
            ..altitude = provider.pos.altitude);

          final Prayers prayers = Prayers.on(date: when, settings: settings, coordinate: geo, timeZone: 6.0);
          fajartoday = DateFormat.jm().format(prayers.fajr);
          israk = DateFormat.jm().format(prayers.imsak);
          dohortoday = DateFormat.jm().format(prayers.dhuhr);
          asortoday = DateFormat.jm().format(prayers.asr);
          Chasttoday=DateFormat.jm().format(prayers.dhuha);
          magribtoday = DateFormat.jm().format(prayers.maghrib);
          esatoday= DateFormat.jm().format(prayers.isha);
          Sunrise = DateFormat.jm().format(prayers.sunrise);
          Sunset = DateFormat.jm().format(prayers.sunset);

          final Prayer current = Prayer.now(settings: settings, coordinate: geo, timeZone: 6.0);

          print('${current.type}: ${current.time}');
          print(prayers.dhuhr);

          //current prayer name
          if(current.type.toString()=="fazr"){
            currentPrayername ="ফজর";
            print(currentPrayername);
          }
          else if(current.type.toString()=="dhuhr"){
            currentPrayername ="যোহর";
            print(currentPrayername);
          }
          else if(current.type.toString()=="asr"){
            currentPrayername ="আসর";
            print(currentPrayername);
          }
          else if(current.type.toString()=="maghrib"){
            currentPrayername ="মাগরিব";
            print(currentPrayername);
          }
          else if(current.type.toString()=="isha"){
            currentPrayername ="এশা";
            print(currentPrayername);
          }
          else if(current.type.toString()=="imsak"){
            currentPrayername="ইশরাক";
            print(currentPrayername);
          }
          else if(current.type.toString()=="dhuha") {
            currentPrayername = "চাশত";
            print(currentPrayername);
          }

          //next prayer time
          currentPrayerTime = DateFormat.jm().format(current.time);

          //Next prayer Name
          final Prayer later = Prayer.later(
              settings: settings, coordinate: geo, timeZone: 6.0);
          print('${later.type}: ${later.time}');
          nextPrayerTime =DateFormat.jm().format(later.time);
          if (later.type.toString() == "fazr") {
            nextPrayerName = "ফজর";
            print(nextPrayerName);
          }
          else if (later.type.toString() == "dhuhr") {
            nextPrayerName = "যোহর";
            print(nextPrayerName);
          }
          else if (later.type.toString() == "asr") {
            nextPrayerName = "আসর";
            print(nextPrayerName);
          }
          else if (later.type.toString() == "maghrib") {
            nextPrayerName = "মাগরিব";
            print(nextPrayerName);
          }
          else if (later.type.toString() == "isha") {
            nextPrayerName = "এশা";
            print(nextPrayerName);
          }
          else if (later.type.toString() == "imsak") {
            nextPrayerName = "ইশরাক";
            print(nextPrayerName);
          }
          else if (later.type.toString() == "dhuha") {
            nextPrayerName = "চাশত";
            print(nextPrayerName);
          }

          //timeString
          setState(() {
            _timeString="${current.time.difference(later.time).inHours.abs()} ঘন্টা "
                "${(((current.time.minute+60)-DateTime.now().minute)-1).abs()} মিনিট"
                " ${60-current.time.second.abs()}  সেকেন্ড পর  ";
          });

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
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        FittedBox(
                          child: Row(
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
                                  Text(currentPrayername, style: TextStyle(color: Colors.white,fontSize: 30, fontWeight: FontWeight.bold),)
                                ],
                              ),
                            ],
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Image.asset("images/sunrise.png", width: 50, height:50 ,),
                                Text("Sunrise", style: TextStyle(color: Colors.white)),
                                Text(Sunrise,style: TextStyle(color: Colors.white))

                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Image.asset("images/sunset.png", width: 50, height:50 ,),
                                Text("Sunset",style: TextStyle(color: Colors.white)),
                                Text(Sunset,style: TextStyle(color: Colors.white))

                              ],
                            )
                          ],
                        )
                      ],
                    ),
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
                                Text("যোহর"),
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
                                Text("আসর"),
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
                                Text("মাগরিব"),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,children: <Widget>[
                              Text("এশা"),
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
        ),
      ),

    );
  }
}
