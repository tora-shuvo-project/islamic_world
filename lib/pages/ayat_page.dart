


import 'dart:ui';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:searchtosu/DataBaseHelper/database_helper.dart';
import 'package:searchtosu/FinalModels/audio_models.dart';
import 'package:searchtosu/FinalModels/sura_name_table_model.dart';
import 'package:searchtosu/utils/utils.dart';


import '../FinalModels/ayat_table_model.dart';

class AyatPage extends StatefulWidget {

  final SuraNameTableModel suraNameTableModel;
  final String qareName;
  AyatPage(this.suraNameTableModel,this.qareName);

  @override
  _AyatPageState createState() => _AyatPageState();
}

class _AyatPageState extends State<AyatPage> {
  Duration duration =  Duration();
  Duration postition = Duration();
  AudioPlayer advancedPlayer,ayatPlayer;
  AudioCache audioCache;
  String localFilePath;
  AudioModels audioModels;
  DatabaseHelper suranamedbHelpers=DatabaseHelper.instance;
  List<AyatTableModel> ayatmodels=new List();
  bool arbi = true;
  bool isPlaying = true;
  bool banglameaning= true;
  bool banglauccharon = true;
  bool isFullScreen=true;
  bool singleAyatplaying = true;

  //VideoPlayerController _controller;
  Utils utils;
  double _value = 17;
  String _fontName;

  void onSubmit(String result) {
    print(result);
    setState(() {
      _fontName=result;
    });
  }



