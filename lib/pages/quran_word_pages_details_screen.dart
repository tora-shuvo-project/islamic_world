import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:searchtosu/FinalModels/quran_word_models.dart';
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';

class QuranWordPagesDetailsScreen extends StatefulWidget {

  final QuranWordModels quranWordModels;
  final int slno;
  QuranWordPagesDetailsScreen(this.quranWordModels,this.slno);

  @override
  _QuranWordPagesDetailsScreenState createState() => _QuranWordPagesDetailsScreenState();
}

class _QuranWordPagesDetailsScreenState extends State<QuranWordPagesDetailsScreen> {


  File mydirectoryFile;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  initState() {
    super.initState();

    print(widget.slno.toString());

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
          final filename = 'quran_word${widget.slno}.png';

          /// getting application doc directory's path in dir variable
          String dir = (await getExternalStorageDirectory()).path;

          /// if `filename` File exists in local system then return that file.
          /// This is the fastest among all.
          if (await File('$dir/$filename').exists()) {
            print('$dir/$filename');
            return File('$dir/$filename');
          }


          ///if file not present in local system then fetch it from server
          String url = '${widget.quranWordModels.image_url}';

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
            backgroundColor: Colors.red,
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