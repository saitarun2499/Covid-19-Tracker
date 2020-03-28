import 'dart:async';

import 'package:corona_tracker/backend/models/base_model.dart';
import 'package:corona_tracker/backend/models/country_model.dart';

abstract class BaseBloc<T extends List<BaseModel>> {
  final countryFetcher = StreamController<List<Country>>.broadcast();

  dispose() {
    countryFetcher.close();
  }
}