  Widget _appBar(){
    return isFullScreen?
    Container(
      child: ClipRRect(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
        child: Container(
          height:135,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                const Color(0xff178723),
                const Color(0xff27AB4B)
              ])
          ),
          padding: EdgeInsets.symmetric(horizontal: 17,vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[

                    InkWell(
                              onTap:(){
                                Navigator.of(context).pop();
                              },
                              child: Icon(Icons.arrow_back, color: Colors.white,)),
                    Text("بسم الله الرحمن الرحيم", style: TextStyle(color: Colors.white, fontSize: 20)),
                         //
                    Container(
                        child: InkWell(
                            onTap: (){
                              showModalBottomSheet(context: context, builder: (BuildContext context){
                                return Container(
                                  color: Color(0xFF737373),
                                  child: ClipRRect(
                                    clipBehavior: Clip.hardEdge,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(25),
                                        topRight: Radius.circular(25),
                                        bottomLeft: Radius.circular(0),
                                        bottomRight: Radius.circular(0)),
                                    child: Container(
                                      color: Color(0xFFFFFFFF),
                                      height: 500,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: const Radius.circular(10),
                                            topRight: const Radius.circular(10)
                                          )
                                        ),
                                        child: bottomNavbar(),
                                      ),
                                    ),
                                  ),
                                );
                              });
                            },
                            child: Icon(Icons.info,color: Colors.white,)),
                      ),



                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                child:Text( '${widget.suraNameTableModel.banglaTranslator}', style: TextStyle(color: Colors.white, fontSize: 20),) ,
              ),
              SizedBox(height: 13,),
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
                            value:  banglameaning || banglauccharon && arbi ? arbi : arbi=true,
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
                        child: Checkbox(
                            value: banglameaning,
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
                        child: Checkbox(
                            value: banglauccharon,
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
    ):
    Container(
      height:60,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            const Color(0xff178723),
            const Color(0xff27AB4B)
          ])
      ),
      padding: EdgeInsets.symmetric(horizontal: 19,vertical: 16),
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
                Text( '${widget.suraNameTableModel.banglaTranslator}', style: TextStyle(color: Colors.white, fontSize: 20),),

              ],
            ),
          ),
        ],
      ),


    );
  }

  SingleChildScrollView bottomNavbar(){
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(16.0),
            child: Text('সূরা ${widget.suraNameTableModel.banglaTranslator}',style: TextStyle(
                fontSize: 16,
                color: Colors.green
            ),),
          ),
          SizedBox(height: 1,child: Container(color: Colors.green,),),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                Expanded(child: Text('Arabia:',style: TextStyle(
                    fontSize: 18,
                    color: Colors.blueGrey
                ),)),
                Expanded(flex:2,child: Text('${widget.suraNameTableModel.arbiSuraNam}',style: TextStyle(
                    fontSize: 16,
                    color: Colors.green
                ),))
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                Expanded(child: Text('Meaning:',style: TextStyle(
                    fontSize: 18,
                    color: Colors.blueGrey
                ),)),
                Expanded(flex:2,child: Text('${widget.suraNameTableModel.banglaMeaning}',style: TextStyle(
                    fontSize: 16,
                    color: Colors.green
                ),))
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                Expanded(child: Text('Sura No:',style: TextStyle(
                    fontSize: 18,
                    color: Colors.blueGrey
                ),)),
                Expanded(flex:2,child: Text('${widget.suraNameTableModel.suraNo}',style: TextStyle(
                    fontSize: 16,
                    color: Colors.green
                ),))
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                Expanded(child: Text('Total Ayat:',style: TextStyle(
                    fontSize: 18,
                    color: Colors.blueGrey
                ),)),
                Expanded(flex:2,child: Text('${widget.suraNameTableModel.ayatNo}',style: TextStyle(
                    fontSize: 16,
                    color: Colors.green
                ),))
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                Expanded(child: Text('Para:',style: TextStyle(
                    fontSize: 18,
                    color: Colors.blueGrey
                ),)),
                Expanded(flex:2,child: Text('${widget.suraNameTableModel.paraNumber}',style: TextStyle(
                    fontSize: 16,
                    color: Colors.green
                ),))
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                Expanded(child: Text('Obotirno:',style: TextStyle(
                    fontSize: 18,
                    color: Colors.blueGrey
                ),)),
                Expanded(flex:2,child: Text('${widget.suraNameTableModel.obotirno}',style: TextStyle(
                    fontSize: 16,
                    color: Colors.green
                ),))
              ],
            ),
          ),
        ],
      ),
    );
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    utils=Utils();

    utils.getFontNameFromPreference().then((fontName){
      setState(() {
        print(fontName);
        _fontName=fontName;
      });
    });
    print("Ayat Page"+widget.qareName);
    print(widget.suraNameTableModel.suraNo.toString());
    suranamedbHelpers.getAudioBySuraAndQareName(widget.suraNameTableModel.suraNo, widget.qareName)
        .then((audioMode){
      setState(() {
        audioModels=AudioModels();
        print(audioMode);
        utils=Utils();
        ayatPlayer = AudioPlayer();
        advancedPlayer = AudioPlayer();
        audioCache = AudioCache(fixedPlayer: advancedPlayer);
        advancedPlayer.durationHandler =(d)=> setState((){

          duration = d;
        });
        advancedPlayer.positionHandler =(p)=> setState((){

          postition = p;
        });
        setState(() {
          audioModels=audioMode;
//        _controller = VideoPlayerController.network(audioMode.suraLink);
//        _initializeVideoPlayerFuture = _controller.initialize();
        });

      });
    }).catchError((error){
      print(error.toString());

    });

    suranamedbHelpers.getAllAyatFromAyatTable(widget.suraNameTableModel.suraNo).then((rows){
      setState(() {
        rows.forEach((row) {
          ayatmodels.add(AyatTableModel.formMap(row));
        });
      });
    });

  }

  Widget slider(){
    return Container(
      width: 100,
      child: Slider(
        activeColor: Color(0xff178723),
        inactiveColor: Colors.white,
        value: postition.inSeconds.toDouble(),
        min: 0.0,
        max: duration.inSeconds.toDouble(),
        onChanged: (double value){
          setState(() {

            seekToSecond(value.toInt());
            value= value;
          });
        },
      ),
    );
  }
  void seekToSecond(int second){
    Duration newDuration = Duration(seconds: second);
    advancedPlayer.seek(newDuration);

  }

  @override
  Widget build(BuildContext context) {



    return SafeArea(
      child: Scaffold(
        appBar:PreferredSize(child: _appBar(),preferredSize: Size(MediaQuery.of(context).size.width, 135),),

        body:Container(
            child: ayatmodels.length<=0?
            CircularProgressIndicator():
            Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[

                    Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: ayatmodels.length,
                          itemBuilder: (context,index)=>Card(
                            //    color: ayatmodels.length%2==0?Colors.black.withOpacity(.5):Colors.green.withOpacity(.5),
                            child: Container(child: InkWell(
//                                onTap: (){
//                                  advancedPlayer.play(ayatmodels[index].ayatAudio.trim());
//                                  setState(() {
//                                    isPlaying = false;
//                                  });
//                                },
                                child: Column(
                                  children: <Widget>[
                                    Row(

                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Column(
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
                                            ayatmodels[index].sejda == "0"?Container(): Text("সিজদা", style: TextStyle(fontSize: 14, color: Colors.red),),
                                            IconButton(icon: Icon(Icons.volume_down ,color: Colors.black45,), onPressed: (){

                                               ayatPlayer.play(ayatmodels[index].ayatAudio.trim());



                                            })
                                          ],
                                        ),
                                        SizedBox(width: 10,),
                                        Expanded(
                                          child: Column(
                                            children: <Widget>[
                                              arbi?Text('${ayatmodels[index].arbi_indopak.trim()}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: _fontName,
                                                    fontSize: _value+6),
                                              ):SizedBox(),
                                              banglameaning?Text('${ayatmodels[index].banglaTranslator.trim()}',
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontFamily: _fontName,
                                                    fontSize: _value-1),):SizedBox(),
                                              banglauccharon?Text('${ayatmodels[index].banglameaning.trim()}',
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontFamily: _fontName,
                                                    fontSize: _value-1),):SizedBox()
                                            ],

                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                        height: 3,
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(colors: [
                                              const Color(0xffffffff),
                                              const Color(0xff178723),
                                              const Color(0xffffffff),
                                            ]))
                                    )
                                  ],
                                ),
                              ),
                            ),

                          )),
                    ),
                    isFullScreen?
                    Container(
                      height: 60,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.all(8),
                      color: Colors.green,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(flex:3,child: Text('${widget.qareName}',style: TextStyle(color: Colors.white),)),
                          Expanded(flex:2,child: slider()),
                          Expanded(
                            child: IconButton(icon: Icon(isPlaying ? Icons.play_arrow : Icons.pause,color: Colors.white,),onPressed: (){
                              setState(() {
                                if(isPlaying){
                                  advancedPlayer.play(audioModels.suraLink.trim());

                                  setState(() {
                                    isPlaying = false;
                                  });
                                }else{
                                  advancedPlayer.pause();

                                  setState(() {
                                    isPlaying = true;
                                  });
                                }
                              });
                            },),
                          ),

                          Expanded(
                            child: IconButton(icon: Icon(Icons.stop, color: Colors.white,), onPressed: (){
                              advancedPlayer.stop();
                              setState(() {
                                isPlaying = true;
                              });
                            }),
                          ),
                          Expanded(
                            child: PopupMenuButton(
                                icon: Icon(Icons.more_vert, color: Colors.white,),
                                onSelected: (value){
                                  if(value == 0){
                                    //go to profile menu
                                  }
                                  else if(value==1){
                                    advancedPlayer.setPlaybackRate( playbackRate:  0.25);
                                  }
                                  else if(value==2){
                                    advancedPlayer.setPlaybackRate( playbackRate:  0.5);
                                  }
                                  else if(value==3){
                                    advancedPlayer.setPlaybackRate( playbackRate:  .75);
                                  }
                                  else if(value==4){
                                    advancedPlayer.setPlaybackRate( playbackRate:  1.0);
                                  }
                                  else if(value==5){
                                    advancedPlayer.setPlaybackRate( playbackRate:  1.25);
                                  }
                                  else if(value==6){
                                    advancedPlayer.setPlaybackRate( playbackRate:  1.5);
                                  }
                                  else if(value==7){
                                    advancedPlayer.setPlaybackRate( playbackRate:  2.0);
                                  }
                                }
                                ,
                                itemBuilder: (context)=>[
                                  PopupMenuItem(
                                    child: Text('Speed'),
                                    value: 0,
                                  ),
                                  PopupMenuItem(
                                    child: Text('0.25'),
                                    value: 1,
                                  ),
                                  PopupMenuItem(
                                    child: Text('0.5'),
                                    value: 2,
                                  ),
                                  PopupMenuItem(
                                    child: Text('.75'),
                                    value: 3,
                                  ),
                                  PopupMenuItem(
                                    child: Text('Normal'),
                                    value: 4,
                                  ),
                                  PopupMenuItem(
                                    child: Text('1.25'),
                                    value: 5,
                                  ),
                                  PopupMenuItem(
                                    child: Text('1.5'),
                                    value: 6,
                                  ),
                                  PopupMenuItem(
                                    child: Text('2.0'),
                                    value: 7,
                                  ),

                                ]),
                          ),

                        ],
                      ),
                    ):
                    Container(),
                  ],
                ),
                Positioned(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 100),
                      child: SpeedDial(
                        animatedIcon: AnimatedIcons.menu_close,
                        animatedIconTheme: IconThemeData(size: 22.0),
                        // this is ignored if animatedIcon is non null
                        // child: Icon(Icons.add),
                        curve: Curves.bounceIn,
                        overlayColor: Colors.green,
                        overlayOpacity: 0.0,
                        backgroundColor: Colors.green,
                        onOpen: () => print('OPENING DIAL'),
                        onClose: () => print('DIAL CLOSED'),
                        tooltip: 'Speed Dial',
                        heroTag: 'speed-dial-hero-tag',
                        elevation: 8.0,
                        shape: CircleBorder(),
                        children: [
                          SpeedDialChild(
                              labelBackgroundColor: Colors.green,
                              child: Icon(Icons.bubble_chart),
                              backgroundColor: Colors.green,
                              label: 'আরবি ফন্ট',
                              labelStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                              onTap: () {
                                showDialog(context: context, builder: (context) => MyForm(onSubmit: onSubmit));
                              }
                          ),
                          SpeedDialChild(
                            labelBackgroundColor: Colors.green,
                            child: Icon(Icons.font_download),
                            backgroundColor: Colors.green,
                            label: 'ফন্ট সাইজ',
                            labelStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                            onTap: () {
                              showModalBottomSheet(context: context, builder: (BuildContext context){
                                return Container(
                                    height: 80.0,
                                    color: Colors.green.withOpacity(.9),
                                    child: Center(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[

                                          Row(
                                            children: <Widget>[
                                              Expanded(
                                                  flex:4,
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text('Change Font Size',style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.white
                                                    ),),
                                                  )),
                                              Expanded(
                                                child: IconButton(
                                                  icon: Icon(Icons.remove_circle,color: Colors.white,size: 30,),
                                                  onPressed: (){
                                                    setState(() {
                                                      _value--;
                                                    });
                                                  },
                                                ),
                                              ),
                                              Expanded(
                                                child: IconButton(
                                                  icon: Icon(Icons.add_circle,color: Colors.white,size: 30,),
                                                  onPressed: (){
                                                    setState(() {
                                                      _value++;
                                                    });
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                );
                              });
                            },
                          ),
                          SpeedDialChild(
                            labelBackgroundColor: Colors.green,
                            child: Icon(Icons.fullscreen),
                            backgroundColor: Colors.green,
                            label: isFullScreen?'সম্পূর্ন স্ক্রিন':'সম্পূর্ন স্ক্রিন বন্ধ করুন',
                            labelStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                            onTap: (){
                              setState(() {
                                isFullScreen=!isFullScreen;
                              });
                            },
                          ),
                        ],
                      ),
                    )
                ),
              ],
            )
        ),
      ),
    );
  }

}

