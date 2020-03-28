import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsUI extends StatefulWidget {
  final String link;
  NewsUI({@required this.link});
  @override
  _NewsUIState createState() => _NewsUIState();
}

class _NewsUIState extends State<NewsUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        initialUrl: widget.link,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
