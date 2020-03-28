import 'package:corona_tracker/backend/api/scrapper.dart';
import 'package:corona_tracker/backend/models/country_model.dart';

class ApiProvider {
  Future<List<Country>> fetchCountry() async {
    final datas = await Scrapper().scrapCountry();
    List<Country> _items = [];
    for (var data in datas) {
      _items.add(Country.fromMap(data));
    }
    return _items;
  }
}
