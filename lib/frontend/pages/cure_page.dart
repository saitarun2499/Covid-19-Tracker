import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CurePage extends StatefulWidget {
  @override
  _CurePageState createState() => _CurePageState();
}

class _CurePageState extends State<CurePage> {
  Widget myCustomCard({
    String title,
    String image,
    String content,
  }) {
    return Card(
      elevation: 10,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Container(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            title.isEmpty
                ? Container()
                : Container(
                    color: Colors.purple,
                    width: double.infinity,
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(fontSize: 20),
                    ),
                  ),
            content.isEmpty
                ? Container()
                : Container(
                    color: Colors.black87,
                    width: double.infinity,
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      content,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(fontSize: 20),
                    ),
                  ),
            Image.network(image),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "PREVENTION",
          style: GoogleFonts.vollkorn(),
        ),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Column(
              children: <Widget>[
                myCustomCard(
                    title: "Be Safe From Corona Virus",
                    content:
                        "Stay Healthy And Prevent Yourself From This Dangerous Virus",
                    image:
                        "https://www.moh.gov.jm/wp-content/uploads/2020/01/moh-corona-observer-min.jpg"),
                myCustomCard(
                    title: "",
                    content: "",
                    image:
                        "https://www.researchgate.net/profile/Sadanand_Pandey/post/To_do_to_avoid_corona_virus/attachment/5e38c3d0cfe4a79f3e7d94c9/AS%3A854660910964748%401580778448706/download/b1.jpg"),
                myCustomCard(
                    title: "",
                    content: "",
                    image:
                        "https://s.abcnews.com/images/US/CovidSymptoms_v02_sd_hpEmbed_1x1_992.jpg"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
