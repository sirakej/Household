import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PayStackView extends StatefulWidget {

  static const String id = 'paystack_links_page';

  /// String url of the giveaway
  final String checkout;

  const PayStackView({
    Key key,
    @required this.checkout,
  }) : super(key: key);

  @override
  _PayStackViewState createState() => _PayStackViewState();
}

class _PayStackViewState extends State<PayStackView> {

  final Completer<WebViewController> _controller = Completer<WebViewController>();

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
      body: WebView(
        initialUrl: (widget.checkout != null && widget.checkout != '' && widget.checkout.isNotEmpty)
            ? widget.checkout
            : 'https://google.com',
        javascriptMode: JavascriptMode.unrestricted,
        navigationDelegate: (navigation){
          //Listen for callback URL
          if(navigation.url.contains("https://householdexecutives.herokuapp.com")){
            Navigator.pop(context, 'success'); //close webview
          }
          if(navigation.url.contains('https://standard.paystack.co/close')){
            Navigator.pop(context, 'success'); //close webview
          }
          return NavigationDecision.navigate;
        },
        onWebViewCreated: (WebViewController webViewController){
          _controller.complete(webViewController);
        },
      ),
    );
  }

}
