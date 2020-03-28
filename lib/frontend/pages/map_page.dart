import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     "Coronavirus Map",
      //     style: GoogleFonts.vollkorn(),
      //   ),
      // ),
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: WebView(
          initialUrl: "https://www.bing.com/covid?ref=msn",
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
