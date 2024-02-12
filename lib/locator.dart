import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vpn/core/shared/components/system_info_service.dart';
import 'package:vpn/core/shared/datasources/local/cache_gen_algorithm.dart';
import 'package:vpn/core/shared/datasources/remote/api_service_init.dart';
import 'package:vpn/core/shared/datasources/local/cache_helper.dart';
import 'package:vpn/core/shared/usecases/network_info.dart';
import 'package:vpn/core/shared/usecases/init_usecases.dart';
import 'package:vpn/core/shared/usecases/generate_keys.dart';
import 'package:vpn/features/auth/data/datasources/api_service_auth.dart';
import 'package:vpn/features/auth/data/repositories/auth_impl_repository.dart';
import 'package:vpn/features/auth/domain/repositories/auth_repository.dart';
import 'package:vpn/features/auth/domain/usecases/auth_usecases.dart';
import 'package:vpn/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:vpn/features/home/data/datasources/api_service_home.dart';
import 'package:vpn/features/tarif/data/datasources/api_service_tarif.dart';
import 'package:vpn/features/tarif/data/repositories/tarif_imp_repository.dart';
import 'package:vpn/features/tarif/domain/repositories/tarif_repository.dart';
import 'package:vpn/features/tarif/domain/usecases/traif_usecases.dart';
import 'package:vpn/features/tarif/presentation/cubit/tarif_cubit.dart';

import 'core/router/app_router.dart';
import 'features/home/presentation/bloc/home_cubit.dart';
import 'features/splash/presentation/bloc/splash_cubit.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  //BLOC

  locator.registerFactory(() => HomeCubit());
  locator.registerFactory(() => SplashCubit());

  locator.registerFactory(
      () => AuthBloc(authUseCase: locator(), cacheHelper: locator()));
  locator.registerFactory(() => TarifCubit(locator()));

  // //USECASES
  locator.registerLazySingleton(() => InitUsecases(apiServiceInit: locator()));
  locator
      .registerLazySingleton(() => TraifUsecases(tarifRepository: locator()));
  locator.registerLazySingleton(() => AuthUseCase(locator()));

  // //CORE
  // locator.registerLazySingleton(() => NetworkInfoImpl(locator()));

  // //REPOSITORISE
  locator.registerLazySingleton<TarifRepository>(
      () => TarifImpRepository(locator()));
  locator.registerLazySingleton<AuthRepository>(
      () => AuthImplRepository(authService: locator(), cacheHelper: locator()));

  // //DATASOURSE
  locator.registerLazySingleton(() => ApiServiceHome());
  locator.registerLazySingleton(() => ApiServiceInit());
  locator.registerLazySingleton(() => ApiServiceTarif());
  locator.registerLazySingleton(() => ApiServiceAuth());

  // //EXTRNAL
  locator.registerLazySingleton(() => SharedPreferences.getInstance());
  locator.registerLazySingleton(() => InternetConnectionChecker());

  locator.registerLazySingleton(() => AppRouter());
  locator.registerLazySingleton(() => NetworkChecker(locator()));
  locator.registerLazySingleton(() => CacheHelper());
  locator.registerLazySingleton(() => RsaKeyHelper());
  locator.registerLazySingleton(() => CacheGenAlgorithm(locator()));
  locator.registerLazySingleton(() => SystemInfoService());
}
