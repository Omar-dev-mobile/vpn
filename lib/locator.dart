import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vpn/core/shared/datasources/api_service_init.dart';
import 'package:vpn/core/shared/datasources/cache_helper.dart';
import 'package:vpn/core/shared/datasources/network_info.dart';
import 'package:vpn/core/shared/repositories/home_repository.dart';
import 'package:vpn/core/shared/usecases/system_info_service.dart';
import 'package:vpn/features/home/data/datasources/api_service_home.dart';

import 'core/router/app_router.dart';
import 'features/home/presentation/bloc/home_cubit.dart';
import 'features/splash/presentation/bloc/splash_cubit.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  //BLOC

  locator.registerFactory(() => HomeCubit());
  locator.registerFactory(() => SplashCubit());

  // //USECASES
  locator
      .registerLazySingleton(() => InitRepository(apiServiceInit: locator()));

  // //CORE
  // locator.registerLazySingleton(() => NetworkInfoImpl(locator()));

  // //REPOSITORISE
  // locator.registerLazySingleton<AuthRepository>(
  //     () => AuthImplRepository(authService: locator(), cacheHelper: locator()));

  // //DATASOURSE
  locator.registerLazySingleton(() => ApiServiceHome());
  locator.registerLazySingleton(() => ApiServiceInit());

  // //EXTRNAL
  locator.registerLazySingleton(() => SharedPreferences.getInstance());
  locator.registerLazySingleton(() => InternetConnectionChecker());

  locator.registerLazySingleton(() => AppRouter());
  locator.registerLazySingleton(() => NetworkChecker(locator()));
  locator.registerLazySingleton(() => CacheHelper());
  locator.registerLazySingleton(() => SystemInfoService());
}
