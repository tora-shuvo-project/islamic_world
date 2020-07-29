import 'dart:io';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:toast/toast.dart';

class Labbayekallahumma_screen extends StatefulWidget {
  @override
  _Labbayekallahumma_screenState createState() => _Labbayekallahumma_screenState();
}

class _Labbayekallahumma_screenState extends State<Labbayekallahumma_screen> {

  File mydirectoryFile;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String link1='https://duetinmehedi.000webhostapp.com/wp-content/uploads/2020/07/labbaik-1.mp3';
  String link2='https://duetinmehedi.000webhostapp.com/wp-content/uploads/2020/07/labbaik-2.mp3';
  String link3='https://duetinmehedi.000webhostapp.com/wp-content/uploads/2020/07/labbaik-3.mp3';
  String link4='https://duetinmehedi.000webhostapp.com/wp-content/uploads/2020/07/labbaik-4.mp3';
  String link5='https://duetinmehedi.000webhostapp.com/wp-content/uploads/2020/07/labbaik-5.mp3';
  String link6='https://duetinmehedi.000webhostapp.com/wp-content/uploads/2020/07/labbaik-6.mp3';
  String link7='https://duetinmehedi.000webhostapp.com/wp-content/uploads/2020/07/labbaik-7.mp3';
  String link8='https://duetinmehedi.000webhostapp.com/wp-content/uploads/2020/07/itri_tekbir.mp3';

  String link='https://duetinmehedi.000webhostapp.com/wp-content/uploads/2020/07/labbaik-1.mp3';
  int slno1=1,slno2=2,slno3=3,slno4=4,slno5=5,slno6=6,slno7=7,slno8=8;
  int slNO=1;
  String nameAudio='লাব্বাইক ভয়েস-১';
  bool isOpen1=true,isOpen2=false,isOpen3=false,isOpen4=false,isOpen5=false,isOpen6=false,isOpen7=false,isOpen8=false;

  bool isPlaying = true;
  Duration duration =  Duration();
  Duration postition = Duration();
  AudioPlayer advancedPlayer;
  AudioCache audioCache;
  double _percentage=0.0;
  String downloadMessahge='';
  bool isDownload=true;

  @override
  void dispose() {
    super.dispose();
    advancedPlayer.pause();
    advancedPlayer.stop();
    advancedPlayer.dispose();
  }


