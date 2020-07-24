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
  var timezone = DateTime.now().timeZoneOffset.inHours.toDouble();
  int year = DateTime.now().year;
  int month = DateTime.now().month;
  int day = DateTime.now().day;
  Geocoordinate geo;
  
  
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
                        _inital();
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
    Provider.of<LocationProvider>(context,listen: false).getDeviceCurrentLocation().then((postion){
      setState(() {
        _center=LatLng(postion.latitude,postion.longitude);
      });
    });

    Utils.getZilaNameFromPreference().then((zilaName){
      setState(() {
        zila=zilaName;

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
        } else{
          print('Default Called');
          _getlatlngwithData(LatLng(23.7115253,90.4111451));
        }

      });
    });

  }
  
  _getlatlngwithData(LatLng latLng){
    DateTime when = DateTime.utc(month, year, day);

    PrayerCalculationSettings settings = PrayerCalculationSettings((PrayerCalculationSettingsBuilder b) =>
    b
      ..calculationMethod.replace(CalculationMethod.fromPreset(preset: CalculationMethodPreset.islamicSocietyOfNorthAmerica))
      ..imsakParameter.replace(PrayerCalculationParameter((PrayerCalculationParameterBuilder c) => c..value = 0 ..type = PrayerCalculationParameterType.minutesAdjust))
      ..juristicMethod.replace(JuristicMethod((JuristicMethodBuilder e) => e..preset = JuristicMethodPreset.hanafi
        ..timeOfShadow = 2))
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

    geo = Geocoordinate((GeocoordinateBuilder b) => b
      ..latitude = latLng.latitude
      ..longitude = latLng.longitude
      ..altitude = 14);
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

    print('${current.type}:Shuvo Khan ${current.time}');
    print(current.toString());
    print('fajr: ${prayers.fajr}');
    print('Dohor: ${prayers.dhuhr}');
    print('Imshak: ${prayers.imsak}');
    print('Sunrise: ${prayers.sunrise}');
    print('Asor: ${prayers.asr}');
    print(prayers.maghrib);
    print(prayers.sunset);
    print(prayers.isha);
    print(prayers.midnight);

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
    final Prayer later = Prayer.next(settings: settings, coordinate: geo, timeZone: 6.0);
    print('Next Prayer: ${later.type}: ${later.time}');
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

  @override
  void initState() {
    super.initState();
    _inital();
  }

  @override
  Widget build(BuildContext context) {
    
    
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
