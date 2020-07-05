

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:searchtosu/DataBaseHelper/database_helper.dart';
import 'package:searchtosu/FinalModels/audio_models.dart';
import 'package:searchtosu/FinalModels/sura_name_table_model.dart';
import 'package:searchtosu/utils/utils.dart';
import 'package:video_player/video_player.dart';

import '../FinalModels/ayat_table_model.dart';

class AyatPage extends StatefulWidget {

  final SuraNameTableModel suraNameTableModel;
  AyatPage(this.suraNameTableModel);

  @override
  _AyatPageState createState() => _AyatPageState();
}

class _AyatPageState extends State<AyatPage> {

  DatabaseHelper suranamedbHelpers=DatabaseHelper.instance;
  List<AyatTableModel> ayatmodels=new List();
  bool arbi = true;
  bool banglameaning= true;
  bool banglauccharon = true;
  bool isFullScreen=true;

  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;
  Utils utils;
  AudioModels audioModels;
  double _value = 17;

  _playAudioButtonClick(){

    if (_controller.value.isPlaying) {
      _controller.pause();
    } else {
      _controller.play();
    }
  }


  Widget _appBar(){
    return isFullScreen?
    Container(
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
          padding: EdgeInsets.symmetric(horizontal: 17,vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                      child: Row(
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
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                            onTap: (){
                              showModalBottomSheet(context: context, builder: (BuildContext context){
                                return Container(
                                  height: 460,
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
                              });
                            },
                            child: Icon(Icons.info,color: Colors.white,)),
                      ),
                    ),


                  ],
                ),
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
        suranamedbHelpers.getAudioBySuraAndQareName(widget.suraNameTableModel.suraNo, qarename).then((audioMode){
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


    suranamedbHelpers.getAllAyatFromAyatTable(widget.suraNameTableModel.suraNo).then((rows){
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
                                      arbi?Text('${ayatmodels[index].arbiQuran}', style: TextStyle(color: Colors.black, fontSize: _value),):SizedBox(),
                                      banglameaning?Text('${ayatmodels[index].banglaTranslator}',
                                        style: TextStyle(color: Colors.black54, fontSize: _value),):SizedBox(),
                                      banglauccharon?Text('${ayatmodels[index].banglameaning}',
                                        style: TextStyle(color: Colors.black54, fontSize: _value),):SizedBox()
                                    ],

                                  ),
                                ),
                              ],
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
                        Text('${audioModels.qareName}',style: TextStyle(color: Colors.white),),
                        IconButton(icon: Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow,color: Colors.white,),onPressed: (){
                          setState(() {
                            _playAudioButtonClick();
                          });
                        },),
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
                            onTap: () => print('FIRST CHILD')
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
