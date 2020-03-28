import "dart:convert";

import "package:html/parser.dart";
import "package:html/dom.dart";
import "package:http/http.dart" as http;

var baseUrl = "https://google.org/crisisresponse/covid19-map";

class Scrapper {
  Future<List<Map<String, dynamic>>> scrapCountry() async {
    final response = await http.get(baseUrl);
    List<Map<String, dynamic>> _list = [];
    final document = parse(response.body);

    List<Element> imageList = document.querySelectorAll(
        "div.card-content > div.table_container > div.table_scroll.table_height > table > tbody > tr > td.table_card_cell_col_0.table_card_cell_stringwithicon_type > img");
    List<Element> nameList = document.querySelectorAll(
        "div.card-content > div.table_container > div.table_scroll.table_height > table > tbody > tr > td.table_card_cell_col_0.table_card_cell_stringwithicon_type > span");
    List<Element> confirmedCasesList = document.querySelectorAll(
        "div.card-content > div.table_container > div.table_scroll.table_height > table > tbody > tr > td.table_card_cell_col_1.table_card_cell_int_type");
    List<Element> casesPerMillionList = document.querySelectorAll(
        "div.card-content > div.table_container > div.table_scroll.table_height > table > tbody > tr > td.table_card_cell_col_2.table_card_cell_float_type");
    List<Element> recoveredList = document.querySelectorAll(
        "div.card-content > div.table_container > div.table_scroll.table_height > table > tbody > tr > td.table_card_cell_col_3.table_card_cell_int_type");
    List<Element> deathList = document.querySelectorAll(
        "div.card-content > div.table_container > div.table_scroll.table_height > table > tbody > tr > td.table_card_cell_col_4.table_card_cell_int_type");

    for (int i = 0; i < imageList.length; i++) {
      _list.add({
        "name": nameList[i].text.trim(),
        "flag": imageList[i].attributes["src"],
        "confirmedCases": confirmedCasesList[i].text.trim(),
        "casesPerMillion": casesPerMillionList[i].text.trim(),
        "recovered": recoveredList[i].text.trim(),
        "death": deathList[i].text.trim(),
      });
    }
    return _list;
  }

  Future<List<Map<String, dynamic>>> scrapNews() async {
    String date = "";
    if (DateTime.now().month < 10) {
      date = "0${DateTime.now().month}-${DateTime.now().day}-20";
    } else {
      date = "${DateTime.now().month}-${DateTime.now().day}-20";
    }
    var url =
        "https://www.cnn.com/world/live-news/coronavirus-outbreak-$date-intl-hnk/index.html";
    final response = await http.get(url);
    final document = parse(response.body);
    List<Map<String, dynamic>> items = [];
    final a = document.outerHtml
        .split(","liveBlogUpdate": ")[1]
        .split("}</script><script")[0];
    final datas = json.decode(a);
    datas.forEach((data) {
      items.add(data);
    });
    return items;
  }
}