typedef void MyFormCallback(String result);
class MyForm extends StatefulWidget {
  final MyFormCallback onSubmit;

  MyForm({this.onSubmit});

  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  String value;

  Utils utils;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    utils=Utils();
    utils.getFontNameFromPreference().then((fontname) {
      setState(() {
        value=fontname;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text("আরবি ফন্ট সিলেক্ট করুন-"),
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 10,right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(flex: 2,child: Text('Maddina')),
              Expanded(
                child: Radio(
                  groupValue: value,
                  activeColor: Colors.green,
                  onChanged: (value) => setState(() {
                    this.value = value;
                    Navigator.pop(context);
                    widget.onSubmit(value);
                    utils.saveFontNameFromPreference(value);
                  }),
                  value: "Maddina",
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 10,right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(flex: 2,child: Text('Monserat')),
              Expanded(
                child: Radio(
                  groupValue: value,
                  activeColor: Colors.green,
                  onChanged: (value) => setState((){
                    this.value = value;
                    Navigator.pop(context);
                    widget.onSubmit(value);
                    utils.saveFontNameFromPreference(value);
                  } ),
                  value: "Monserat",
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 10,right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(flex: 2,child: Text('Mukadimah')),
              Expanded(
                child: Radio(
                  groupValue: value,
                  activeColor: Colors.green,
                  onChanged: (value) => setState((){
                    this.value = value;
                    Navigator.pop(context);
                    widget.onSubmit(value);
                    utils.saveFontNameFromPreference(value);
                  } ),
                  value: "Mukadimah",
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 10,right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(flex: 2,child: Text('QalamMajid')),
              Expanded(
                child: Radio(
                  groupValue: value,
                  activeColor: Colors.green,
                  onChanged: (value) => setState((){
                    this.value = value;
                    Navigator.pop(context);
                    widget.onSubmit(value);
                    utils.saveFontNameFromPreference(value);
                  } ),
                  value: "QalamMajid",
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 10,right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(flex: 2,child: Text('utman')),
              Expanded(
                child: Radio(
                  groupValue: value,
                  activeColor: Colors.green,
                  onChanged: (value) => setState((){
                    this.value = value;
                    Navigator.pop(context);
                    widget.onSubmit(value);
                    utils.saveFontNameFromPreference(value);
                  } ),
                  value: "utman",
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

