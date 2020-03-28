import 'package:corona_tracker/backend/api/scrapper.dart';
import 'package:corona_tracker/frontend/pages/news_page/news_bloc.dart';
import 'package:corona_tracker/frontend/uis/news_ui.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    newsBloc.add();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("COVD-19 UPDATES"),
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
          stream: newsBloc.stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              final _items = snapshot.data;
              return ListView.builder(
                itemBuilder: (context, i) {
                  final news = _items[i];
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(8),
                      subtitle: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            news['datePublished']
                                .split("T")
                                .join(" ")
                                .split(".")[0],
                            style: GoogleFonts.lato(fontSize: 15),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          // CircleAvatar(
                          //   backgroundImage:
                          //       NetworkImage(news['publisher']['logo']['url']),
                          // ),

                          Text(
                            news["author"]["name"],
                            style:
                                GoogleFonts.lato(fontStyle: FontStyle.italic),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            news['headline'],
                            style: GoogleFonts.lato(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),

                          news['articleBody'] == null
                              ? Text("")
                              : Text(
                                  news['articleBody'],
                                  textAlign: TextAlign.center,
                                ),
                        ],
                      ),
                      title: Image.network(news['image']),
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return NewsUI(link: news['url']);
                        }));
                      },
                    ),
                  );
                },
                itemCount: _items.length,
              );
            }
          }),
    );
  }
}
