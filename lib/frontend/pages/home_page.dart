import 'package:corona_tracker/backend/blocs/country_bloc.dart';
import 'package:corona_tracker/backend/models/country_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading/indicator/ball_beat_indicator.dart';
import 'package:loading/loading.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _text = TextEditingController();
  List<Country> datas = [];

  Future<void> fetch() async {
    await countryBloc.add();
  }

  List<Country> _datas = [];

  findCountry() async {
    _datas = datas
        .where((data) =>
            data.name.toLowerCase().substring(0, _text.text.length) ==
            _text.text.toLowerCase().substring(0, _text.text.length))
        .toList();
    print(_datas.length);
  }

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    countryBloc.add();
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text(
            "COVD-19 TRACKER",
            style: GoogleFonts.vollkorn(),
          ),
        ),
        body: RefreshIndicator(
          backgroundColor: Colors.black,
          color: Colors.white,
          onRefresh: () => fetch(),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverStickyHeader(
                sticky: true,
                header: Container(
                  color: Color(0xff212121),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    child: TextFormField(
                      controller: _text,
                      enableSuggestions: true,
                      decoration: InputDecoration(
                        labelText: "Search Country",
                        labelStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        contentPadding: EdgeInsets.all(10),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        suffixIcon: IconButton(
                            icon: Icon(
                              Icons.clear,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              _text.clear();
                              setState(() {
                                _datas.clear();
                              });

                              countryBloc.add();
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                            }),
                      ),
                      onChanged: (val) {
                        setState(() {});
                        findCountry();
                      },
                    ),
                  ),
                ),
                sliver: _datas.isNotEmpty
                    ? SliverList(
                        delegate: SliverChildBuilderDelegate((context, i) {
                        final data = _datas[i];
                        return GestureDetector(
                          onTap: () {
                            return showDialog(
                                context: context,
                                builder: (ctx) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    title: Text(data.name),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        data.flag.contains("svg")
                                            ? (data.name
                                                    .toLowerCase()
                                                    .contains("nepal")
                                                ? SvgPicture.network(
                                                    "https://www.gstatic.com/onebox/sports/logos/flags/nepal_icon_square.svg",
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.2,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.6,
                                                  )
                                                : SvgPicture.network(
                                                    data.flag,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.2,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.6,
                                                  ))
                                            : Image.network(
                                                data.flag,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.2,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.6,
                                              ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.2,
                                          child: Column(
                                            children: <Widget>[
                                              Text(
                                                "CASES PER MILLION",
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.lato(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                data.casesPerMillion
                                                    .toUpperCase(),
                                                style: GoogleFonts.lato(
                                                    color: Colors.blue,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    actions: <Widget>[
                                      FlatButton(
                                          onPressed: () {
                                            Navigator.of(ctx).pop(true);
                                          },
                                          child: Text("Ok"))
                                    ],
                                  );
                                });
                          },
                          child: Card(
                            margin: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 5),
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 30),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.center,
                                    width: MediaQuery.of(context).size.width *
                                        0.24,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        data.flag.contains("svg")
                                            ? (data.name
                                                    .toLowerCase()
                                                    .contains("nepal")
                                                ? SvgPicture.network(
                                                    "https://www.gstatic.com/onebox/sports/logos/flags/nepal_icon_square.svg",
                                                    height: 30,
                                                    width: 30)
                                                : SvgPicture.network(data.flag,
                                                    height: 30, width: 30))
                                            : Image.network(data.flag,
                                                height: 30, width: 30),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        FittedBox(
                                          child: Text(
                                            data.name,
                                            maxLines: 2,
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.lato(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    margin: EdgeInsets.symmetric(horizontal: 1),
                                    child: Column(
                                      children: <Widget>[
                                        FittedBox(
                                          child: Text(
                                            "CASES",
                                            style: GoogleFonts.lato(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          data.confirmedCases.toUpperCase(),
                                          style: GoogleFonts.lato(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 2, right: 2),
                                    width: MediaQuery.of(context).size.width *
                                        0.24,
                                    child: Column(
                                      children: <Widget>[
                                        FittedBox(
                                          child: Text(
                                            "RECOVERED",
                                            maxLines: 1,
                                            style: GoogleFonts.lato(
                                                fontSize: 18,
                                                color: Colors.green,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          data.recovered.toUpperCase(),
                                          style: GoogleFonts.lato(
                                              fontSize: 18,
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 2, right: 2),
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    child: Column(
                                      children: <Widget>[
                                        FittedBox(
                                          child: Text(
                                            "DEATH",
                                            maxLines: 1,
                                            style: GoogleFonts.lato(
                                                color: Colors.red,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          data.death.toUpperCase(),
                                          style: GoogleFonts.lato(
                                              color: Colors.red,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }, childCount: _datas.length))
                    : StreamBuilder<List<Country>>(
                        stream: countryBloc.stream,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return SliverToBoxAdapter(
                              child: Center(
                                child: Loading(
                                  indicator: BallBeatIndicator(),
                                  size: 100,
                                ),
                              ),
                            );
                          } else {
                            datas = snapshot.data;
                            return SliverList(
                                delegate:
                                    SliverChildBuilderDelegate((context, i) {
                              final data = datas[i];
                              return GestureDetector(
                                onTap: () {
                                  return showDialog(
                                      context: context,
                                      builder: (ctx) {
                                        return AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          title: Text(data.name),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              data.flag.contains("svg")
                                                  ? (data.name
                                                          .toLowerCase()
                                                          .contains("nepal")
                                                      ? SvgPicture.network(
                                                          "https://www.gstatic.com/onebox/sports/logos/flags/nepal_icon_square.svg",
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.2,
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.6,
                                                        )
                                                      : SvgPicture.network(
                                                          data.flag,
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.2,
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.6,
                                                        ))
                                                  : Image.network(
                                                      data.flag,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.2,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.6,
                                                    ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.2,
                                                child: Column(
                                                  children: <Widget>[
                                                    Text(
                                                      "CASES PER MILLION",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: GoogleFonts.lato(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      data.casesPerMillion
                                                          .toUpperCase(),
                                                      style: GoogleFonts.lato(
                                                          color: Colors.blue,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          actions: <Widget>[
                                            FlatButton(
                                                onPressed: () {
                                                  Navigator.of(ctx).pop(true);
                                                },
                                                child: Text("Ok"))
                                          ],
                                        );
                                      });
                                },
                                child: Card(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 5),
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 30),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Container(
                                          alignment: Alignment.center,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.24,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              data.flag.contains("svg")
                                                  ? (data.name
                                                          .toLowerCase()
                                                          .contains("nepal")
                                                      ? SvgPicture.network(
                                                          "https://www.gstatic.com/onebox/sports/logos/flags/nepal_icon_square.svg",
                                                          height: 30,
                                                          width: 30)
                                                      : SvgPicture.network(
                                                          data.flag,
                                                          height: 30,
                                                          width: 30))
                                                  : Image.network(data.flag,
                                                      height: 30, width: 30),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              FittedBox(
                                                child: Text(
                                                  data.name,
                                                  maxLines: 2,
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.lato(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.2,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 1),
                                          child: Column(
                                            children: <Widget>[
                                              FittedBox(
                                                child: Text(
                                                  "CASES",
                                                  style: GoogleFonts.lato(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                data.confirmedCases
                                                    .toUpperCase(),
                                                style: GoogleFonts.lato(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: 2, right: 2),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.24,
                                          child: Column(
                                            children: <Widget>[
                                              FittedBox(
                                                child: Text(
                                                  "RECOVERED",
                                                  maxLines: 1,
                                                  style: GoogleFonts.lato(
                                                      fontSize: 18,
                                                      color: Colors.green,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                data.recovered.toUpperCase(),
                                                style: GoogleFonts.lato(
                                                    fontSize: 18,
                                                    color: Colors.green,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: 2, right: 2),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.2,
                                          child: Column(
                                            children: <Widget>[
                                              FittedBox(
                                                child: Text(
                                                  "DEATH",
                                                  maxLines: 1,
                                                  style: GoogleFonts.lato(
                                                      color: Colors.red,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                data.death.toUpperCase(),
                                                style: GoogleFonts.lato(
                                                    color: Colors.red,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }, childCount: datas.length));
                          }
                        }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
