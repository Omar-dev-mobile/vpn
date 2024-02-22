import 'package:dartz/dartz.dart';
import 'package:vpn/core/error/execute_and_handle_error.dart';
import 'package:vpn/core/shared/datasources/local/cache_helper.dart';
import 'package:vpn/features/select_country/data/datasources/api_service_country.dart';
import 'package:vpn/features/select_country/data/models/countries_model.dart';
import 'package:vpn/features/select_country/domain/repositories/country_repository.dart';
import 'package:vpn/core/shared/extensions/extension.dart';

class CountryImpRepository extends CountryRepository {
  ApiServiceCountry apiServiceCountry;
  CacheHelper cacheHelper;
  CountryImpRepository(this.apiServiceCountry, this.cacheHelper);

  @override
  Future<Either<String, CountriesModel>> getCountriesList() async {
    return executeAndHandleError<CountriesModel>(() async {
      final ver = await cacheHelper.getVersionVpn();
      final countriesModel = await cacheHelper.getCountriesModel();
      final currentTime = DateTime.now();
      if (countriesModel != null &&
          countriesModel.dateSave != null &&
          currentTime.difference(countriesModel.dateSave!).inMinutes < 5) {
        return countriesModel;
      }
      var res = await apiServiceCountry.getCountriesList(ver);
      if ("${res.workStatus?.ver ?? 0}".safeParseToInt() > ver) {
        await cacheHelper.saveVersionVpn(res.workStatus?.ver ?? 0);
        res = await apiServiceCountry.getCountriesList(ver);
      }
      cacheHelper.saveCountriesModel(res..dateSave = DateTime.now());
      return res;
    });
  }
}
