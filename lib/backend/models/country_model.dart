import 'package:corona_tracker/backend/models/base_model.dart';

class Country extends BaseModel {
  final String name;
  final String flag;
  final String confirmedCases;
  final String casesPerMillion;
  final String recovered;
  final String death;

  Country(
      {this.casesPerMillion,
      this.confirmedCases,
      this.death,
      this.flag,
      this.name,
      this.recovered});

  factory Country.fromMap(Map<String, dynamic> data) {
    return Country(
      name: data['name'],
      flag: data['flag'],
      confirmedCases: data['confirmedCases'],
      casesPerMillion: data['casesPerMillion'],
      recovered: data['recovered'],
      death: data['death'],
    );
  }
}
