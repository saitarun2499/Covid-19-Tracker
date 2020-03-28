import 'package:corona_tracker/backend/api/api_provider.dart';
import 'package:corona_tracker/backend/blocs/base_bloc.dart';
import 'package:corona_tracker/backend/models/country_model.dart';

class CountryBloc extends BaseBloc {
  Stream<List<Country>> get stream => countryFetcher.stream.asBroadcastStream();

  add() async {
    final data = await ApiProvider().fetchCountry();
    countryFetcher.sink.add(data);
  }
}

final countryBloc = CountryBloc();
