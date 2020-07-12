import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:searchtosu/FinalModels/quran_word_models.dart';
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';

class QuranWordPagesDetailsScreen extends StatefulWidget {

  final QuranWordModels quranWordModels;
  QuranWordPagesDetailsScreen(this.quranWordModels);

  @override
  _QuranWordPagesDetailsScreenState createState() => _QuranWordPagesDetailsScreenState();
}

class _QuranWordPagesDetailsScreenState extends State<QuranWordPagesDetailsScreen> {


  File mydirectoryFile;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  initState() {
    super.initState();
    createFile(widget.quranWordModels.image_url).then((sourchfile) {
      setState(() {
        mydirectoryFile=sourchfile;
      });
    });
  }



  Future<File> createFile(String url) async {

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');

        try {
          /// setting filename
          final filename = 'quran_word${widget.quranWordModels.serial_no}.png';

          /// getting application doc directory's path in dir variable
          String dir = (await getExternalStorageDirectory()).path;

          /// if `filename` File exists in local system then return that file.
          /// This is the fastest among all.
          if (await File('$dir/$filename').exists()) {
            print('$dir/$filename');
            return File('$dir/$filename');
          }


          ///if file not present in local system then fetch it from server
          String url = 'https://scontent.fdac2-1.fna.fbcdn.net/v/t1.0-9/p720x720/66375370_10217665736251812_7974606507381620736_o.jpg?_nc_cat=105&_nc_sid=32a93c&_nc_eui2=AeG3B6ISDfoKoE3SzURhiCKnUhKGw8lJaXVSEobDyUlpdbTuNYEkSxcDxcj29XiGQawdEvn_ZRLq3uPpOhIJx88j&_nc_ohc=FwHSO_3QsoAAX8qswaL&_nc_ht=scontent.fdac2-1.fna&_nc_tp=6&oh=ca7b69e18e2f3a99712d54be0a0e24c2&oe=5F2CED4B';

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

          /// returning file.
          return file;
        }

        /// on catching Exception return null
        catch (err) {
          print(err);
          Scaffold.of(context).showSnackBar(new SnackBar(
            content: new Text('Hello!'),
          ));
          return null;
        }


      }
    } on SocketException catch (_) {
      print('not connected');
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.withOpacity(.8),
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Task ${widget.quranWordModels.taskNumber}'),
      ),
      body:Center(
        child: mydirectoryFile!=null?
        ZoomableWidget(child: Container(
            width: double.infinity,
            child: Image.file(mydirectoryFile,width: double.infinity,height: double.infinity,)
        ),)
            :CircularProgressIndicator(),
      )
    );
  }
}

class ZoomableWidget extends StatefulWidget {
  final Widget child;

  const ZoomableWidget({Key key, this.child}) : super(key: key);
  @override
  _ZoomableWidgetState createState() => _ZoomableWidgetState();
}

class _ZoomableWidgetState extends State<ZoomableWidget> {
  Matrix4 matrix = Matrix4.identity();


  @override
  Widget build(BuildContext context) {
    return MatrixGestureDetector(
      onMatrixUpdate: (Matrix4 m, Matrix4 tm, Matrix4 sm, Matrix4 rm) {
        setState(() {
          matrix = m;
        });
      },
      child: Transform(
        transform: matrix,
        child: widget.child,
      ),
    );
  }
}