import 'package:flutter/material.dart';
import 'package:compasstools/compasstools.dart';

class KiblaScreen extends StatefulWidget {
  @override
  _KiblaScreenState createState() => _KiblaScreenState();
}

class _KiblaScreenState extends State<KiblaScreen> {
  int _haveSensor;
  String sensorType;

  @override
  void initState() {
    super.initState();
    checkDeviceSensors();
  }

  Future<void> checkDeviceSensors() async {

    int haveSensor;

    try{
      haveSensor = await Compasstools.checkSensors;

      switch(haveSensor) {
        case 0: {
          // statements;
          sensorType="No sensors for Compass";
          print('No sensors for Compass');
        }
        break;

        case 1: {
          //statements;
          sensorType="Accelerometer + Magnetoneter";
          print('Accelerometer + Magnetoneter');
        }
        break;

        case 2: {
          //statements;
          sensorType="Gyroscope";
          print('Gyroscope');
        }
        break;

        default: {
          //statements;
          sensorType="Error!";
          print('Error');
        }
        break;
      }

    } on Exception {
      print('Exception');
    }

    if (!mounted) return;

    setState(() {
      _haveSensor = haveSensor;
    });
  }


  @override
  Widget build(BuildContext context) {
    Widget _appBar(){
      return Container(

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
              color: Colors.green.withOpacity(.1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(icon: Icon(Icons.arrow_back, color: Colors.white,), onPressed: (){
                    Navigator.of(context).pop();
                  }),
                  FittedBox(
                    child: Text('কিবলা',style:  TextStyle(
                        color: Colors.white, fontSize: 20
                    ), ),
                  ),


                ],
              ),
            ),

          ),

        ),
      );
    }
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
          appBar:PreferredSize(child: _appBar(),preferredSize: Size(MediaQuery.of(context).size.width, 120),) ,
        body:Stack(
          children: <Widget>[
            StreamBuilder(
              stream: Compasstools.azimuthStream,
              builder: (BuildContext context, AsyncSnapshot<int> snapshot){
                if(snapshot.hasData) {
                  return Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height,
                    child:Center(
                      child:new RotationTransition(
                        turns: new AlwaysStoppedAnimation(-snapshot.data/360),
                        child: Image.asset('images/compass1.png',width: double.infinity,height: double.infinity,),
                      ),
                    ),
                  );
                } else
                  return Text("Error in stream");
              },
            ),
            Positioned(
              bottom: 5,
              left: 8,
              right: 8,
              child: Text('বিঃদ্রঃ ডিভাইসের কারিগরি সমস্যার কারণে সঠিক দিক নির্দেশনা নাও পেতে পারেন।\n'
                  'সঠিক দিক নির্দেশনা পেতে ডিভাইসটি ভালো ভাবে ক্যালিবারেট করে নিন।',style: TextStyle(
                fontSize: 18,
                color: Colors.black
              ),),
            ),
          ],
        )
      ),
    );
  }

}
