import 'dart:async';
import 'package:corona_tracker/backend/api/scrapper.dart';

class NewsBloc {
  final newsFetcher = StreamController<List<Map<String, dynamic>>>.broadcast();

  Stream<List<Map<String, dynamic>>> get stream =>
      newsFetcher.stream.asBroadcastStream();

  add() async {
    List<Map<String, dynamic>> data = await Scrapper().scrapNews();
    newsFetcher.sink.add(data);
  }

  dispose() {
    newsFetcher.close();
  }
}

final newsBloc = NewsBloc();
