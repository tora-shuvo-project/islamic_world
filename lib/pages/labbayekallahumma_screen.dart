import 'dart:io';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
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

  @override
  void dispose() {
    super.dispose();
    advancedPlayer.pause();
    advancedPlayer.stop();
    advancedPlayer.dispose();
  }



  Future<String> createFile(String url) async {

    try {
      /// setting filename
      final filename = 'labbaikallahummaaudio_${slNO}.mp3';

      /// getting application doc directory's path in dir variable
      String dir = (await getExternalStorageDirectory()).path;

      /// if `filename` File exists in local system then return that file.
      /// This is the fastest among all.
      if (await File('$dir/$filename').exists()) {
        print('$dir/$filename');
        return '$dir/$filename';
      }



      print('Downloading.....');
      Toast.show('Downloading........', context,duration: 1,gravity: Toast.CENTER);


      ///if file not present in local system then fetch it from server
      //String url = 'https://pbs.twimg.com/profile_images/973421479508328449/sEeIJkXq.jpg';

      /// requesting http to get url
      var request = await HttpClient().getUrl(Uri.parse(url));


      /// closing request and getting response
      var response = await request.close();

      /// getting response data in bytes
      var bytes = await consolidateHttpClientResponseBytes(response);

      /// generating a local system file with name as 'filename' and path as '$dir/$filename'
      File file = new File('$dir/$filename');

      /// writing bytes data of response in the file.
      await file.writeAsBytes(bytes);

      Toast.show('Download complete Please Tab play button', context,duration: 2,gravity: Toast.CENTER);
      /// returning file.
      return file.toString();
    }

    /// on catching Exception return null
    catch (err) {
      print(err);
      _scaffoldKey.currentState.showSnackBar(
          new SnackBar(
              backgroundColor: Colors.green,
              elevation: 2,
              duration: Duration(seconds: 5),
              content: Text('Please check your internet connection first time it download for you from server \'Thanks',style: TextStyle(
                color: Colors.white,
              ),)
          )
      );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('লাব্বাইকাল-লাহুম্মা-লাব্বাইক'),
      ),
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
              padding: EdgeInsets.only(left: 10),
              child: Row(
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
                      setState(() {

                        createFile('${link}').then((value){
                          setState(() {

                            if(isPlaying){

                              advancedPlayer.play(value);
                              setState(() {
                                isPlaying = false;
                                audioCache.loop(value);
                                audioCache.fixedPlayer.onPlayerCompletion.forEach((_) {
                                  advancedPlayer.play(value);
                                });
                              });
                            }else{
                              advancedPlayer.pause();
                              setState(() {
                                isPlaying = true;

                              });
                            }

                          });
                        });
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
