import 'package:dartz/dartz.dart';
import 'package:vpn/features/select_country/data/models/countries_model.dart';
import 'package:vpn/features/select_country/domain/repositories/country_repository.dart';

class CountryUseCases {
  CountryRepository countryRepository;
  CountryUseCases({required this.countryRepository});

  Future<Either<String, CountriesModel>> getCountriesList() async {
    return countryRepository.getCountriesList();
  }
}
