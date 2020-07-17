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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('কিবলা '),
      ),
      body: StreamBuilder(
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
    );
  }

}