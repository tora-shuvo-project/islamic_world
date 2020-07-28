import 'dart:io';

import 'package:flutter/material.dart';
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';

class QuranWordPagesDetailsScreen extends StatelessWidget {
  final File downloadFile;
  final String taskNumber;
  QuranWordPagesDetailsScreen(this.downloadFile,this.taskNumber);


  File mydirectoryFile;
  final _scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green.withOpacity(.8),
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Task ${taskNumber}'),
        ),
        body:Center(
          child: downloadFile!=null?
          ZoomableWidget(child: Container(
              width: double.infinity,
              child: Image.file(downloadFile,width: double.infinity,height: double.infinity,)
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
