import 'package:dartz/dartz.dart';
import 'package:vpn/features/select_country/data/models/countries_model.dart';

abstract class CountryRepository {
  Future<Either<String, CountriesModel>> getCountriesList();
}
