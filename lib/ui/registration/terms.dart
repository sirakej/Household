import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Terms extends StatefulWidget {

  static const String id = 'terms';

  const Terms({Key key}) : super(key: key);

  @override
  _TermsState createState() => _TermsState();
}

class _TermsState extends State<Terms> {

  final Completer<WebViewController> _controller = Completer<WebViewController>();

  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF060D25),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Color(0XFF060D25),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          WebView(
            initialUrl: 'https://www.householdexecutivesltd.com/privacy-policy',
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: (finish) {
              if(!mounted)return;
              setState(() => _isLoading = false);
            },
            onWebViewCreated: (WebViewController webViewController){
              _controller.complete(webViewController);
            },
          ),
          _isLoading
              ? Center(
            child: CupertinoActivityIndicator(
              radius: 10,
            ),
          )
              : Stack(),
        ],
      ),
    );
  }

}

