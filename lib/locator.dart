import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vpn/core/error/exceotion_native.dart';
import 'package:vpn/core/native/VPNIOSManager.dart';
import 'package:vpn/core/shared/components/system_info_service.dart';
import 'package:vpn/core/shared/datasources/local/cache_gen_algorithm.dart';
import 'package:vpn/core/shared/datasources/local/secure_storage.dart';
import 'package:vpn/core/shared/datasources/remote/api_service_init.dart';
import 'package:vpn/core/shared/datasources/local/cache_helper.dart';
import 'package:vpn/core/shared/logic/theme_mode/theme_mode_cubit.dart';
import 'package:vpn/core/shared/utils/network_info.dart';
import 'package:vpn/core/shared/utils/init_usecases.dart';
import 'package:vpn/core/shared/utils/generate_keys.dart';
import 'package:vpn/features/auth/data/datasources/api_service_auth.dart';
import 'package:vpn/features/auth/data/repositories/auth_impl_repository.dart';
import 'package:vpn/features/auth/domain/repositories/auth_repository.dart';
import 'package:vpn/features/auth/domain/usecases/auth_usecases.dart';
import 'package:vpn/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:vpn/features/home/data/datasources/api_service_home.dart';
import 'package:vpn/features/home/data/repositories/home_imp_repository.dart';
import 'package:vpn/features/home/domain/repositories/home_repository.dart';
import 'package:vpn/features/home/domain/usecases/home_usecase.dart';
import 'package:vpn/features/home/presentation/logic/home_cubit/home_cubit.dart';
import 'package:vpn/features/home/presentation/logic/main_cubit/main_cubit.dart';
import 'package:vpn/features/profile/data/datasources/api_service_profile.dart';
import 'package:vpn/features/profile/data/repositories/profile_imp_repository.dart';
import 'package:vpn/features/profile/domain/repositories/profile_repository.dart';
import 'package:vpn/features/profile/domain/usecases/profile_usecases.dart';
import 'package:vpn/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:vpn/features/select_country/data/datasources/api_service_country.dart';
import 'package:vpn/features/select_country/data/repositories/country_imp_repository.dart';
import 'package:vpn/features/select_country/domain/repositories/country_repository.dart';
import 'package:vpn/features/select_country/domain/usecases/country_usecases.dart';
import 'package:vpn/features/select_country/presentation/cubit/country_cubit.dart';
import 'package:vpn/features/settings/data/datasources/api_service_setting.dart';
import 'package:vpn/features/settings/data/repositories/setting_repository_impl.dart';
import 'package:vpn/features/settings/domain/repositories/setting_repository.dart';
import 'package:vpn/features/settings/domain/usecases/setting_usecases.dart';
import 'package:vpn/features/settings/presentation/cubit/setting_cubit.dart';
import 'package:vpn/features/tarif/data/datasources/api_service_tarif.dart';
import 'package:vpn/features/tarif/data/repositories/tarif_imp_repository.dart';
import 'package:vpn/features/tarif/domain/repositories/tarif_repository.dart';
import 'package:vpn/features/tarif/domain/usecases/traif_usecases.dart';
import 'package:vpn/features/tarif/presentation/cubit/purchase/purchases_cubit.dart';
import 'package:vpn/features/tarif/presentation/cubit/tarif/tarif_cubit.dart';

import 'core/router/app_router.dart';
import 'core/shared/components/notification_service.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  //BLOC

  locator.registerFactory(() => HomeCubit());
  locator.registerLazySingleton(() => CountryCubit(locator()));
  locator.registerLazySingleton(() => ThemeModeCubit());
  locator.registerLazySingleton(() => PurchasesCubit(locator(), locator()));
  locator.registerLazySingleton(
      () => MainCubit(locator(), locator())..getDataServiceAcc());
  locator.registerLazySingleton(() => ProfileCubit(locator()));

  locator.registerFactory(
      () => AuthBloc(authUseCase: locator(), cacheHelper: locator()));
  locator.registerFactory(() => TarifCubit(locator(), locator()));
  locator.registerFactory(() => SettingCubit(locator()));

  // //USECASES
  locator.registerLazySingleton(() => InitUsecases(apiServiceInit: locator()));
  locator
      .registerLazySingleton(() => TraifUsecases(tarifRepository: locator()));
  locator.registerLazySingleton(() => AuthUseCase(locator()));
  locator.registerLazySingleton(
      () => CountryUseCases(countryRepository: locator()));

  locator.registerLazySingleton(() => HomeUseCase(locator()));
  locator.registerLazySingleton(() => ProfileUseCases(locator()));
  locator.registerLazySingleton(() => SettingUsecases(locator()));

  // //CORE
  // locator.registerLazySingleton(() => NetworkInfoImpl(locator()));

  // //REPOSITORISE
  locator.registerLazySingleton<TarifRepository>(
      () => TarifImpRepository(locator(), locator()));
  locator.registerLazySingleton<AuthRepository>(
      () => AuthImplRepository(authService: locator(), cacheHelper: locator()));
  locator.registerLazySingleton<CountryRepository>(
      () => CountryImpRepository(locator(), locator()));
  locator.registerLazySingleton<HomeRepository>(
      () => HomeImplRepository(locator()));
  locator.registerLazySingleton<ProfileRepository>(
      () => ProfileImpRepository(locator()));
  locator.registerLazySingleton<SettingRepository>(
      () => SettingRepositoryImpl(locator()));

  // //DATASOURSE
  locator.registerLazySingleton(() => ApiServiceHome());
  locator.registerLazySingleton(() => ApiServiceInit());
  locator.registerLazySingleton(() => ApiServiceTarif());
  locator.registerLazySingleton(() => ApiServiceAuth());
  locator.registerLazySingleton(() => ApiServiceCountry());
  locator.registerLazySingleton(() => ApiServiceProfile());
  locator.registerLazySingleton(() => ApiServiceSetting());

  // //EXTRNAL
  locator.registerLazySingleton(() => SharedPreferences.getInstance());
  locator.registerLazySingleton(() => InternetConnectionChecker());

  locator.registerLazySingleton(() => AppRouter());
  locator.registerLazySingleton(() => NetworkChecker(locator()));
  locator.registerLazySingleton(() => CacheHelper());
  locator.registerLazySingleton(() => RsaKeyHelper());
  locator.registerLazySingleton(() => CacheGenAlgorithm(locator()));
  locator.registerLazySingleton(() => SystemInfoService());
  locator.registerLazySingleton(() => VPNIOSManager());
  locator.registerLazySingleton(() => HandlerErrorNative());
  locator.registerLazySingleton(() => NotificationService());
  locator.registerLazySingleton(() => SecureStorage());
}