  _playAudioANdDownload()async{
    final filename = 'labbaikallahummaaudio_${slNO}.mp3';

    /// getting application doc directory's path in dir variable
    String dir = (await getExternalStorageDirectory()).path;

    /// if `filename` File exists in local system then return that file.
    /// This is the fastest among all.

    Dio dio=Dio();
    if (await File('$dir/$filename').exists()) {
      print('$dir/$filename');

      setState(() {

        if(isPlaying){

          advancedPlayer.play('$dir/$filename');
          setState(() {
            isPlaying = false;
            audioCache.loop('$dir/$filename');
            audioCache.fixedPlayer.onPlayerCompletion.forEach((_) {
              advancedPlayer.play('$dir/$filename');
            });
          });
        }else{
          advancedPlayer.pause();
          setState(() {
            isPlaying = true;

          });
        }

      });


    }else {
      return await dio.download('${link}',
          '${dir}/${filename}',
          onReceiveProgress: (actualbytes, totalbytes) {
            var percentage = actualbytes / totalbytes * 100;
            if (percentage <= 100) {
              _percentage = percentage / 100;
              isDownload=false;
              setState(() {
                downloadMessahge = 'Downloading.......${percentage.floor()}';
                if (percentage == 100) {
                  isDownload = true;
                  return setState(() {

                    if(isPlaying){

                      advancedPlayer.play('$dir/$filename');
                      setState(() {
                        isPlaying = false;
                        audioCache.loop('$dir/$filename');
                        audioCache.fixedPlayer.onPlayerCompletion.forEach((_) {
                          advancedPlayer.play('$dir/$filename');
                        });
                      });
                    }else{
                      advancedPlayer.pause();
                      setState(() {
                        isPlaying = true;

                      });
                    }

                  });

                }
              });
            }

            Toast.show(downloadMessahge, context);
          }
      ).catchError((error) {
        print('Shuvo');
        _scaffoldKey.currentState.showSnackBar(
            new SnackBar(
                backgroundColor: Colors.red,
                elevation: 2,
                duration: Duration(seconds: 5),
                content: Text(
                  'Please check your internet connection first time it download for you from server \'Thanks',
                  style: TextStyle(
                    color: Colors.white,
                  ),)
            )
        );
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    advancedPlayer = AudioPlayer();
    audioCache = AudioCache(fixedPlayer: advancedPlayer);
    advancedPlayer.durationHandler =(d)=> setState((){

      duration = d;
    });
    advancedPlayer.positionHandler =(p)=> setState((){

      postition = p;
    });

  }

  Widget seekaudio(){
    return PopupMenuButton(
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

        ]);
  }
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
            color: Colors.green.withOpacity(.1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(icon: Icon(Icons.arrow_back, color: Colors.white,), onPressed: (){
                  Navigator.of(context).pop();
                }),
                FittedBox(
                  child: Text('লাব্বাইকাল-লাহুম্মা-লাব্বাইক',style:  TextStyle(
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

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      appBar:PreferredSize(child: _appBar(),preferredSize: Size(MediaQuery.of(context).size.width, 120),),
        body: Column(
          children: <Widget>[
            Expanded(
              child: ListView(children: <Widget>[
                Container(
                  color: Colors.green,
                  padding: EdgeInsets.only(left: 10),
                  child: InkWell(
                    onTap: (){
                      setState(() {
                        advancedPlayer.stop();
                        link=link1;
                        nameAudio='লাব্বাইক ভয়েস-১';
                        slNO=1;
                        isOpen1=true;
                        isOpen2=false;
                        isOpen3=false;
                        isOpen4=false;
                        isOpen5=false;
                        isOpen6=false;
                        isOpen7=false;
                        isOpen8=false;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(flex:3,child: Text('লাব্বাইক ভয়েস-১',style: TextStyle(color: Colors.white,fontSize: 18),)),
                        Expanded(
                          child: IconButton(
                            icon: Icon(isOpen1&&!isOpen2&&!isOpen3&&!isOpen4&&!isOpen5&&!isOpen6&&!isOpen7&&!isOpen8?
                            Icons.pause:
                            Icons.play_circle_filled,
                              color: Colors.white,),
                            onPressed: (){
                              setState(() {
                                advancedPlayer.stop();
                                link=link1;
                                nameAudio='লাব্বাইক ভয়েস-১';
                                slNO=1;
                                isOpen1=true;
                                isOpen2=false;
                                isOpen3=false;
                                isOpen4=false;
                                isOpen5=false;
                                isOpen6=false;
                                isOpen7=false;
                                isOpen8=false;
                              });
                            },),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 2,child: Container(color: Colors.blueGrey.withOpacity(.3),),),

                Container(
                  color: Colors.green,
                  padding: EdgeInsets.only(left: 10),
                  child: InkWell(
                    onTap: (){
                      setState(() {
                        advancedPlayer.stop();
                        link=link2;
                        nameAudio='লাব্বাইক ভয়েস-২';
                        slNO=2;
                        isOpen1=false;
                        isOpen2=true;
                        isOpen3=false;
                        isOpen4=false;
                        isOpen5=false;
                        isOpen6=false;
                        isOpen7=false;
                        isOpen8=false;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(flex:3,child: Text('লাব্বাইক ভয়েস-২',style: TextStyle(color: Colors.white,fontSize: 18),)),
                        Expanded(
                          child: IconButton(
                            icon: Icon(!isOpen1&&isOpen2&&!isOpen3&&!isOpen4&&!isOpen5&&!isOpen6&&!isOpen7&&!isOpen8?
                            Icons.pause:
                            Icons.play_circle_filled,
                              color: Colors.white,),
                            onPressed: (){
                              setState(() {
                                advancedPlayer.stop();
                                link=link2;
                                nameAudio='লাব্বাইক ভয়েস-২';
                                slNO=2;
                                isOpen1=false;
                                isOpen2=true;
                                isOpen3=false;
                                isOpen4=false;
                                isOpen5=false;
                                isOpen6=false;
                                isOpen7=false;
                                isOpen8=false;
                              });
                            },),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 2,child: Container(color: Colors.blueGrey.withOpacity(.3),),),

                Container(
                  color: Colors.green,
                  padding: EdgeInsets.only(left: 10),
                  child: InkWell(
                    onTap: (){
                      setState(() {
                        advancedPlayer.stop();
                        link=link3;
                        nameAudio='লাব্বাইক ভয়েস-৩';
                        slNO=3;
                        isOpen1=false;
                        isOpen2=false;
                        isOpen3=true;
                        isOpen4=false;
                        isOpen5=false;
                        isOpen6=false;
                        isOpen7=false;
                        isOpen8=false;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(flex:3,child: Text('লাব্বাইক ভয়েস-৩',style: TextStyle(color: Colors.white,fontSize: 18),)),
                        Expanded(
                          child: IconButton(
                            icon: Icon(!isOpen1&&!isOpen2&&isOpen3&&!isOpen4&&!isOpen5&&!isOpen6&&!isOpen7&&!isOpen8?
                            Icons.pause:
                            Icons.play_circle_filled,
                              color: Colors.white,),
                            onPressed: (){
                              setState(() {
                                advancedPlayer.stop();
                                link=link3;
                                nameAudio='লাব্বাইক ভয়েস-৩';
                                slNO=3;
                                isOpen1=false;
                                isOpen2=false;
                                isOpen3=true;
                                isOpen4=false;
                                isOpen5=false;
                                isOpen6=false;
                                isOpen7=false;
                                isOpen8=false;
                              });
                            },),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 2,child: Container(color: Colors.blueGrey.withOpacity(.3),),),

                Container(
                  color: Colors.green,
                  padding: EdgeInsets.only(left: 10),
                  child: InkWell(
                    onTap: (){
                      setState(() {
                        advancedPlayer.stop();
                        link=link4;
                        nameAudio='লাব্বাইক ভয়েস-৪';
                        slNO=4;
                        isOpen1=false;
                        isOpen2=false;
                        isOpen3=false;
                        isOpen4=true;
                        isOpen5=false;
                        isOpen6=false;
                        isOpen7=false;
                        isOpen8=false;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(flex:3,child: Text('লাব্বাইক ভয়েস-৪',style: TextStyle(color: Colors.white,fontSize: 18),)),
                        Expanded(
                          child: IconButton(
                            icon: Icon(!isOpen1&&!isOpen2&&!isOpen3&&isOpen4&&!isOpen5&&!isOpen6&&!isOpen7&&!isOpen8?
                            Icons.pause:
                            Icons.play_circle_filled,
                              color: Colors.white,),
                            onPressed: (){
                              setState(() {
                                advancedPlayer.stop();
                                link=link4;
                                nameAudio='লাব্বাইক ভয়েস-৪';
                                slNO=4;
                                isOpen1=false;
                                isOpen2=false;
                                isOpen3=false;
                                isOpen4=true;
                                isOpen5=false;
                                isOpen6=false;
                                isOpen7=false;
                                isOpen8=false;
                              });
                            },),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 2,child: Container(color: Colors.blueGrey.withOpacity(.3),),),

                Container(
                  color: Colors.green,
                  padding: EdgeInsets.only(left: 10),
                  child: InkWell(
                    onTap: (){
                      setState(() {
                        advancedPlayer.stop();
                        link=link5;
                        nameAudio='লাব্বাইক ভয়েস-৫';
                        slNO=5;
                        isOpen1=false;
                        isOpen2=false;
                        isOpen3=false;
                        isOpen4=false;
                        isOpen5=true;
                        isOpen6=false;
                        isOpen7=false;
                        isOpen8=false;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(flex:3,child: Text('লাব্বাইক ভয়েস-৫',style: TextStyle(color: Colors.white,fontSize: 18),)),
                        Expanded(
                          child: IconButton(
                            icon: Icon(!isOpen1&&!isOpen2&&!isOpen3&&!isOpen4&&isOpen5&&!isOpen6&&!isOpen7&&!isOpen8?
                            Icons.pause:
                            Icons.play_circle_filled,
                              color: Colors.white,),
                            onPressed: (){
                              setState(() {
                                advancedPlayer.stop();
                                link=link5;
                                nameAudio='লাব্বাইক ভয়েস-৫';
                                slNO=5;
                                isOpen1=false;
                                isOpen2=false;
                                isOpen3=false;
                                isOpen4=false;
                                isOpen5=true;
                                isOpen6=false;
                                isOpen7=false;
                                isOpen8=false;
                              });
                            },),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 2,child: Container(color: Colors.blueGrey.withOpacity(.3),),),

                Container(
                  color: Colors.green,
                  padding: EdgeInsets.only(left: 10),
                  child: InkWell(
                    onTap: (){
                      setState(() {
                        advancedPlayer.stop();
                        link=link6;
                        nameAudio='লাব্বাইক ভয়েস-৬';
                        slNO=6;
                        isOpen1=false;
                        isOpen2=false;
                        isOpen3=false;
                        isOpen4=false;
                        isOpen5=false;
                        isOpen6=true;
                        isOpen7=false;
                        isOpen8=false;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(flex:3,child: Text('লাব্বাইক ভয়েস-৬',style: TextStyle(color: Colors.white,fontSize: 18),)),
                        Expanded(
                          child: IconButton(
                            icon: Icon(!isOpen1&&!isOpen2&&!isOpen3&&!isOpen4&&!isOpen5&&isOpen6&&!isOpen7&&!isOpen8?
                            Icons.pause:
                            Icons.play_circle_filled,
                              color: Colors.white,),
                            onPressed: (){
                              setState(() {
                                advancedPlayer.stop();
                                link=link6;
                                nameAudio='লাব্বাইক ভয়েস-৬';
                                slNO=6;
                                isOpen1=false;
                                isOpen2=false;
                                isOpen3=false;
                                isOpen4=false;
                                isOpen5=false;
                                isOpen6=true;
                                isOpen7=false;
                                isOpen8=false;
                              });
                            },),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 2,child: Container(color: Colors.blueGrey.withOpacity(.3),),),

                Container(
                  color: Colors.green,
                  padding: EdgeInsets.only(left: 10),
                  child: InkWell(
                    onTap: (){
                      setState(() {
                        advancedPlayer.stop();
                        link=link7;
                        nameAudio='লাব্বাইক ভয়েস-৭';
                        slNO=7;
                        isOpen1=false;
                        isOpen2=false;
                        isOpen3=false;
                        isOpen4=false;
                        isOpen5=false;
                        isOpen6=false;
                        isOpen7=true;
                        isOpen8=false;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(flex:3,child: Text('লাব্বাইক ভয়েস-৭',style: TextStyle(color: Colors.white,fontSize: 18),)),
                        Expanded(
                          child: IconButton(
                            icon: Icon(!isOpen1&&!isOpen2&&!isOpen3&&!isOpen4&&!isOpen5&&!isOpen6&&isOpen7&&!isOpen8?
                            Icons.pause:
                            Icons.play_circle_filled,
                              color: Colors.white,),
                            onPressed: (){
                              setState(() {
                                advancedPlayer.stop();
                                link=link7;
                                nameAudio='লাব্বাইক ভয়েস-৭';
                                slNO=7;
                                isOpen1=false;
                                isOpen2=false;
                                isOpen3=false;
                                isOpen4=false;
                                isOpen5=false;
                                isOpen6=false;
                                isOpen7=true;
                                isOpen8=false;
                              });
                            },),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 2,child: Container(color: Colors.blueGrey.withOpacity(.3),),),

                Container(
                  color: Colors.green,
                  padding: EdgeInsets.only(left: 10),
                  child: InkWell(
                    onTap: (){
                      setState(() {
                        advancedPlayer.stop();
                        link=link8;
                        nameAudio='ইতরি তাকবীর';
                        slNO=8;
                        isOpen1=false;
                        isOpen2=false;
                        isOpen3=false;
                        isOpen4=false;
                        isOpen5=false;
                        isOpen6=false;
                        isOpen7=false;
                        isOpen8=true;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(flex:3,child: Text('ইতরি তাকবীর',style: TextStyle(color: Colors.white,fontSize: 18),)),
                        Expanded(
                          child: IconButton(
                            icon: Icon(!isOpen1&&!isOpen2&&!isOpen3&&!isOpen4&&!isOpen5&&!isOpen6&&!isOpen7&&isOpen8?
                            Icons.pause:
                            Icons.play_circle_filled,
                              color: Colors.white,),
                            onPressed: (){
                              setState(() {
                                advancedPlayer.stop();
                                link=link8;
                                nameAudio='ইতরি তাকবীর';
                                slNO=8;
                                isOpen1=false;
                                isOpen2=false;
                                isOpen3=false;
                                isOpen4=false;
                                isOpen5=false;
                                isOpen6=false;
                                isOpen7=false;
                                isOpen8=true;
                              });
                            },),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 2,child: Container(color: Colors.blueGrey.withOpacity(.3),),),

              ],),
            ),
            Container(
              height: 70,
              color: Colors.green,
              padding: EdgeInsets.only(left: 10,top: 10),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(flex:3,child: Text(nameAudio,style: TextStyle(color: Colors.white),)),
                      Expanded(flex:2,child: slider()),
                      Expanded(
                        child: IconButton(
                          icon: Icon(isPlaying ?
                          Icons.play_arrow :
                          Icons.pause,color: Colors.white,),
                          onPressed: (){
                            _playAudioANdDownload();
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
                  isDownload?Container(height: 0,):Container(
                    height: 2,
                    padding: EdgeInsets.only(left: 10,right: 10),
                    child: LinearProgressIndicator(value:_percentage,backgroundColor: Colors.white,),
                  ),
                ],
              )

            ),
          ],
        ),
    );
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

}
