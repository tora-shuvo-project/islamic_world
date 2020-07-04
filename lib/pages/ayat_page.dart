

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:searchtosu/DataBaseHelper/database_helper.dart';
import 'package:searchtosu/FinalModels/audio_models.dart';
import 'package:searchtosu/utils/utils.dart';
import 'package:video_player/video_player.dart';

import '../FinalModels/ayat_table_model.dart';

class AyatPage extends StatefulWidget {

  final int ayatNo;
  final String suraname;
  AyatPage(this.ayatNo,this.suraname);

  @override
  _AyatPageState createState() => _AyatPageState();
}

class _AyatPageState extends State<AyatPage> {

  DatabaseHelper suranamedbHelpers=DatabaseHelper.instance;
  List<AyatTableModel> ayatmodels=new List();
  bool arbi = true;
  bool banglameaning= true;
  bool banglauccharon = true;

  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;
  Utils utils;
  AudioModels audioModels;

  _playAudioButtonClick(){

    if (_controller.value.isPlaying) {
      _controller.pause();
    } else {
      _controller.play();
    }
  }


  Widget _appBar(){
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
        child: Container(
          height:120,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                const Color(0xff178723),
                const Color(0xff27AB4B)
              ])
          ),
          padding: EdgeInsets.symmetric(horizontal: 17,vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    InkWell(
                        onTap:(){
                          Navigator.of(context).pop();
                        },
                        child: Icon(Icons.arrow_back, color: Colors.white,)),
                    SizedBox(width: 10,),
                    Text( '${widget.suraname}', style: TextStyle(color: Colors.white, fontSize: 20),),

                  ],
                ),
              ),
              SizedBox(height: 20,),
              Divider(
                color: Colors.white,
                height: 2,
                thickness: 0.7,
              ),
              Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Theme(
                        data: ThemeData(unselectedWidgetColor: Colors.white),
                        child: Checkbox(
                            activeColor: Colors.green,
                            value:  arbi || banglauccharon || banglameaning ? arbi : true,
                            onChanged:(bool changed){
                              setState(() {
                                arbi = changed;
                              });
                            }
                        ),
                      ),
                      Text("আরবি",style: TextStyle(color: Colors.white,fontSize: 13)),
                      Theme(
                        data: ThemeData(unselectedWidgetColor: Colors.white),
                        child: Checkbox(value: banglameaning,
                            activeColor: Colors.green,
                            onChanged:(bool changed){
                              setState(() {
                                banglameaning = changed;
                              });
                            }
                        ),
                      ),
                      Text("বাংলা অর্থ",style: TextStyle(color: Colors.white,fontSize: 13)),
                      Theme(
                        data: ThemeData(unselectedWidgetColor: Colors.white),
                        child: Checkbox(value: banglauccharon,
                            activeColor: Colors.green,
                            onChanged:(bool changed){
                              setState(() {
                                banglauccharon = changed;
                              });
                            }
                        ),
                      ),
                      Text("বাংলা উচ্চারন",style: TextStyle(color: Colors.white,fontSize: 13) ,)
                    ],
                  )
              ),
            ],
          ),


        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    audioModels=AudioModels();
    utils=Utils();
    utils.getQareNameFromPreference().then((qarename) {
      setState(() {
        suranamedbHelpers.getAudioBySuraAndQareName(widget.ayatNo, qarename).then((audioMode){
          setState(() {
            audioModels=audioMode;
            _controller = VideoPlayerController.network(audioMode.suraLink);
            _initializeVideoPlayerFuture = _controller.initialize();
          });
        }).catchError((error){
          print(error.toString());
        });

        print(qarename);
      });
    });


    suranamedbHelpers.getAllAyatFromAyatTable(widget.ayatNo).then((rows){
      setState(() {
        rows.forEach((row) {
          ayatmodels.add(AyatTableModel.formMap(row));
        });
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:PreferredSize(child: _appBar(),preferredSize: Size(MediaQuery.of(context).size.width, 120),),

        body:
        Container(
          child: ayatmodels.length<=0?
          CircularProgressIndicator():
          Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: ayatmodels.length,
                    itemBuilder: (context,index)=>Card(
                      //    color: ayatmodels.length%2==0?Colors.black.withOpacity(.5):Colors.green.withOpacity(.5),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.green,
                                    width: 2
                                )
                            )
                        ),
                        child: Row(

                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Stack(
                              children: <Widget>[
                                Image.asset("images/ayatnumberIcon.png", height: 40, width: 40, fit: BoxFit.cover,),
                                Container(
                                    width: 40,
                                    height: 40,
                                    alignment: Alignment.center,
                                    child: Text('${ayatmodels[index].ayatno}'))
                              ],
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  arbi?Text('${ayatmodels[index].arbiQuran}', style: TextStyle(color: Colors.black, fontSize: 17),):SizedBox(),
                                  banglameaning?Text('${ayatmodels[index].banglaTranslator}',
                                    style: TextStyle(color: Colors.black54, fontSize: 16),):SizedBox(),
                                  banglauccharon?Text('${ayatmodels[index].banglameaning}',
                                    style: TextStyle(color: Colors.black54, fontSize: 16),):SizedBox()
                                ],

                              ),
                            ),
                          ],
                        ),
                      ),

//                child: ListTile(
////                  title:Text('${ayatmodels[index].arbiQuran}'),
////                  subtitle: Text('${ayatmodels[index].banglaTranslator}'),
////                  leading: Stack(
////                    children: <Widget>[
////                      Image.asset("images/ayatnumberIcon.png", height: 40, width: 40, fit: BoxFit.cover,),
////                      Container(
////                          width: 40,
////                          height:40,
////                          alignment: Alignment.center,
////                          child: Text('${ayatmodels[index].ayatno}'))
////                    ],
////                  )
//////                  CircleAvatar(
//////                    child: Text('${ayatmodels[index].ayatno}'),
//////                  ),
////                ),
                    )),
              ),
              Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.all(8),
                color: Colors.green,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('${audioModels.qareName}',style: TextStyle(color: Colors.white),),
                    IconButton(icon: Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow,color: Colors.white,),onPressed: (){
                      setState(() {
                        _playAudioButtonClick();
                      });
                    },),
                  ],
                ),
              ),
            ],
          ),
        ),

      ),
    );
  }
}
