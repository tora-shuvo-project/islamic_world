import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BrowserScreen extends StatefulWidget {

  String url;
  BrowserScreen(this.url);

  @override
  _BrowserScreenState createState() => _BrowserScreenState();
}

class _BrowserScreenState extends State<BrowserScreen> {

//  final Completer<WebViewController> _controller =
//  Completer<WebViewController>();

  WebViewController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: WebView(
            initialUrl: '${widget.url}',
            onWebViewCreated: (WebViewController webViewController) {
              _controller = webViewController;
            },
          )
        ),
      ),
    );
  }
}
